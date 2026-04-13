<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\File;

class AutoDatabaseBackup extends Command
{
    protected $signature = 'backup:auto';
    protected $description = 'Auto database backup';

    public function handle()
    {
        $path = storage_path('app/backups/');

        if (!file_exists($path)) {
            mkdir($path, 0777, true);
        }

        $db = env('DB_DATABASE');
        $file = "backup_{$db}_" . now()->format('Y-m-d_H-i-s') . ".sql";
        $filePath = $path . $file;

        $host = env('DB_HOST');
        $port = env('DB_PORT', 3306);
        $user = env('DB_USERNAME');
        $pass = env('DB_PASSWORD');

        $cmd = "mysqldump -h {$host} -P {$port} -u {$user} --password={$pass} {$db} > \"{$filePath}\"";

        exec($cmd);

        $this->info("Backup created: {$file}");
    }
}