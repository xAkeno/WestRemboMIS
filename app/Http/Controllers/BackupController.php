<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class BackupController extends Controller
{
    protected $backupPath;

    public function __construct()
    {
        $this->backupPath = storage_path('app/backups/');
    }

    /* =========================
       DATABASE BACKUP (FIXED)
    ========================= */
    public function runDatabaseBackup()
    {
        $backupDir = $this->backupPath;

        if (!file_exists($backupDir)) {
            mkdir($backupDir, 0777, true);
        }

        $dbName = env('DB_DATABASE');
        $date = now()->format('Y-m-d_H-i-s');

        // ✅ CLEAN + SORTABLE + NO CONFUSION NAME
        $fileName = "backup_{$dbName}_{$date}.sql";
        $sqlFile = $backupDir . $fileName;

        $host = env('DB_HOST', '127.0.0.1');
        $port = env('DB_PORT', 3306);
        $user = env('DB_USERNAME');
        $pass = env('DB_PASSWORD');
        $db   = $dbName;

        // ✅ SAFE COMMAND (NO REDIRECTION BUGS)
        $command = "mysqldump --single-transaction --quick --skip-lock-tables " .
            "-h {$host} -P {$port} -u {$user} --password={$pass} {$db}";

        $output = [];
        $result = 0;

        exec($command, $output, $result);

        // ❗ WRITE OUTPUT SAFELY
        file_put_contents($sqlFile, implode("\n", $output));

        // ❗ CHECK FAILURES
        if ($result !== 0 || !file_exists($sqlFile) || filesize($sqlFile) < 100) {
            return response()->json([
                'success' => false,
                'message' => 'Backup failed or empty file',
                'debug' => $output
            ], 500);
        }

        // ✅ SAVE LATEST BACKUP POINTER
        file_put_contents($backupDir . "LATEST_BACKUP.txt", $fileName);

        return response()->json([
            'success' => true,
            'file' => $fileName,
            'latest' => $fileName,
        ]);
    }

    public function restoreUpload(Request $request)
    {
        $request->validate([
            'file' => 'required|file|extensions:sql',
        ]);

        $file = $request->file('file');

        $filePath = $file->storeAs(
            'backups/temp',
            $file->getClientOriginalName()
        );

        $fullPath = storage_path('app/' . $filePath);

        $host = env('DB_HOST', '127.0.0.1');
        $port = env('DB_PORT', 3306);
        $user = env('DB_USERNAME');
        $pass = env('DB_PASSWORD');
        $db   = env('DB_DATABASE');

        // ⚠️ IMPORTANT: safe restore command
        $command = "mysql -h {$host} -P {$port} -u {$user} --password={$pass} {$db} < \"{$fullPath}\"";

        exec($command, $output, $result);

        if ($result !== 0) {
            return response()->json([
                'success' => false,
                'message' => 'Restore failed',
                'debug' => $output
            ], 500);
        }

        return response()->json([
            'success' => true,
            'message' => 'Database restored successfully',
        ]);
    }

    /* =========================
       LIST BACKUPS (SORTED NEWEST FIRST)
    ========================= */
    public function listBackups()
    {
        $path = $this->backupPath;

        if (!file_exists($path)) {
            return response()->json(['success' => true, 'backups' => []]);
        }

        $files = collect(File::files($path))
            ->sortByDesc(fn($file) => $file->getMTime());

        $backups = [];

        $latest = file_exists($path . "LATEST_BACKUP.txt")
            ? trim(file_get_contents($path . "LATEST_BACKUP.txt"))
            : null;

        foreach ($files as $file) {
            $name = $file->getFilename();

            // skip system file
            if ($name === "LATEST_BACKUP.txt") continue;

            $backups[] = [
                'name' => $name,
                'size_kb' => round($file->getSize() / 1024, 2),
                'last_modified' => date('Y-m-d H:i:s', $file->getMTime()),
                'download_url' => url('/api/backup/' . $name . '/download'),
                'is_latest' => $name === $latest,
            ];
        }

        return response()->json([
            'success' => true,
            'latest' => $latest,
            'backups' => $backups,
        ]);
    }

    /* =========================
       DOWNLOAD BACKUP
    ========================= */
    public function downloadBackup($fileName)
    {
        $filePath = $this->backupPath . $fileName;

        if (!file_exists($filePath)) {
            return response()->json(['message' => 'File not found'], 404);
        }

        return response()->download($filePath, $fileName, [
            'Content-Type' => 'application/sql',
        ]);
    }

    /* =========================
       RESTORE BACKUP
    ========================= */
    public function restoreFromFile($fileName)
    {
        $filePath = $this->backupPath . $fileName;

        if (!file_exists($filePath)) {
            return response()->json([
                'success' => false,
                'message' => 'File not found',
            ], 404);
        }

        $host = env('DB_HOST', '127.0.0.1');
        $port = env('DB_PORT', 3306);
        $user = env('DB_USERNAME');
        $pass = env('DB_PASSWORD');
        $db   = env('DB_DATABASE');

        $command = "mysql -h {$host} -P {$port} -u {$user} --password={$pass} {$db} < \"{$filePath}\"";

        exec($command);

        return response()->json([
            'success' => true,
            'message' => 'Restore completed',
        ]);
    }
}