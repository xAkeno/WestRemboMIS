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
                'layout' => $doc->layout,
                'file_url' => $doc->file_path,
            ];
        });

        return response()->json($documents);
    }

    public function show($id)
    {
        $document = Document::find($id);

        if (!$document) {
            return response()->json(['message' => 'Document not found'], 404);
        }

        $workerBaseUrl = env('R2_WORKER_URL');
        $fileUrl = $document->file_path
            ? $workerBaseUrl . '/' . $document->file_path
            : null;

        return response()->json([
            'id' => $document->id,
            'name' => $document->name,
            'file_name' => $document->file_name,
            'layout' => $document->layout,
            'file_url' => $document->fileUrl, // just path
        ]);
    }





    // CREATE if not exists
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'file' => 'required|mimes:pdf|max:10240',
            'layout' => 'nullable|json',
        ]);

        $file = $request->file('file');
        // store only the path in S3
        $path = Storage::disk('s3')->putFile('documents', $file);

        $document = Document::create([
            'name' => $request->name,
            'file_path' => $path,
            'file_name' => $file->getClientOriginalName(),
            'layout' => $request->input('layout'),
        ]);

        return response()->json($document);
    }

    public function updateLayout(Request $request, $id)
    {
        $request->validate([
            'layout' => 'required|array'
        ]);

        $document = Document::findOrFail($id);

        // Replace layout completely
        $document->layout = $request->layout;

        $document->save();

        return response()->json([
            'message' => 'Layout updated successfully',
            'layout' => $document->layout
        ]);
    }

    // UPDATE if exists
    public function update(Request $request, Document $document)
    {
        $request->validate([
            'file' => 'required|mimes:pdf|max:10240',
            'layout' => 'nullable|json',
        ]);

        if ($document->file_path && Storage::disk('s3')->exists($document->file_path)) {
            Storage::disk('s3')->delete($document->file_path);
        }

        $file = $request->file('file');
        $path = Storage::disk('s3')->putFile('documents', $file);

        $document->update([
            'file_path' => $path,
            'file_name' => $file->getClientOriginalName(),
        ]);

        return response()->json($document);
    }

}
