<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Document;
use Illuminate\Support\Facades\Storage;

class DocumentController extends Controller
{
    public function index()
    {
        $workerBaseUrl = env('R2_WORKER_URL'); // your Worker base URL

        $documents = Document::all()->map(function($doc) use ($workerBaseUrl) {
            return [
                'id' => $doc->id,
                'name' => $doc->name,
                'file_name' => $doc->file_name,
                'layout' => $doc->layout,
                'file_url' => $doc->file_path ? $workerBaseUrl . '/' . $doc->file_path : null, // full URL
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

        return response()->json([
            'id' => $document->id,
            'name' => $document->name,
            'file_name' => $document->file_name,
            'layout' => $document->layout,
            'file_url' => $document->file_path ? $workerBaseUrl . '/' . $document->file_path : null,
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'file' => 'required|mimes:pdf|max:10240',
            'layout' => 'nullable|json',
        ]);

        $file = $request->file('file');
        $path = Storage::disk('s3')->putFile('documents', $file);

        $document = Document::create([
            'name' => $request->name,
            'file_path' => $path,
            'file_name' => $file->getClientOriginalName(),
            'layout' => $request->input('layout'),
        ]);

        $workerBaseUrl = env('R2_WORKER_URL');

        return response()->json([
            'id' => $document->id,
            'name' => $document->name,
            'file_name' => $document->file_name,
            'layout' => $document->layout,
            'file_url' => $path ? $workerBaseUrl . '/' . $path : null,
        ]);
    }

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

        $workerBaseUrl = env('R2_WORKER_URL');

        return response()->json([
            'id' => $document->id,
            'name' => $document->name,
            'file_name' => $document->file_name,
            'layout' => $document->layout,
            'file_url' => $path ? $workerBaseUrl . '/' . $path : null,
        ]);
    }

    public function updateLayout(Request $request, $id)
    {
        $request->validate([
            'layout' => 'required|array'
        ]);

        $document = Document::findOrFail($id);
        $document->layout = $request->layout;
        $document->save();

        return response()->json([
            'message' => 'Layout updated successfully',
            'layout' => $document->layout
        ]);
    }
}