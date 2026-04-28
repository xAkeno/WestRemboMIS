<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class BackupController extends Controller
{
    /**
     * ─────────────────────────────────────────────
     * CREATE BACKUP (POSTGRES + OPTIONAL ENCRYPTION)
     * ─────────────────────────────────────────────
     */
    public function runDatabaseBackup()
    {
        $dbName = env('DB_DATABASE');
        $host   = env('DB_HOST');
        $port   = env('DB_PORT', 5432);
        $user   = env('DB_USERNAME');
        $pass   = env('DB_PASSWORD');

        $date = now()->format('Y-m-d_H-i-s');
        $fileName = "backup_{$dbName}_{$date}.sql";
        $tempPath = storage_path("app/backups/{$fileName}");

        // Ensure folder exists
        if (!file_exists(storage_path('app/backups'))) {
            mkdir(storage_path('app/backups'), 0777, true);
        }

        // Set password for pg_dump
        putenv("PGPASSWORD={$pass}");

        // PostgreSQL dump command
        $command = "pg_dump -h {$host} -p {$port} -U {$user} -F p {$dbName} > \"{$tempPath}\"";
        exec($command, $output, $result);

        if ($result !== 0 || !file_exists($tempPath)) {
            return response()->json([
                'success' => false,
                'message' => 'Backup failed'
            ], 500);
        }

        // ───────────────────────────────
        // OPTIONAL ENCRYPTION (toggle here)
        // ───────────────────────────────
        $encrypt = true;

        if ($encrypt) {
            $key = env('BACKUP_ENCRYPTION_KEY');

            $sql = file_get_contents($tempPath);

            $encrypted = base64_encode(
                openssl_encrypt(
                    $sql,
                    'AES-256-CBC',
                    $key,
                    0,
                    substr($key, 0, 16)
                )
            );

            $fileName = "backup_{$dbName}_{$date}.sql.enc";
            $tempPath = storage_path("app/backups/{$fileName}");

            file_put_contents($tempPath, $encrypted);
        }

        // ───────────────────────────────
        // UPLOAD TO S3
        // ───────────────────────────────
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
     * ─────────────────────────────────────────────
     * DOWNLOAD BACKUP (OPTIONAL DECRYPT)
     * ─────────────────────────────────────────────
     */
    public function downloadBackup($fileName)
    {
        $path = storage_path("app/backups/{$fileName}");

        if (!file_exists($path)) {
            return response()->json([
                'success' => false,
                'message' => 'File not found'
            ], 404);
        }

        $isEncrypted = str_ends_with($fileName, '.enc');

        $content = file_get_contents($path);

        // Decrypt if needed
        if ($isEncrypted) {
            $key = env('BACKUP_ENCRYPTION_KEY');

            $content = openssl_decrypt(
                base64_decode($content),
                'AES-256-CBC',
                $key,
                0,
                substr($key, 0, 16)
            );

            if (!$content) {
                return response()->json([
                    'success' => false,
                    'message' => 'Decryption failed'
                ], 500);
            }
        }

        return response($content, 200, [
            'Content-Type' => 'application/sql',
            'Content-Disposition' => "attachment; filename={$fileName}.sql"
        ]);
    }

    /**
     * ─────────────────────────────────────────────
     * RESTORE BACKUP (AUTO DETECT ENCRYPTED OR NOT)
     * ─────────────────────────────────────────────
     */
    public function restoreFromFile($fileName)
    {
        $filePath = storage_path("app/backups/{$fileName}");

        if (!file_exists($filePath)) {
            return response()->json([
                'success' => false,
                'message' => 'Backup file not found'
            ], 404);
        }

        $dbName = env('DB_DATABASE');
        $host   = env('DB_HOST');
        $port   = env('DB_PORT', 5432);
        $user   = env('DB_USERNAME');
        $pass   = env('DB_PASSWORD');

        $sqlToRun = $filePath;

        // ───────────────────────────────
        // IF ENCRYPTED → DECRYPT FIRST
        // ───────────────────────────────
        if (str_ends_with($fileName, '.enc')) {

            $key = env('BACKUP_ENCRYPTION_KEY');

            $encrypted = file_get_contents($filePath);

            $decrypted = openssl_decrypt(
                base64_decode($encrypted),
                'AES-256-CBC',
                $key,
                0,
                substr($key, 0, 16)
            );

            if (!$decrypted) {
                return response()->json([
                    'success' => false,
                    'message' => 'Failed to decrypt backup'
                ], 500);
            }

            $sqlToRun = storage_path("app/backups/temp_restore.sql");
            file_put_contents($sqlToRun, $decrypted);
        }

        // ───────────────────────────────
        // POSTGRES RESTORE COMMAND
        // ───────────────────────────────
        putenv("PGPASSWORD={$pass}");

        $command = "psql -h {$host} -p {$port} -U {$user} -d {$dbName} < \"{$sqlToRun}\"";

        exec($command, $output, $result);

        return response()->json([
            'success' => $result === 0,
            'message' => $result === 0 ? 'Restore successful' : 'Restore failed',
            'debug'   => $output,
        ]);
    }

    /**
     * ─────────────────────────────────────────────
     * LIST BACKUPS (LOCAL OR S3 READY)
     * ─────────────────────────────────────────────
     */
    public function listBackups()
    {
        $files = Storage::disk('s3')->files('backups');

        $backups = collect($files)->map(function ($file) {
            return [
                'name' => basename($file),
                'path' => $file,
                'url'  => Storage::disk('s3')->url($file),
            ];
        });

        return response()->json([
            'success' => true,
            'backups' => $backups,
        ]);
    }
}
