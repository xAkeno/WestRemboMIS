<?php

namespace App\Mail;

use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class ContactReplyMail extends Mailable
{
    use SerializesModels;

    public $name;
    public $replyMessage;
    public $topic;

    public function __construct($name, $topic, $replyMessage)
    {
        $this->name = $name;
        $this->topic = $topic;
        $this->replyMessage = $replyMessage;
    }

    public function build()
    {
        return $this->subject('Re: ' . $this->topic)
                    ->view('emails.contact_reply');
    }
}