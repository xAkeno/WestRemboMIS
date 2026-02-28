<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Contact;

class ContactController extends Controller
{
    public function showForm()
    {
        return view('contact.form');
    }

    public function submit(Request $request)
    {
        $request->validate([
            'first_name'   => 'required|string|max:255',
            'last_name'    => 'required|string|max:255',
            'email'        => 'required|email|max:255',
            'phone'        => 'required|string|max:20',
            'address'      => 'required|string|max:500',
            'topic'        => 'required|string|max:255',
            'message'      => 'required|string',
        ]);

        $contact = Contact::create($request->all());

        // Return JSON response instead of redirect
        return response()->json([
            'success' => true,
            'message' => 'Your message has been sent!',
            'data' => $contact
        ]);
    }
}