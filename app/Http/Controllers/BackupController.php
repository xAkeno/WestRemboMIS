<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Storage;
use Carbon\Carbon;
use Illuminate\Support\Facades\Response;
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
       1. FULL BACKUP
    ========================= */
    public function runFullBackup(Request $request)
    {
        $timestamp = date('Y_m_d_H_i_s');
        $zipFileName = "backup_full_{$timestamp}.zip";
        $zipFilePath = $this->backupPath . $zipFileName;

        // Make sure backup folder exists
        if (!file_exists($this->backupPath)) {
            mkdir($this->backupPath, 0777, true);
        }

        // 1. Dump database
        $sqlFileName = "database_{$timestamp}.sql";
        $sqlFilePath = $this->backupPath . $sqlFileName;
        $this->dumpDatabase($sqlFilePath);

        // 2. Create ZIP and add SQL + images
        $zip = new ZipArchive();
        if ($zip->open($zipFilePath, ZipArchive::CREATE) !== TRUE) {
            return response()->json(['success' => false, 'message' => 'Could not create ZIP']);
        }

        // Add SQL
        $zip->addFile($sqlFilePath, $sqlFileName);

        // Add public storage
        $this->addStorageToZip($zip);

        $zip->close();

        // Remove temporary SQL file
        unlink($sqlFilePath);

        return response()->json(['success' => true, 'file' => $zipFileName]);
    }

    /* =========================
       2. DATABASE ONLY
    ========================= */
    public function runDatabaseBackup(Request $request)
    {
        $timestamp = date('Y_m_d_H_i_s');
        $zipFileName = "backup_db_{$timestamp}.zip";
        $zipFilePath = $this->backupPath . $zipFileName;

        if (!file_exists($this->backupPath)) mkdir($this->backupPath, 0777, true);

        // Dump database
        $sqlFileName = "database_{$timestamp}.sql";
        $sqlFilePath = $this->backupPath . $sqlFileName;
        $this->dumpDatabase($sqlFilePath);

        // Create ZIP and add only SQL
        $zip = new ZipArchive();
        if ($zip->open($zipFilePath, ZipArchive::CREATE) !== TRUE) {
            return response()->json(['success' => false, 'message' => 'Could not create ZIP']);
        }

        $zip->addFile($sqlFilePath, $sqlFileName);
        $zip->close();

        unlink($sqlFilePath);

        return response()->json(['success' => true, 'file' => $zipFileName]);
    }

    /* =========================
       3. IMAGES ONLY
    ========================= */
    public function runImagesBackup(Request $request)
    {
        $timestamp = date('Y_m_d_H_i_s');
        $zipFileName = "backup_images_{$timestamp}.zip";
        $zipFilePath = $this->backupPath . $zipFileName;

        if (!file_exists($this->backupPath)) mkdir($this->backupPath, 0777, true);

        $zip = new ZipArchive();
        if ($zip->open($zipFilePath, ZipArchive::CREATE) !== TRUE) {
            return response()->json(['success' => false, 'message' => 'Could not create ZIP']);
        }

        // Add public storage only
        $this->addStorageToZip($zip);

        $zip->close();

        return response()->json(['success' => true, 'file' => $zipFileName]);
    }

    /* =========================
       HELPER: DUMP DATABASE
    ========================= */
    private function dumpDatabase($outputFile)
    {
        $mysqlPath = 'C:/xampp/mysql/bin/mysqldump.exe';
        $database = 'barangay_mis';
        $user = 'root';
        $password = ''; // your DB password

        $command = "\"$mysqlPath\" -h localhost -u $user";
        if (!empty($password)) $command .= " -p$password";
        $command .= " $database > \"$outputFile\"";

        shell_exec($command);

        if (!file_exists($outputFile)) {
            throw new \Exception("Database dump failed!");
        }
    }

    /* =========================
       HELPER: ADD STORAGE TO ZIP
    ========================= */
    private function addStorageToZip($zip)
    {
        $storagePath = storage_path('app/public');
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
    public function listBackups()
    {
        if (!file_exists($this->backupPath)) {
            return response()->json([
                'success' => true,
                'backups' => [],
            ]);
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

        return response()->json([
            'success' => true,
            'backups' => $backups,
        ]);
    }
    /**
     * Download backup by file name
     */
    public function downloadBackup($id)
    {
        $filePath = $this->backupPath . $id;

        if (!file_exists($filePath)) {
            return response()->json([
                'success' => false,
                'message' => 'Backup file not found!',
            ], 404);
        }

        return response()->download($filePath);
    }

}
