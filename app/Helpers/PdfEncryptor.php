<?php

namespace App\Helpers;

class PdfEncryptor
{
    public static function encryptWithPassword(string $sourcePath, string $password): string
    {
        $outputPath = sys_get_temp_dir() . '/' . uniqid('enc_pdf_', true) . '.pdf';

        $escapedSource   = escapeshellarg($sourcePath);
        $escapedOutput   = escapeshellarg($outputPath);
        $escapedPassword = escapeshellarg($password);

        $command    = "qpdf --encrypt {$escapedPassword} {$escapedPassword} 128 -- {$escapedSource} {$escapedOutput} 2>&1";
        $returnCode = 0;

        exec($command, $output, $returnCode);

        if ($returnCode !== 0 || !file_exists($outputPath)) {
            throw new \Exception(
                "PDF encryption failed (qpdf exit code {$returnCode}): " . implode("\n", $output)
            );
        }

        return $outputPath;
    }
}