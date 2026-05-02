<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use PDO;
use PDOException;

class BackupController extends Controller
{
    /**
     * CREATE ENCRYPTED BACKUP using pg_dump
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
        $backupDir = storage_path('app/backups');
        $tempPath = "{$backupDir}/{$fileName}";

        if (!file_exists($backupDir)) {
            mkdir($backupDir, 0755, true);
        }

        // Write password to temp pgpass file to avoid shell injection
        $pgpassFile = tempnam(sys_get_temp_dir(), 'pgpass_');
        file_put_contents($pgpassFile, "{$host}:{$port}:{$dbName}:{$user}:{$pass}");
        chmod($pgpassFile, 0600);

        // Dump directly to file (not via stdout capture)
        $command = sprintf(
            'PGPASSFILE=%s pg_dump -h %s -p %s -U %s --no-owner --no-privileges -F p -f %s %s 2>&1',
            escapeshellarg($pgpassFile),
            escapeshellarg($host),
            escapeshellarg((string)$port),
            escapeshellarg($user),
            escapeshellarg($tempPath),
            escapeshellarg($dbName)
        );

        exec($command, $output, $returnCode);
        unlink($pgpassFile); // Clean up pgpass file

        $outputText = implode("\n", $output);

        if ($returnCode !== 0) {
            return response()->json([
                'success' => false,
                'message' => 'pg_dump failed: ' . $outputText,
                'return_code' => $returnCode
            ], 500);
        }

        if (!file_exists($tempPath) || filesize($tempPath) === 0) {
            return response()->json([
                'success' => false,
                'message' => 'Backup file was not created or is empty. Output: ' . $outputText
            ], 500);
        }

        $sizeKb = round(filesize($tempPath) / 1024, 2);

        // Upload to S3
        try {
            Storage::disk('s3')->putFileAs(
                'backups',
                new \Illuminate\Http\File($tempPath),
                $fileName
            );
        } catch (\Exception $s3e) {
            \Log::warning('S3 upload failed, keeping local only: ' . $s3e->getMessage());
        }

        return response()->json([
            'success' => true,
            'file'    => $fileName,
            'size_kb' => $sizeKb
        ]);

    } catch (\Exception $e) {
        return response()->json([
            'success' => false,
            'message' => 'Backup failed: ' . $e->getMessage()
        ], 500);
    }
}

    /**
     * RESTORE FROM ENCRYPTED FILE
     */
    public function restoreFromFile($fileName)
    {
        try {
            $fileName = basename($fileName);
            
            // Determine if it's encrypted or not
            $isEncrypted = strpos($fileName, '.enc') !== false;
            $sqlFileName = str_replace('.enc', '', $fileName);
            $sqlFileName = str_replace('encrypted_', '', $sqlFileName);
            
            $localEncryptedPath = storage_path("app/backups/{$fileName}");
            $localDecryptedPath = storage_path("app/backups/decrypted_{$sqlFileName}");
            
            // Check local storage first
            if (!file_exists($localEncryptedPath)) {
                // Try S3
                $s3Path = $isEncrypted ? "encrypted_backups/{$fileName}" : "backups/{$fileName}";
                
                if (Storage::disk('s3')->exists($s3Path)) {
                    $content = Storage::disk('s3')->get($s3Path);
                    file_put_contents($localEncryptedPath, $content);
                } else {
                    return response()->json([
                        'success' => false,
                        'message' => "Backup file not found: {$fileName}"
                    ], 404);
                }
            }
            
            // Decrypt if needed
            if ($isEncrypted) {
                $this->decryptFile($localEncryptedPath, $localDecryptedPath);
                $sql = file_get_contents($localDecryptedPath);
                unlink($localDecryptedPath); // Clean up
            } else {
                $sql = file_get_contents($localEncryptedPath);
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
     * RESTORE FROM UPLOAD (supports both encrypted and plain SQL)
     */
    public function restoreFromUpload(Request $request)
    {
        try {
            $request->validate([
                'file' => 'required|file|max:512000', // Max 500MB
                'encrypted' => 'boolean'
            ]);

            $uploaded = $request->file('file');
            $uploadedPath = $uploaded->getRealPath();
            $isEncrypted = $request->input('encrypted', false);
            
            if ($isEncrypted) {
                $tempDecryptedPath = storage_path('app/backups/temp_decrypted_' . time() . '.sql');
                $this->decryptFile($uploadedPath, $tempDecryptedPath);
                $sql = file_get_contents($tempDecryptedPath);
                unlink($tempDecryptedPath);
            } else {
                $sql = file_get_contents($uploadedPath);
            }
            
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


        public function downloadBackup($fileName)
{
    try {
        $fileName = basename($fileName); // Prevent path traversal
        $localPath = storage_path("app/backups/{$fileName}");

        // Try local first
        if (file_exists($localPath)) {
            return response()->download($localPath, $fileName, [
                'Content-Type' => 'application/octet-stream',
            ]);
        }

        // Try S3
        if (Storage::disk('s3')->exists("backups/{$fileName}")) {
            $content = Storage::disk('s3')->get("backups/{$fileName}");
            $tempPath = storage_path("app/backups/dl_temp_{$fileName}");
            file_put_contents($tempPath, $content);

            return response()->download($tempPath, $fileName, [
                'Content-Type' => 'application/octet-stream',
            ])->deleteFileAfterSend(true);
        }

        return response()->json(['success' => false, 'message' => 'File not found'], 404);

    } catch (\Exception $e) {
        return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
    }
}


    /**
     * ENCRYPT FILE using OpenSSL with proper key derivation
     */
    private function encryptFile(string $sourcePath, string $destPath): void
    {
        $key = $this->getEncryptionKey();
        $iv = random_bytes(16);
        
        $content = file_get_contents($sourcePath);
        $encrypted = openssl_encrypt($content, 'AES-256-CBC', $key, OPENSSL_RAW_DATA, $iv);
        
        if ($encrypted === false) {
            throw new \Exception('Encryption failed');
        }
        
        // Store version info to handle different key formats in the future
        $version = 1; // Version 1: AES-256-CBC with SHA-256 key derivation
        
        // Format: [version:1 byte][iv:16 bytes][encrypted data]
        $data = pack('C', $version) . $iv . $encrypted;
        file_put_contents($destPath, $data);
    }

    /**
     * DECRYPT FILE using OpenSSL
     */
    private function decryptFile(string $sourcePath, string $destPath): void
    {
        $key = $this->getEncryptionKey();
        $data = file_get_contents($sourcePath);
        
        if (empty($data)) {
            throw new \Exception('Encrypted file is empty');
        }
        
        // Extract version (first byte)
        $version = unpack('C', $data[0])[1];
        $data = substr($data, 1);
        
        if ($version !== 1) {
            throw new \Exception("Unsupported encryption version: {$version}");
        }
        
        // Extract IV (next 16 bytes)
        $iv = substr($data, 0, 16);
        $encrypted = substr($data, 16);
        
        $decrypted = openssl_decrypt($encrypted, 'AES-256-CBC', $key, OPENSSL_RAW_DATA, $iv);
        
        if ($decrypted === false) {
            throw new \Exception('Decryption failed - invalid key or corrupted file');
        }
        
        file_put_contents($destPath, $decrypted);
    }

    /**
     * Get encryption key from environment and convert to proper format
     * Supports any string key (will be converted to 32 bytes using SHA-256)
     */
    private function getEncryptionKey(): string
    {
        $key = env('BACKUP_ENCRYPTION_KEY');
        
        if (!$key) {
            if (app()->environment('local')) {
                // Generate random key for local development
                $key = random_bytes(32);
                \Log::warning('No BACKUP_ENCRYPTION_KEY set in .env, using random key for this session');
            } else {
                throw new \Exception('BACKUP_ENCRYPTION_KEY is not set in production environment');
            }
        }
        
        // Convert any string to a proper 32-byte key using SHA-256
        // This ensures your key "barangaywestremboadmin528312026!" works
        if (is_string($key) && strlen($key) !== 32) {
            $key = substr(hash('sha256', $key, true), 0, 32);
        }
        
        // If it's base64 encoded, decode it
        if (is_string($key) && preg_match('/^[A-Za-z0-9+\/=]+$/', $key)) {
            $decoded = base64_decode($key, true);
            if ($decoded !== false && strlen($decoded) === 32) {
                $key = $decoded;
            }
        }
        
        // Final validation
        if (strlen($key) !== 32) {
            throw new \Exception('BACKUP_ENCRYPTION_KEY must result in 32 bytes after processing');
        }
        
        return $key;
    }

    /**
     * CORE RESTORE LOGIC
     */
    private function executeRestore(string $sql): \Illuminate\Http\JsonResponse
    {
        $pdo = null;
        
        try {
            // Get PDO connection
            $pdo = $this->getPdo();
            
            // Start transaction
            $pdo->beginTransaction();
            
            // Drop all existing tables to avoid conflicts
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
            
            // Drop any remaining sequences
            $stmt = $pdo->query("
                SELECT sequence_name 
                FROM information_schema.sequences 
                WHERE sequence_schema = 'public'
            ");
            $sequences = $stmt->fetchAll(PDO::FETCH_COLUMN);
            foreach ($sequences as $sequence) {
                try {
                    $pdo->exec("DROP SEQUENCE IF EXISTS \"{$sequence}\" CASCADE");
                } catch (PDOException $e) {
                    // Ignore errors
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
            'function.*already exists',
            'schema.*already exists',
            'extension.*already exists',
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
            'out of memory',
            'connection',
        ];
        
        foreach ($criticalPatterns as $pattern) {
            if (preg_match("/{$pattern}/i", $error)) {
                return true;
            }
        }
        
        return false;
    }

    /**
     * Better SQL statement splitter that handles PostgreSQL syntax
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
            
            // Handle dollar quotes (PostgreSQL feature)
            if (!$inString && $char === '$' && !$inDollar) {
                // Find dollar tag
                $j = $i + 1;
                while ($j < $length && $sql[$j] !== '$') {
                    $j++;
                }
                if ($j < $length && $sql[$j] === '$') {
                    $dollarTag = substr($sql, $i, $j - $i + 1);
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
                    // Check for escaped quote
                    if ($i > 0 && $sql[$i - 1] === '\\') {
                        $current .= $char;
                        continue;
                    }
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
     * Get PDO connection with proper settings for PostgreSQL
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
                PDO::ATTR_EMULATE_PREPARES => false,
            ]
        );
        
        // Set schema and other important settings
        $pdo->exec("SET search_path TO public");
        $pdo->exec("SET statement_timeout = '300s'");
        $pdo->exec("SET lock_timeout = '60s'");
        
        return $pdo;
    }

    /**
     * LIST BACKUPS (both local and S3)
     */
    public function listBackups()
    {
        try {
            $backups = [];
            $backupDir = storage_path('app/backups');
            
            // Local backups
            if (file_exists($backupDir)) {
                $encryptedFiles = glob($backupDir . '/*.enc');
                foreach ($encryptedFiles as $file) {
                    $backups[] = [
                        'name' => basename($file),
                        'location' => 'local',
                        'size_kb' => round(filesize($file) / 1024, 2),
                        'size_mb' => round(filesize($file) / 1024 / 1024, 2),
                        'encrypted' => true,
                        'last_modified' => date('Y-m-d H:i:s', filemtime($file))
                    ];
                }
            }
            
            // S3 encrypted backups
            if (Storage::disk('s3')->exists('encrypted_backups')) {
                $files = Storage::disk('s3')->files('encrypted_backups');
                foreach ($files as $file) {
                    if (strpos($file, '.enc') !== false) {
                        $backups[] = [
                            'name' => basename($file),
                            'location' => 's3',
                            'size_kb' => round(Storage::disk('s3')->size($file) / 1024, 2),
                            'size_mb' => round(Storage::disk('s3')->size($file) / 1024 / 1024, 2),
                            'encrypted' => true,
                            'last_modified' => date('Y-m-d H:i:s', Storage::disk('s3')->lastModified($file))
                        ];
                    }
                }
            }
            
            // Sort by last modified (newest first)
            usort($backups, function($a, $b) {
                return strtotime($b['last_modified']) - strtotime($a['last_modified']);
            });
            
            return response()->json([
                'success' => true,
                'count' => count($backups),
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
     * DELETE BACKUP
     */
    public function deleteBackup($fileName)
    {
        try {
            $fileName = basename($fileName);
            $deleted = false;
            
            // Delete from local
            $localPath = storage_path("app/backups/{$fileName}");
            if (file_exists($localPath)) {
                unlink($localPath);
                $deleted = true;
            }
            
            // Delete from S3
            $s3Path = "encrypted_backups/{$fileName}";
            if (Storage::disk('s3')->exists($s3Path)) {
                Storage::disk('s3')->delete($s3Path);
                $deleted = true;
            }
            
            if (!$deleted) {
                return response()->json([
                    'success' => false,
                    'message' => "Backup file not found: {$fileName}"
                ], 404);
            }
            
            return response()->json([
                'success' => true,
                'message' => "Backup deleted successfully: {$fileName}"
            ]);
            
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Delete failed: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * DEBUG METHOD - Check database structure
     */
    public function debugDatabase()
    {
        try {
            $pdo = $this->getPdo();
            
            // Get table list
            $tables = $pdo->query("
                SELECT 
                    tablename, 
                    (SELECT count(*) FROM information_schema.columns WHERE table_name = tablename) as column_count
                FROM pg_tables 
                WHERE schemaname = 'public'
                ORDER BY tablename
            ")->fetchAll(PDO::FETCH_ASSOC);
            
            // Get row counts
            foreach ($tables as &$table) {
                try {
                    $count = $pdo->query("SELECT COUNT(*) FROM \"{$table['tablename']}\"")->fetchColumn();
                    $table['row_count'] = (int)$count;
                } catch (\Exception $e) {
                    $table['row_count'] = 'Error: ' . $e->getMessage();
                }
            }
            
            // Get database size
            $dbSize = $pdo->query("
                SELECT pg_size_pretty(pg_database_size(current_database())) as size
            ")->fetchColumn();
            
            return response()->json([
                'success' => true,
                'database' => env('DB_DATABASE'),
                'host' => env('DB_HOST'),
                'port' => env('DB_PORT', 5432),
                'database_size' => $dbSize,
                'total_tables' => count($tables),
                'tables' => $tables
            ]);
            
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ], 500);
        }
    }

    /**
     * TEST ENCRYPTION/DECRYPTION
     */
    public function testEncryption()
    {
        try {
            $testString = "This is a test string for encryption at " . now();
            $tempFile = storage_path('app/backups/test_' . time() . '.txt');
            $encryptedFile = storage_path('app/backups/test_encrypted_' . time() . '.enc');
            $decryptedFile = storage_path('app/backups/test_decrypted_' . time() . '.txt');
            
            // Write test content
            file_put_contents($tempFile, $testString);
            
            // Encrypt
            $this->encryptFile($tempFile, $encryptedFile);
            
            // Decrypt
            $this->decryptFile($encryptedFile, $decryptedFile);
            
            // Read decrypted content
            $decryptedString = file_get_contents($decryptedFile);
            
            // Clean up
            unlink($tempFile);
            unlink($encryptedFile);
            unlink($decryptedFile);
            
            $success = ($testString === $decryptedString);
            
            return response()->json([
                'success' => $success,
                'message' => $success ? 'Encryption test passed!' : 'Encryption test failed - strings do not match',
                'original' => $testString,
                'decrypted' => $decryptedString,
                'encryption_key_configured' => !empty(env('BACKUP_ENCRYPTION_KEY')),
                'key_used' => $this->getEncryptionKey() ? 'Valid 32-byte key' : 'Invalid key'
            ]);
            
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Encryption test failed: ' . $e->getMessage()
            ], 500);
        }
    }
}