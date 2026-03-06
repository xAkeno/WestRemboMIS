<?php

namespace App\Http\Controllers;

use App\Models\ContactCms;
use Illuminate\Http\Request;

class ContactCmsController extends Controller
{
    // Public: get contact info
    public function index()
    {
        return ContactCms::all();
    }

    // Protected: store new contact info
    public function store(Request $request)
    {
        $request->validate([
            'address' => 'required|string',
            'email' => 'required|email',
            'telephone' => 'required|string',
            'facebook' => 'nullable|url',
            'office_days' => 'nullable|string',
            'office_hours' => 'nullable|string',
        ]);

        return ContactCms::create($request->all());
    }

    // Protected: update contact info
    public function update(Request $request, $id)
    {
        $contact = ContactCms::findOrFail($id);
        $contact->update($request->all());
        return $contact;
    }

    // Protected: delete contact info
    public function destroy($id)
    {
        ContactCms::destroy($id);
        return response()->json(['message' => 'Contact deleted']);
    }
}