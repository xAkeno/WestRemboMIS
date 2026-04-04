<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\File;
use ZipArchive;
use RecursiveIteratorIterator;
use RecursiveDirectoryIterator;

class BackupController extends Controller
{
    protected $backupPath;

    public function __construct()
    {
        $this->backupPath = storage_path('app/backups/');
    }

    /* =========================
       1. FULL BACKUP (DB + Storage)
    ========================= */
    public function runFullBackup(Request $request)
    {
        $timestamp = date('Y_m_d_H_i_s');
        $zipFileName = "backup_full_{$timestamp}.zip";
        $zipFilePath = $this->backupPath . $zipFileName;

        if (!file_exists($this->backupPath)) mkdir($this->backupPath, 0777, true);

        // 1. Dump database
        $sqlFileName = "database_{$timestamp}.sql";
        $sqlFilePath = $this->backupPath . $sqlFileName;
        $this->dumpDatabase($sqlFilePath);

        // 2. Create ZIP and add SQL + images
        $zip = new ZipArchive();
        if ($zip->open($zipFilePath, ZipArchive::CREATE) !== TRUE) {
            return response()->json(['success' => false, 'message' => 'Could not create ZIP']);
        }

        // Add SQL dump
        $zip->addFile($sqlFilePath, $sqlFileName);

        // Add public storage files (downloaded from Supabase bucket)
        $this->addStorageToZip($zip);

        $zip->close();

        // Remove temporary SQL file
        unlink($sqlFilePath);

        return response()->json(['success' => true, 'file' => $zipFileName]);
    }

    /* =========================
       HELPER: DUMP DATABASE (PostgreSQL)
    ========================= */
    private function dumpDatabase($outputFile)
    {
        $host = env('DB_HOST'); // Supabase host
        $port = env('DB_PORT', 5432);
        $dbName = env('DB_DATABASE');
        $user = env('DB_USERNAME');
        $password = env('DB_PASSWORD');

        // Set password for pg_dump
        putenv("PGPASSWORD=$password");

        // pg_dump command
        $command = "pg_dump -h $host -p $port -U $user -d $dbName -F p -v -f \"$outputFile\"";

        exec($command, $output, $returnVar);

        if ($returnVar !== 0 || !file_exists($outputFile)) {
            throw new \Exception("Database dump failed! Command output: " . implode("\n", $output));
        }
    }

    /* =========================
       HELPER: ADD STORAGE TO ZIP
    ========================= */
    private function addStorageToZip($zip)
    {
        // Local storage folder (downloaded from Supabase bucket)
        $storagePath = storage_path('app/public'); // you should sync your bucket to this folder
        if (!file_exists($storagePath)) return;

        $files = new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($storagePath),
            RecursiveIteratorIterator::LEAVES_ONLY
        );

        foreach ($files as $file) {
            if (!$file->isFile()) continue;

            $filePath = $file->getRealPath();
            $relativePath = 'public/' . substr($filePath, strlen($storagePath) + 1);

            $zip->addFile($filePath, $relativePath);
        }
    }

    /* =========================
       2. LIST BACKUPS
    ========================= */
    public function listBackups()
    {
        if (!file_exists($this->backupPath)) {
            return response()->json(['success' => true, 'backups' => []]);
        }

        $files = File::files($this->backupPath);
        $backups = [];

        foreach ($files as $file) {
            $backups[] = [
                'name' => $file->getFilename(),
                'size_kb' => round($file->getSize() / 1024, 2),
                'last_modified' => date('Y-m-d H:i:s', $file->getMTime()),
                'download_url' => url('/backup/' . $file->getFilename() . '/download')
            ];
        }

        return response()->json(['success' => true, 'backups' => $backups]);
    }

    /* =========================
       3. DOWNLOAD BACKUP
    ========================= */
    public function downloadBackup($fileName)
    {
        $filePath = $this->backupPath . $fileName;

        if (!file_exists($filePath)) {
            return response()->json(['success' => false, 'message' => 'Backup file not found!'], 404);
        }

        return response()->download($filePath);
    }
}