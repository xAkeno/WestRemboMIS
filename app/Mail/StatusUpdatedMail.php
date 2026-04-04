<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class StatusUpdatedMail extends Mailable
{
    public $model;

    public function __construct($model)
    {
        $this->model = $model;
    }

    public function build()
    {
        return $this->subject('Request Status Updated')
            ->view('emails.status-updated');
    }
}
