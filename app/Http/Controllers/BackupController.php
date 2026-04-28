<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use PDO;
use PDOException;

class BackupController extends Controller
{
    /**
     * CREATE BACKUP using pg_dump (or PDO fallback)
     */
    public function runDatabaseBackup()
    {
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

        putenv("PGPASSWORD={$pass}");
        $command = "pg_dump -h {$host} -p {$port} -U {$user} -F p {$dbName} 2>&1";
        $sql     = shell_exec($command);

        if (!$sql || str_starts_with(trim($sql), 'pg_dump:')) {
            return response()->json([
                'success' => false,
                'message' => 'Backup failed: ' . $sql,
            ], 500);
        }

        file_put_contents($tempPath, $sql);

        // Encrypt
        $key       = env('BACKUP_ENCRYPTION_KEY');
        $encrypted = base64_encode(
            openssl_encrypt($sql, 'AES-256-CBC', $key, 0, substr($key, 0, 16))
        );
        unlink($tempPath);

        $fileName = "backup_{$dbName}_{$date}.sql.enc";
        $tempPath = storage_path("app/backups/{$fileName}");
        file_put_contents($tempPath, $encrypted);

        $s3Path = Storage::disk('s3')->putFileAs(
            'backups',
            new \Illuminate\Http\File($tempPath),
            $fileName
        );

        return response()->json([
            'success' => true,
            'file'    => $fileName,
            'path'    => $s3Path,
        ]);
    }

    /**
     * GET PDO connection
     */
    private function getPdo(): PDO
    {
        $host   = env('DB_HOST');
        $port   = env('DB_PORT', 5432);
        $dbName = env('DB_DATABASE');
        $user   = env('DB_USERNAME');
        $pass   = env('DB_PASSWORD');

        return new PDO(
            "pgsql:host={$host};port={$port};dbname={$dbName}",
            $user,
            $pass,
            [
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_EMULATE_PREPARES   => true,
            ]
        );
    }

    /**
     * Strip SQL statements that require superuser privileges on managed
     * PostgreSQL hosts (Render, Supabase, Railway, etc.)
     */
    private function stripPrivilegedStatements(string $sql): string
    {
        $patterns = [
            // session_replication_role requires superuser
            '/^SET\s+session_replication_role\s*=.*?;/im',
            // default_transaction_read_only — superuser only
            '/^SET\s+default_transaction_read_only.*?;/im',
            // pg_catalog.set_config calls (emitted by pg_dump for superuser settings)
            '/^SELECT\s+pg_catalog\.set_config\s*\(.*?\)\s*;/im',
            // Role/ownership changes (OWNER TO, SET ROLE) — often denied
            '/^ALTER\s+(?:TABLE|SEQUENCE|FUNCTION|SCHEMA|DATABASE)\s+.*?\s+OWNER\s+TO\s+\S+\s*;/im',
            '/^SET\s+ROLE\s+.*?;/im',
            // COMMENT ON EXTENSION — requires superuser on some hosts
            '/^COMMENT\s+ON\s+EXTENSION\s+.*?;/im',
            // CREATE EXTENSION — may fail if already exists; handle via IF NOT EXISTS below
            // We'll keep CREATE EXTENSION but the try/catch will skip duplicates
        ];

        foreach ($patterns as $pattern) {
            $sql = preg_replace($pattern, '', $sql);
        }

        // Replace "CREATE EXTENSION" without IF NOT EXISTS so duplicates don't hard-fail
        $sql = preg_replace(
            '/CREATE EXTENSION(?!\s+IF\s+NOT\s+EXISTS)\s+/i',
            'CREATE EXTENSION IF NOT EXISTS ',
            $sql
        );

        return $sql;
    }

