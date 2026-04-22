<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class DocumentReplyController extends Controller
{   
    private function resolveModel($type)
    {
        return match ($type) {
            'barangay_clearance' => \App\Models\BarangayClearance::class,
            'business_clearance' => \App\Models\BusinessClearance::class,
            'building_clearance' => \App\Models\BuildingClearance::class,
            'barangay_certificate' => \App\Models\BarangayCertificate::class,
            default => abort(404, 'Invalid type'),
        };
    }
    public function index($type, $id)
    {
        $replies = \App\Models\DocumentReply::where('document_type', $type)
            ->where('document_id', $id)
            ->latest()
            ->get();

        return response()->json([
            'data' => $replies
        ]);
    }
    public function store(Request $request, $type, $id)
    {
        $request->validate([
            'message' => 'required|string',
            'status' => 'nullable|in:info,warning,missing,approved',
        ]);

        $reply = \App\Models\DocumentReply::create([
            'document_type' => $type,
            'document_id' => $id,
            'user_id' => auth()->id(), // or pass manually
            'message' => $request->message,
            'status' => $request->status ?? 'info',
        ]);

        // 🔥 OPTIONAL: auto update main document status
        if ($request->status === 'missing') {
            $model = $this->resolveModel($type);
            $record = $model::find($id);
            if ($record) {
                $record->status = 'pending';
                $record->save();
            }
        }

        return response()->json([
            'message' => 'Reply added',
            'data' => $reply
        ]);
    }
}
