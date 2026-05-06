<?php
// ReleasedDocumentMail.php

namespace App\Mail;

use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Attachment;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Support\Facades\Log;

class ReleasedDocumentMail extends Mailable
{
    public function __construct(
        public $record,
        public string $filePath,
        public string $password
    ) {}

    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Your Secure Document is Ready – ' . ($this->record->bcert_number ?? 'Barangay Document'),
        );
    }

    public function content(): Content
    {
        return new Content(
            view: 'emails.released_document',
            with: [
                'name'     => trim($this->record->first_name . ' ' . $this->record->surname),
                'filename' => $this->resolveFilename(),
                'password' => $this->password, // 👈 now passed to the view
            ],
        );
    }

    private function resolveFilename(): string
    {
        $type = strtolower(
            $this->record->service_type
            ?? $this->record->document_type
            ?? $this->record->type
            ?? ''
        );

        $map = [
            'clearance'   => 'barangayclearance.pdf',
            'certificate' => 'barangaycertificate.pdf',
            'indigency'   => 'barangayindigency.pdf',
            'residency'   => 'barangayresidency.pdf',
            'business'    => 'barangaybusinessclearance.pdf',
        ];

        foreach ($map as $keyword => $filename) {
            if (str_contains($type, $keyword)) {
                return $filename;
            }
        }

        return 'barangaydocument.pdf';
    }

    public function attachments(): array
    {
        if (! $this->filePath || ! file_exists($this->filePath)) {
            Log::error('ReleasedDocumentMail: attachment file not found', [
                'path' => $this->filePath,
            ]);
            return [];
        }

        return [
            Attachment::fromPath($this->filePath)
                ->as($this->resolveFilename())
                ->withMime('application/pdf'),
        ];
    }
}