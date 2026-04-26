<?php

namespace App\Mail;

use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;

/**
 * Email 1 of 2 — Sends the password only (no attachment).
 * Should be dispatched BEFORE ReleasedDocumentMail.
 */
class DocumentPasswordMail extends Mailable
{
    public function __construct(
        public $record,
        public string $password
    ) {}

    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Your Document Password – ' . ($this->record->bcert_number ?? 'Barangay Document'),
        );
    }

    public function content(): Content
    {
        return new Content(
            view: 'emails.password_email',
            with: [
                'name'     => trim($this->record->first_name . ' ' . $this->record->surname),
                'password' => $this->password,
            ],
        );
    }

    public function attachments(): array
    {
        return []; // No attachment — password only
    }
}