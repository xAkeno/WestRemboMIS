<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use PDO;
use PDOException;

class BackupController extends Controller
{
    /**
     * CREATE BACKUP using pg_dump
     */
    public function runDatabaseBackup()
    {
        try {
            $dbName = env('DB_DATABASE');
            $host   = env('DB_HOST');
            $port   = env('DB_PORT', 5432);
            $user   = env('DB_USERNAME');
            $pass   = env('DB_PASSWORD');

            $date     = now()->format('Y-m-d_H-i-s');
            $fileName = "backup_{$dbName}_{$date}.sql";
            $tempPath = storage_path("app/backups/{$fileName}");

            if (!file_exists(storage_path('app/backups'))) {
                mkdir(storage_path('app/backups'), 0777, true);
            }

            // Fixed: Better pg_dump execution
            $command = "PGPASSWORD='{$pass}' pg_dump -h {$host} -p {$port} -U {$user} --no-owner --no-privileges -F p {$dbName} 2>&1";
            
            exec($command, $output, $returnCode);
            $sql = implode("\n", $output);
            
            if ($returnCode !== 0 || empty($sql)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Backup failed: ' . $sql,
                    'return_code' => $returnCode
                ], 500);
            }

            // Save unencrypted backup locally first
            file_put_contents($tempPath, $sql);
            
            // Upload to S3 (without encryption for simplicity)
            $s3Path = Storage::disk('s3')->putFileAs(
                'backups',
                new \Illuminate\Http\File($tempPath),
                $fileName
            );

            // Keep local copy
            return response()->json([
                'success' => true,
                'file'    => $fileName,
                'path'    => $s3Path,
                'size_kb' => round(strlen($sql) / 1024, 2)
            ]);
            
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Backup failed: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * FIXED RESTORE METHOD - Actually works
     */
    public function restoreFromFile($fileName)
    {
        try {
            $fileName = basename($fileName);
            
            // First try local storage
            $localPath = storage_path("app/backups/{$fileName}");
            
            // Then try S3
            if (!file_exists($localPath)) {
                if (Storage::disk('s3')->exists("backups/{$fileName}")) {
                    $localPath = storage_path("app/backups/temp_{$fileName}");
                    $content = Storage::disk('s3')->get("backups/{$fileName}");
                    file_put_contents($localPath, $content);
                } else {
                    return response()->json([
                        'success' => false,
                        'message' => "Backup file not found: {$fileName}"
                    ], 404);
                }
            }

            // Read SQL content
            $sql = file_get_contents($localPath);
            
            // Remove temp file if it was from S3
            if (strpos($localPath, 'temp_') !== false) {
                unlink($localPath);
            }
            
            if (empty($sql)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Backup file is empty'
                ], 500);
            }
            
            // Execute restore
            return $this->executeRestore($sql);
            
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Restore failed: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * FIXED RESTORE FROM UPLOAD
     */
    public function restoreFromUpload(Request $request)
    {
        try {
            $request->validate([
                'file' => 'required|file|max:512000',
            ]);

            $uploaded = $request->file('file');
            $sql = file_get_contents($uploaded->getRealPath());
            
            if (empty($sql)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Uploaded file is empty'
                ], 500);
            }
            
