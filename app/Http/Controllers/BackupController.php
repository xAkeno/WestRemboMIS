<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use App\Models\BackupSetting;

class BackupController extends Controller
{
    protected $backupPath;

    public function __construct()
    {
        $this->backupPath = storage_path('app/backups/');

        if (!file_exists($this->backupPath)) {
            mkdir($this->backupPath, 0777, true);
        }
    }

    /* =========================
       DATABASE BACKUP (SAFE)
    ========================= */
    public function runDatabaseBackup()
    {
        set_time_limit(0);

        $dbName = env('DB_DATABASE');
        $date = now()->format('Y-m-d_H-i-s');

        $fileName = "backup_{$dbName}_{$date}.sql";
        $filePath = $this->backupPath . $fileName;

        $host = env('DB_HOST');
        $port = env('DB_PORT', 3306);
        $user = env('DB_USERNAME');
        $pass = env('DB_PASSWORD');

        // hide password from process list
        putenv("MYSQL_PWD={$pass}");

        $command = sprintf(
            'mysqldump -h %s -P %d -u %s %s > %s',
            escapeshellarg($host),
            (int)$port,
            escapeshellarg($user),
            escapeshellarg($dbName),
            escapeshellarg($filePath)
        );

        exec($command, $output, $result);

        if ($result !== 0 || !file_exists($filePath) || filesize($filePath) < 100) {
            return response()->json([
                'success' => false,
                'message' => 'Backup failed'
            ], 500);
        }

        // mark latest backup
        file_put_contents($this->backupPath . 'LATEST_BACKUP.txt', $fileName);

        return response()->json([
            'success' => true,
            'file' => $fileName
        ]);
    }

    /* =========================
       SETTINGS
    ========================= */
    public function getSettings()
    {
        $setting = BackupSetting::firstOrCreate(
            [],
            [
                'frequency' => 'daily',
                'time'      => '02:00',
                'enabled'   => true,
            ]
        );

        return response()->json([
            'success' => true,
            'settings' => $setting
        ]);
    }

    public function saveSettings(Request $request)
    {
        $validated = $request->validate([
            'enabled'     => 'required|boolean',
            'frequency'   => 'required|in:hourly,daily,weekly',
            'time'        => 'nullable|date_format:H:i',
            'day_of_week' => 'nullable|integer|min:0|max:6',
        ]);

        if (in_array($validated['frequency'], ['daily', 'weekly']) && empty($validated['time'])) {
            return response()->json([
                'success' => false,
                'message' => 'Time is required'
            ], 422);
        }

        if ($validated['frequency'] === 'weekly' && is_null($validated['day_of_week'] ?? null)) {
            return response()->json([
                'success' => false,
                'message' => 'Day of week required'
            ], 422);
        }

        $setting = BackupSetting::first();

        if ($setting) {
            $setting->update($validated);
        } else {
            $setting = BackupSetting::create($validated);
        }

        return response()->json([
            'success' => true,
            'settings' => $setting
        ]);
    }

    /* =========================
       RESTORE FROM UPLOAD
    ========================= */
    public function restoreUpload(Request $request)
    {
        set_time_limit(0);

        $request->validate([
            'file' => 'required|file|mimes:sql,txt|max:51200',
        ]);

        $file = $request->file('file');

        $path = $file->storeAs(
            'backups/temp',
            time() . '_' . $file->getClientOriginalName()
        );

        $fullPath = storage_path('app/' . $path);

        return $this->runRestore($fullPath);
    }

    /* =========================
       RESTORE FROM FILE
    ========================= */
    public function restoreFromFile($fileName)
    {
        $filePath = $this->backupPath . $fileName;

        if (!file_exists($filePath)) {
            return response()->json([
                'success' => false,
                'message' => 'File not found'
            ], 404);
        }

        return $this->runRestore($filePath);
    }

    /* =========================
       CORE RESTORE LOGIC
    ========================= */
    private function runRestore($filePath)
    {
        set_time_limit(0);

        $host = env('DB_HOST');
        $port = env('DB_PORT', 3306);
        $user = env('DB_USERNAME');
        $pass = env('DB_PASSWORD');
        $db   = env('DB_DATABASE');

        putenv("MYSQL_PWD={$pass}");

        $command = sprintf(
            'mysql -h %s -P %d -u %s %s < %s',
            escapeshellarg($host),
            (int)$port,
            escapeshellarg($user),
            escapeshellarg($db),
            escapeshellarg($filePath)
        );

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
            'message' => 'Restore successful'
        ]);
    }

    /* =========================
       LIST BACKUPS
    ========================= */
    public function listBackups()
    {
        if (!file_exists($this->backupPath)) {
            return response()->json([
                'success' => true,
                'backups' => []
            ]);
        }

        $files = collect(File::files($this->backupPath))
            ->sortByDesc(fn($f) => $f->getMTime());

        $latest = file_exists($this->backupPath . 'LATEST_BACKUP.txt')
            ? trim(file_get_contents($this->backupPath . 'LATEST_BACKUP.txt'))
            : null;

        $backups = [];

        foreach ($files as $file) {
            $name = $file->getFilename();

            if ($name === 'LATEST_BACKUP.txt') continue;

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
            return response()->json([
                'message' => 'File not found'
            ], 404);
        }

        return response()->download($filePath, $fileName, [
            'Content-Type' => 'application/sql',
        ]);
    }
}