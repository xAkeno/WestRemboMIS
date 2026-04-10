<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Storage;

class BackupController extends Controller
{
    protected $backupPath;
    protected $s3Folder = 'backups';

    public function __construct()
    {
        $this->backupPath = storage_path('app/backups/');
    }

    /* =========================
       1. RUN DATABASE BACKUP
    ========================= */
    public function runFullBackup(Request $request)
    {
        $timestamp = date('Y_m_d_H_i_s');
        $sqlFileName = "backup_db_{$timestamp}.sql";
        $sqlFilePath = $this->backupPath . $sqlFileName;

        if (!file_exists($this->backupPath)) {
            mkdir($this->backupPath, 0777, true);
        }

        // 1. Dump database locally (temp)
        $this->dumpDatabase($sqlFilePath);

        // 2. Upload to S3
        $s3Path = $this->s3Folder . '/' . $sqlFileName;
        Storage::disk('s3')->put(
            $s3Path,
            file_get_contents($sqlFilePath)
        );

        // 3. Remove local temp file
        unlink($sqlFilePath);

        return response()->json([
            'success' => true,
            'file'    => $sqlFileName,
            's3_path' => $s3Path,
        ]);
    }

    /* =========================
       HELPER: DUMP DATABASE (PostgreSQL)
    ========================= */
    private function dumpDatabase($outputFile)
    {
        $host     = env('DB_HOST');
        $port     = env('DB_PORT', 5432);
        $dbName   = env('DB_DATABASE');
        $user     = env('DB_USERNAME');
        $password = env('DB_PASSWORD');

        putenv("PGPASSWORD=$password");

        $command = "pg_dump -h {$host} -p {$port} -U {$user} -d {$dbName} -F p -f \"{$outputFile}\"";

        exec($command, $output, $returnVar);

        if ($returnVar !== 0 || !file_exists($outputFile)) {
            throw new \Exception("Database dump failed: " . implode("\n", $output));
        }
    }

    /* =========================
       2. LIST BACKUPS (from S3)
    ========================= */
    public function listBackups()
    {
        $files = Storage::disk('s3')->files($this->s3Folder);

        if (empty($files)) {
            return response()->json(['success' => true, 'backups' => []]);
        }

        $backups = [];

        foreach ($files as $file) {
            $fileName = basename($file);
            $backups[] = [
                'name'          => $fileName,
                'size_kb'       => round(Storage::disk('s3')->size($file) / 1024, 2),
                'last_modified' => date('Y-m-d H:i:s', Storage::disk('s3')->lastModified($file)),
                'download_url'  => url('/backup/' . $fileName . '/download'),
            ];
        }

        return response()->json(['success' => true, 'backups' => $backups]);
    }

    /* =========================
       3. DOWNLOAD BACKUP (from S3)
    ========================= */
    public function downloadBackup($fileName)
    {
        $s3Path = $this->s3Folder . '/' . $fileName;

        if (!Storage::disk('s3')->exists($s3Path)) {
            return response()->json([
                'success' => false,
                'message' => 'Backup file not found!',
            ], 404);
        }

        // Stream directly from S3
        $fileStream = Storage::disk('s3')->readStream($s3Path);

        return response()->stream(function () use ($fileStream) {
            fpassthru($fileStream);
        }, 200, [
            'Content-Type'        => 'application/octet-stream',
            'Content-Disposition' => 'attachment; filename="' . $fileName . '"',
        ]);
    }
}