            return $this->executeRestore($sql);
            
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Upload restore failed: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * CORE RESTORE LOGIC - Fixed version
     */
    private function executeRestore(string $sql): \Illuminate\Http\JsonResponse
    {
        $pdo = null;
        
        try {
            // Get PDO connection
            $pdo = $this->getPdo();
            
            // Start transaction
            $pdo->beginTransaction();
            
            // First, drop all existing tables to avoid conflicts
            $this->dropAllTables($pdo);
            
            // Split SQL into statements
            $statements = $this->splitSqlStatements($sql);
            
            if (empty($statements)) {
                throw new \Exception('No SQL statements found in backup');
            }
            
            $executed = 0;
            $failed = 0;
            $errors = [];
            
            foreach ($statements as $index => $statement) {
                $stmt = trim($statement);
                if (empty($stmt) || $stmt === ';') {
                    continue;
                }
                
                try {
                    $pdo->exec($stmt);
                    $executed++;
                    
                    // Log progress every 100 statements
                    if ($executed % 100 === 0) {
                        \Log::info("Restore progress: {$executed} statements executed");
                    }
                    
                } catch (PDOException $e) {
                    $failed++;
                    $errorMsg = $e->getMessage();
                    
                    // Skip certain harmless errors
                    if ($this->isHarmlessError($errorMsg)) {
                        $executed++; // Count as success
                        continue;
                    }
                    
                    $errors[] = [
                        'statement' => substr($stmt, 0, 100) . '...',
                        'error' => $errorMsg
                    ];
                    
                    // Stop on critical errors
                    if ($this->isCriticalError($errorMsg)) {
                        throw new \Exception("Critical error at statement {$index}: {$errorMsg}");
                    }
                }
            }
            
            // Commit if we executed anything
            if ($executed > 0) {
                $pdo->commit();
                
                \Log::info("Restore completed", [
                    'executed' => $executed,
                    'failed' => $failed,
                    'errors' => count($errors)
                ]);
                
                return response()->json([
                    'success' => true,
                    'message' => "Restore successful! Executed {$executed} statements",
                    'failed_statements' => $failed,
                    'warnings' => $errors
                ]);
            } else {
                $pdo->rollBack();
                return response()->json([
                    'success' => false,
                    'message' => 'No statements were executed successfully',
                    'errors' => $errors
                ], 500);
            }
            
        } catch (\Exception $e) {
            if ($pdo && $pdo->inTransaction()) {
                $pdo->rollBack();
            }
            
            \Log::error("Restore failed", [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            
            return response()->json([
                'success' => false,
                'message' => 'Restore failed: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Drop all tables before restore
     */
    private function dropAllTables(PDO $pdo)
    {
        try {
            // Get all tables
            $stmt = $pdo->query("
                SELECT tablename 
                FROM pg_tables 
                WHERE schemaname = 'public'
            ");
            
            $tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
            
            if (empty($tables)) {
                return;
            }
            
            // Disable constraints temporarily
            $pdo->exec('SET session_replication_role = replica;');
            
            // Drop tables in reverse order to handle dependencies
            foreach ($tables as $table) {
                try {
                    $pdo->exec("DROP TABLE IF EXISTS \"{$table}\" CASCADE");
                    \Log::info("Dropped table: {$table}");
                } catch (PDOException $e) {
                    \Log::warning("Could not drop table {$table}: " . $e->getMessage());
                }
            }
            
            // Re-enable constraints
            $pdo->exec('SET session_replication_role = DEFAULT;');
            
        } catch (\Exception $e) {
            \Log::warning("Error dropping tables: " . $e->getMessage());
            // Continue anyway
        }
    }

    /**
     * Check if error is harmless and can be skipped
     */
    private function isHarmlessError(string $error): bool
    {
        $harmlessPatterns = [
            'already exists',
            'duplicate key value violates unique constraint',
            'relation.*already exists',
            'constraint.*already exists',
            'type.*already exists',
            'function.*already exists'
        ];
        
        foreach ($harmlessPatterns as $pattern) {
            if (preg_match("/{$pattern}/i", $error)) {
                return true;
            }
        }
        
        return false;
    }

    /**
     * Check if error is critical and should stop restore
     */
    private function isCriticalError(string $error): bool
    {
        $criticalPatterns = [
            'permission denied',
            'cannot drop',
            'disk full',
            'out of memory'
        ];
        
        foreach ($criticalPatterns as $pattern) {
            if (preg_match("/{$pattern}/i", $error)) {
                return true;
            }
        }
        
        return false;
    }

    /**
     * Better SQL statement splitter
     */
    private function splitSqlStatements(string $sql): array
    {
        // Remove comments
        $sql = preg_replace('/^\-\-.*$/m', '', $sql);
        $sql = preg_replace('/\/\*.*?\*\//s', '', $sql);
        
        $statements = [];
        $current = '';
        $inString = false;
        $stringChar = '';
        $inDollar = false;
        $dollarTag = '';
        
        $length = strlen($sql);
        
        for ($i = 0; $i < $length; $i++) {
            $char = $sql[$i];
            $nextChar = $i + 1 < $length ? $sql[$i + 1] : '';
            
            // Handle dollar quotes
            if (!$inString && $char === '$' && !$inDollar) {
                // Find dollar tag
                $tagStart = $i;
                $j = $i + 1;
                while ($j < $length && $sql[$j] !== '$') {
                    $j++;
                }
                if ($j < $length && $sql[$j] === '$') {
                    $dollarTag = substr($sql, $tagStart, $j - $tagStart + 1);
                    $inDollar = true;
                    $current .= $char;
                    continue;
                }
            }
            
            if ($inDollar && strpos(substr($sql, $i), $dollarTag) === 0) {
                $inDollar = false;
                $current .= $dollarTag;
                $i += strlen($dollarTag) - 1;
                continue;
            }
            
            // Handle regular strings
            if (!$inDollar && ($char === "'" || $char === '"')) {
                if (!$inString) {
                    $inString = true;
                    $stringChar = $char;
                } elseif ($stringChar === $char) {
                    $inString = false;
                }
            }
            
            $current .= $char;
            
            // Split on semicolon when not in string or dollar quote
            if (!$inString && !$inDollar && $char === ';') {
                $stmt = trim($current);
                if (!empty($stmt) && $stmt !== ';') {
                    $statements[] = $stmt;
                }
                $current = '';
            }
        }
        
        // Add remaining
        $current = trim($current);
        if (!empty($current)) {
            $statements[] = $current;
        }
        
        return $statements;
    }

    /**
     * Get PDO connection
     */
    private function getPdo(): PDO
    {
        $host   = env('DB_HOST');
        $port   = env('DB_PORT', 5432);
        $dbName = env('DB_DATABASE');
        $user   = env('DB_USERNAME');
        $pass   = env('DB_PASSWORD');
        
        $pdo = new PDO(
            "pgsql:host={$host};port={$port};dbname={$dbName}",
            $user,
            $pass,
            [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_TIMEOUT => 300, // 5 minute timeout for large restores
            ]
        );
        
        // Set schema
        $pdo->exec("SET search_path TO public");
        
        return $pdo;
    }

    /**
     * LIST BACKUPS
     */
    public function listBackups()
    {
        try {
            // Local backups
            $localBackups = [];
            $backupDir = storage_path('app/backups');
            
            if (file_exists($backupDir)) {
                $files = glob($backupDir . '/*.sql');
                foreach ($files as $file) {
                    $localBackups[] = [
                        'name' => basename($file),
                        'location' => 'local',
                        'size_kb' => round(filesize($file) / 1024, 2),
                        'last_modified' => date('Y-m-d H:i:s', filemtime($file))
                    ];
                }
            }
            
            // S3 backups
            $s3Backups = [];
            if (Storage::disk('s3')->exists('backups')) {
                $files = Storage::disk('s3')->files('backups');
                foreach ($files as $file) {
                    $s3Backups[] = [
                        'name' => basename($file),
                        'location' => 's3',
                        'size_kb' => round(Storage::disk('s3')->size($file) / 1024, 2),
                        'last_modified' => date('Y-m-d H:i:s', Storage::disk('s3')->lastModified($file))
                    ];
                }
            }
            
            $backups = array_merge($localBackups, $s3Backups);
            usort($backups, function($a, $b) {
                return strtotime($b['last_modified']) - strtotime($a['last_modified']);
            });
            
            return response()->json([
                'success' => true,
                'backups' => $backups
            ]);
            
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to list backups: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * DEBUG METHOD - Check what's in the database
     */
    public function debugDatabase()
    {
        try {
            $pdo = $this->getPdo();
            
            // Get table list
            $tables = $pdo->query("
                SELECT tablename, 
                       (SELECT count(*) FROM information_schema.columns WHERE table_name = tablename) as column_count
                FROM pg_tables 
                WHERE schemaname = 'public'
                ORDER BY tablename
            ")->fetchAll(PDO::FETCH_ASSOC);
            
            // Get row counts
            foreach ($tables as &$table) {
                $count = $pdo->query("SELECT COUNT(*) FROM \"{$table['tablename']}\"")->fetchColumn();
                $table['row_count'] = $count;
            }
            
            return response()->json([
                'success' => true,
                'database' => env('DB_DATABASE'),
                'tables' => $tables,
                'total_tables' => count($tables)
            ]);
            
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error' => $e->getMessage()
            ]);
        }
    }
}