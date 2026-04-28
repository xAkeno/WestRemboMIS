<?php
// app/Http/Controllers/QueueController.php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

use App\Models\QueueItem;
use App\Models\BarangayClearance;
use App\Models\BarangayCertificate;
use App\Models\BarangayBuildingClearance;
use App\Models\BarangayBusinessClearance;

class QueueController extends Controller
{
    // ─────────────────────────────────────────────
    // CONFIG SOURCES
    // ─────────────────────────────────────────────

    private array $sources = [
        'barangay_clearance' => [
            'model' => BarangayClearance::class,
            'ref'   => 'bcert_number',
        ],
        'barangay_certificate' => [
            'model' => BarangayCertificate::class,
            'ref'   => 'bcert_number',
        ],
        'building_clearance' => [
            'model' => BarangayBuildingClearance::class,
            'ref'   => 'bcert_number',
        ],
        'business_clearance' => [
            'model' => BarangayBusinessClearance::class,
            'ref'   => 'brgy_business_no',       // ← different ref field
        ],
    ];

    // ─────────────────────────────────────────────
    // GET QUEUE (TODAY ONLY)
    // ─────────────────────────────────────────────

    public function index()
    {
        $queue = QueueItem::whereDate('queue_date', today())
            ->where('status', '!=', 'done')
            ->orderBy('id')
            ->get();

        return response()->json([
            'status' => 'success',
            'data'   => $queue
        ]);
    }

    // ─────────────────────────────────────────────
    // AUTO ADD RELEASED TODAY
    // ─────────────────────────────────────────────

    public function autoAdd()
    {
        foreach ($this->sources as $type => $config) {
            $refField = $config['ref'];   // bcert_number OR brgy_business_no

            // FIX: filter by the correct ref field per document type,
            // not a hardcoded 'bcert_number' for all types.
            $items = $config['model']::where('status', 'RELEASED')
                ->whereNotNull($refField)
                ->get();

            foreach ($items as $item) {

                $exists = QueueItem::where('document_type', $type)
                    ->where('document_id', $item->id)
                    ->whereIn('status', ['waiting', 'serving'])
                    ->exists();

                if ($exists) continue;

                QueueItem::create([
                    'document_type'    => $type,
                    'document_id'      => $item->id,
                    'reference_number' => $item->{$refField} ?? "#{$item->id}",
                    'status'           => 'waiting',
                    'queue_date'       => now()->toDateString(),
                    'manual_added'     => false,
                ]);
            }
        }

        return response()->json([
            'status'  => 'success',
            'message' => 'Queue generated from all released documents'
        ]);
    }

    // ─────────────────────────────────────────────
    // MANUAL ADD (WITH DUPLICATE CONTROL + REQUEUE)
    // ─────────────────────────────────────────────

    public function manualAdd(Request $request)
    {
        $request->validate([
            'document_type'    => 'required',
            'document_id'      => 'required',
            'reference_number' => 'required',
            'force'            => 'nullable|boolean'
        ]);

        $today = Carbon::today();

        $existing = QueueItem::where('document_type', $request->document_type)
            ->where('document_id', $request->document_id)
            ->whereDate('queue_date', $today)
            ->first();

        if ($existing && !$request->force) {
            return response()->json([
                'status' => 'error',
                'message' => 'Already in queue today'
            ]);
        }

        if ($existing && $request->force) {
            $existing->delete();
        }

        QueueItem::create([
            'document_type'    => $request->document_type,
            'document_id'      => $request->document_id,
            'reference_number' => $request->reference_number,
            'status'           => 'waiting',
            'queue_date'       => $today,
            'manual_added'     => true,
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Added to queue'
        ]);
    }

    // ─────────────────────────────────────────────
    // NEXT (CALL NEXT IN LINE)
    // ─────────────────────────────────────────────

    public function next()
    {
        // Mark any currently-serving item back to waiting first,
        // so only one item is ever in "serving" state at a time.
        QueueItem::whereDate('queue_date', today())
            ->where('status', 'serving')
            ->update(['status' => 'waiting']);

        $next = QueueItem::whereDate('queue_date', today())
            ->where('status', 'waiting')
            ->orderBy('id')
            ->first();

        if (!$next) {
            return response()->json([
                'status' => 'empty',
                'message' => 'No queue available'
            ]);
        }

        $next->update(['status' => 'serving']);

        return response()->json([
            'status' => 'success',
            'data'   => $next
        ]);
    }

    // ─────────────────────────────────────────────
    // DONE (REMOVE FROM QUEUE ONLY)
    // ─────────────────────────────────────────────

    public function done($id)
    {
        $item = QueueItem::findOrFail($id);

        $item->update([
            'status' => 'done'
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Removed from queue'
        ]);
    }

    // ─────────────────────────────────────────────
    // REQUEUE (DESTROYED / NEEDS REQUEUE CASE)
    // ─────────────────────────────────────────────

    public function requeue(Request $request)
    {
        $request->validate([
            'document_type' => 'required',
            'document_id'   => 'required',
        ]);

        $today = Carbon::today();

        QueueItem::updateOrCreate(
            [
                'document_type' => $request->document_type,
                'document_id'   => $request->document_id,
                'queue_date'    => $today,
            ],
            [
                'status'       => 'waiting',
                'manual_added' => true,
            ]
        );

        return response()->json([
            'status' => 'success',
            'message' => 'Requeued successfully'
        ]);
    }

    // ─────────────────────────────────────────────
    // DISPLAY (NOW SERVING)
    // ─────────────────────────────────────────────

    public function nowServing()
    {
        $current = QueueItem::whereDate('queue_date', today())
            ->where('status', 'serving')
            ->first();

        $waiting = QueueItem::whereDate('queue_date', today())
            ->where('status', 'waiting')
            ->orderBy('id')
            ->get();

        return response()->json([
            'now_serving' => $current,
            'up_next'     => $waiting
        ]);
    }
}