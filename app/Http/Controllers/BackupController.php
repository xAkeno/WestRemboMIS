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
       DATABASE BACKUP (FIXED)
    ========================= */
    public function runDatabaseBackup()
    {
        $backupDir = storage_path('app/backups/');

        if (!file_exists($backupDir)) {
            mkdir($backupDir, 0777, true);
        }

        $dbName = env('DB_DATABASE');
        $date = now()->format('Y-m-d_H-i-s');

        $fileName = "backup_{$dbName}_{$date}.sql";
        $filePath = $backupDir . $fileName;

        $host = env('DB_HOST');
        $port = env('DB_PORT', 3306);
        $user = env('DB_USERNAME');
        $pass = env('DB_PASSWORD');

        $command = "mysqldump -h {$host} -P {$port} -u {$user} --password={$pass} {$dbName} > \"{$filePath}\"";

        exec($command, $output, $result);

        if ($result !== 0 || !file_exists($filePath) || filesize($filePath) < 100) {
            return response()->json([
                'success' => false,
                'message' => 'Backup failed'
            ], 500);
        }

        return response()->json([
            'success' => true,
            'file' => $fileName
        ]);
    }

    public function getSettings()
    {
        // Always return a single row — create it with defaults if it doesn't exist yet
        $setting = BackupSetting::firstOrCreate(
            [],
            [
                'frequency' => 'daily',
                'time'      => '02:00',
                'enabled'   => true,
            ]
        );
 
        return response()->json([
            'success'  => true,
            'settings' => [
                'id'          => $setting->id,
                'enabled'     => $setting->enabled,
                'frequency'   => $setting->frequency,
                'time'        => $setting->time,
                'day_of_week' => $setting->day_of_week ?? null,
                'updated_at'  => $setting->updated_at,
            ],
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
 
        // time is required when frequency is daily or weekly
        if (in_array($validated['frequency'], ['daily', 'weekly']) && empty($validated['time'])) {
            return response()->json([
                'success' => false,
                'message' => 'Time is required for daily and weekly schedules.',
            ], 422);
        }
 
        // day_of_week is required when frequency is weekly
        if ($validated['frequency'] === 'weekly' && is_null($validated['day_of_week'] ?? null)) {
            return response()->json([
                'success' => false,
                'message' => 'Day of week is required for weekly schedules.',
            ], 422);
        }
 
        $setting = BackupSetting::first();
 
        if ($setting) {
            $setting->update($validated);
        } else {
            $setting = BackupSetting::create($validated);
        }
 
        return response()->json([
            'success'  => true,
            'message'  => 'Backup schedule saved successfully.',
            'settings' => [
                'id'          => $setting->id,
                'enabled'     => $setting->enabled,
                'frequency'   => $setting->frequency,
                'time'        => $setting->time,
                'day_of_week' => $setting->day_of_week ?? null,
                'updated_at'  => $setting->updated_at,
            ],
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