    /**
     * SHARED RESTORE LOGIC — uses PDO, no shell exec
     */
    private function runRestore(string $sqlContent): \Illuminate\Http\JsonResponse
    {
        try {
            $pdo = $this->getPdo();

            // Strip all statements that need superuser on managed Postgres hosts
            $sql = $this->stripPrivilegedStatements($sqlContent);

            // Split into individual statements
            $statements = $this->splitSql($sql);

            $pdo->beginTransaction();

            $errors = [];
            foreach ($statements as $statement) {
                $stmt = trim($statement);
                if ($stmt === '' || $stmt === '--') continue;

                try {
                    $pdo->exec($stmt);
                } catch (PDOException $e) {
                    // Log but continue — some statements may fail on conflicts
                    $errors[] = substr($stmt, 0, 80) . ' → ' . $e->getMessage();
                }
            }

            $pdo->commit();

            return response()->json([
                'success'  => true,
                'message'  => 'Restore successful',
                'warnings' => $errors, // non-fatal errors
            ]);

        } catch (PDOException $e) {
            if (isset($pdo) && $pdo->inTransaction()) {
                $pdo->rollBack();
            }

            return response()->json([
                'success' => false,
                'message' => 'Restore failed: ' . $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Split SQL dump into individual statements.
     * Handles dollar-quoted strings ($$...$$) and regular semicolons.
     */
    private function splitSql(string $sql): array
    {
        $statements = [];
        $current    = '';
        $inDollar   = false;
        $dollarTag  = '';
        $lines      = explode("\n", $sql);

        foreach ($lines as $line) {
            // Skip pure comment lines
            if (str_starts_with(trim($line), '--')) {
                continue;
            }

            $current .= $line . "\n";

            // Detect dollar-quote open/close (e.g. $$ or $BODY$)
            if (preg_match_all('/(\$[^$]*\$)/', $line, $matches)) {
                foreach ($matches[1] as $tag) {
                    if (!$inDollar) {
                        $inDollar  = true;
                        $dollarTag = $tag;
                    } elseif ($tag === $dollarTag) {
                        $inDollar  = false;
                        $dollarTag = '';
                    }
                }
            }

            // Only split on semicolon if outside a dollar-quoted block
            if (!$inDollar && str_ends_with(trim($line), ';')) {
                $statements[] = $current;
                $current      = '';
            }
        }

        if (trim($current) !== '') {
            $statements[] = $current;
        }

        return $statements;
    }

    /**
     * Decrypt .enc file and return SQL string
     */
    private function decrypt(string $filePath): string|false
    {
        $key       = env('BACKUP_ENCRYPTION_KEY');
        $encrypted = file_get_contents($filePath);

        return openssl_decrypt(
            base64_decode($encrypted),
            'AES-256-CBC',
            $key,
            0,
            substr($key, 0, 16)
        );
    }

    /**
     * RESTORE FROM EXISTING FILE ON DISK
     * Route: POST /api/backup/restore/{fileName}
     */
    public function restoreFromFile($fileName)
    {
        $fileName = basename($fileName);
        $filePath = storage_path("app/backups/{$fileName}");

        if (!file_exists($filePath)) {
            return response()->json([
                'success' => false,
                'message' => 'Backup file not found'
            ], 404);
        }

        if (str_ends_with($fileName, '.enc')) {
            $sql = $this->decrypt($filePath);
            if ($sql === false) {
                return response()->json(['success' => false, 'message' => 'Decryption failed'], 500);
            }
        } else {
            $sql = file_get_contents($filePath);
        }

        return $this->runRestore($sql);
    }

    /**
     * RESTORE FROM UPLOADED SQL FILE
     * Route: POST /api/backup/restore-upload
     */
    public function restoreFromUpload(Request $request)
    {
        $request->validate([
            'file' => 'required|file|max:512000', // 500MB
        ]);

        $uploaded = $request->file('file');
        $name     = $uploaded->getClientOriginalName();

        $backupDir = storage_path('app/backups');
        if (!file_exists($backupDir)) {
            mkdir($backupDir, 0777, true);
        }

        $tempName = 'upload_' . time() . '_' . $name;
        $uploaded->move($backupDir, $tempName);
        $tempPath = $backupDir . '/' . $tempName;

        // Read SQL (decrypt if needed)
        if (str_ends_with($name, '.enc')) {
            $sql = $this->decrypt($tempPath);
            if ($sql === false) {
                unlink($tempPath);
                return response()->json(['success' => false, 'message' => 'Decryption failed'], 500);
            }
        } else {
            $sql = file_get_contents($tempPath);
        }

        unlink($tempPath);

        return $this->runRestore($sql);
    }

    /**
     * DOWNLOAD BACKUP
     */
    public function downloadBackup($fileName)
    {
        $fileName = basename($fileName);
        $path     = storage_path("app/backups/{$fileName}");

        if (!file_exists($path)) {
            return response()->json(['success' => false, 'message' => 'File not found'], 404);
        }

        $content = file_get_contents($path);

        if (str_ends_with($fileName, '.enc')) {
            $content = $this->decrypt($path);
            if ($content === false) {
                return response()->json(['success' => false, 'message' => 'Decryption failed'], 500);
            }
            $fileName = str_replace('.enc', '', $fileName);
        }

        return response($content, 200, [
            'Content-Type'        => 'application/octet-stream',
            'Content-Disposition' => "attachment; filename=\"{$fileName}\"",
        ]);
    }

    /**
     * LIST BACKUPS FROM S3
     */
    public function listBackups()
    {
        try {
            $files = Storage::disk('s3')->files('backups');

            $backups = collect($files)->map(fn($file) => [
                'name'          => basename($file),
                'path'          => $file,
                'url'           => Storage::disk('s3')->url($file),
                'size_kb'       => round(Storage::disk('s3')->size($file) / 1024, 2),
                'last_modified' => date('Y-m-d H:i:s', Storage::disk('s3')->lastModified($file)),
            ]);

            return response()->json(['success' => true, 'backups' => $backups]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to list backups: ' . $e->getMessage(),
                'backups' => [],
            ], 500);
        }
    }
}