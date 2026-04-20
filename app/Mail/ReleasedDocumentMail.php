<?php

namespace App\Mail;

use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Mail\Mailables\Attachment;
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
            subject: 'Your Document is Ready – ' . ($this->record->bcert_number ?? 'Barangay Document'),
        );
    }

    public function content(): Content
    {
        return new Content(
            view: 'emails.released_document',
            with: [
                'name'     => trim($this->record->first_name . ' ' . $this->record->surname),
                'password' => $this->password,
            ],
        );
    }

    public function attachments(): array
    {
        if (!$this->filePath || !file_exists($this->filePath)) {
            Log::error('ReleasedDocumentMail: attachment file not found', [
                'path' => $this->filePath,
            ]);
            return [];
        }

        return [
            Attachment::fromPath($this->filePath)
                ->as('document.pdf')
                ->withMime('application/pdf'),
        ];
    }
}