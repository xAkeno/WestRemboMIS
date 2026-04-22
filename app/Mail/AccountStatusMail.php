<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class AccountStatusMail extends Mailable
{
    use Queueable, SerializesModels;

    public $status;
    public $user;

    public function __construct($user, $status)
    {
        $this->user = $user;
        $this->status = $status;
    }

    public function build()
    {
        $subject = $this->status === 'approved' ? 
            'Your Account Has Been Approved' : 
            'Your Account Has Been Rejected';

        return $this->subject($subject)
                    ->view('emails.account_status'); // Create this blade
    }
}