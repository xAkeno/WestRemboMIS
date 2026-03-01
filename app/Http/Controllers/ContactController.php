<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Contact;
use Illuminate\Support\Facades\Mail;
use App\Mail\ContactReplyMail;

class ContactController extends Controller
{
    // Submit contact form
    public function submit(Request $request)
    {
        $request->validate([
            'first_name'   => 'required|string|max:255',
            'last_name'    => 'required|string|max:255',
            'email'        => 'required|email|max:255',
            'phone'        => 'required|string|max:20',
            'home_address'      => 'required|string|max:500',
            'subject'        => 'required|string|max:255',
            'message'      => 'required|string',
        ]);

        $contact = Contact::create([
            ...$request->all(),
            'status' => 'new' // default
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Your message has been sent!',
            'data' => $contact
        ]);
    }

    // View all contacts
    public function index()
    {
        $contacts = Contact::latest()->get();

        return response()->json([
            'success' => true,
            'data' => $contacts
        ]);
    }

    // Update status
    public function updateStatus(Request $request, $id)
    {
        $request->validate([
            'status' => 'required|in:new,replied,resolved'
        ]);

        $contact = Contact::findOrFail($id);

        $contact->update([
            'status' => $request->status
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Status updated successfully',
            'data' => $contact
        ]);
    }

    // Reply via Email
    public function reply(Request $request, $id)
    {
        $request->validate([
            'reply_message' => 'required|string'
        ]);

        $contact = Contact::findOrFail($id);
        
        Mail::to($contact->email)->send(
            new ContactReplyMail(
                $contact->first_name,
                $contact->subject, // 👈 include subject
                $request->reply_message
            )
        );

        // Update status
        $contact->update([
            'status' => 'replied'
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Reply sent successfully'
        ]);
    }
}