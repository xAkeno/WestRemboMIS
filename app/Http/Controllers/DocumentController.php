<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Document;
use Illuminate\Support\Facades\Storage;

class DocumentController extends Controller
{
    public function index()
    {
        $documents = Document::all()->map(function($doc) {
            return [
                'id' => $doc->id,
                'name' => $doc->name,
                'file_name' => $doc->file_name,
                'file_url' => $doc->file_path
                    ? url('storage/' . str_replace('public/', '', $doc->file_path))
                    : null,
            ];
        });

        return response()->json($documents);
    }

    // CREATE if not exists
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'file' => 'required|mimes:pdf|max:10240',
        ]);

        $file = $request->file('file');
        $path = $file->store('public/documents');

        $document = Document::create([
            'name' => $request->name,
            'file_path' => $path,
            'file_name' => $file->getClientOriginalName(),
        ]);

        return response()->json($document);
    }

    // UPDATE if exists
    public function update(Request $request, Document $document)
    {
        $request->validate([
            'file' => 'required|mimes:pdf|max:10240',
        ]);

        if ($document->file_path && Storage::exists($document->file_path)) {
            Storage::delete($document->file_path);
        }

        $file = $request->file('file');
        $path = $file->store('public/documents');

        $document->update([
            'file_path' => $path,
            'file_name' => $file->getClientOriginalName(),
        ]);

        return response()->json($document);
    }

}
