<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ActivityLogger;

class ActivityLogController extends Controller
{
    public function index(Request $request)
    {
        $query = ActivityLogger::query()
            ->orderBy('created_at', 'desc');

        // 🔥 FILTER BY DOCUMENT (IMPORTANT PART)
        if ($request->filled('document_id')) {
            $query->where('document_id', $request->document_id);
        }

        // Search logs
        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('user_name', 'like', "%{$search}%")
                  ->orWhere('user_email', 'like', "%{$search}%")
                  ->orWhere('action', 'like', "%{$search}%")
                  ->orWhere('description', 'like', "%{$search}%");
            });
        }

        // Filter by type
        if ($request->filled('type') && $request->type !== 'all') {
            $query->where('type', $request->type);
        }

        $perPage = $request->get('per_page', 20);

        return response()->json(
            $query->paginate($perPage)
        );
    }
}