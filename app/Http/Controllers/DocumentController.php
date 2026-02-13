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

    public function show($id)
    {
        // Find the document by ID
        $document = Document::find($id);

        if (!$document) {
            return response()->json(['message' => 'Document not found'], 404);
        }

        // Full storage path to the file
        $filePath = storage_path('app/' . $document->file_path);

        if (!file_exists($filePath)) {
            return response()->json(['message' => 'File not found on server'], 404);
        }

        return response()->json([
            'id' => $document->id,
            'name' => $document->name,
            'file_name' => $document->file_name,
            'file_path' => $document->file_path,
            'file_url' => url('/documents/' . $document->file_name), // URL for frontend to fetch PDF
        ]);
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
