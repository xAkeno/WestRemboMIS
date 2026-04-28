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
            'ref'   => 'brgy_business_no',
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
    // SEARCH BCERT NUMBER (For Manual/QR Add)
    // ─────────────────────────────────────────────

    public function searchBcert(Request $request)
    {
        $request->validate([
            'bcert_number' => 'required|string',
            'document_type' => 'required|string'
        ]);

        $config = $this->sources[$request->document_type] ?? null;
        
        if (!$config) {
            return response()->json([
                'status' => 'error',
                'message' => 'Invalid document type'
            ], 400);
        }

        $refField = $config['ref'];
        $item = $config['model']::where($refField, $request->bcert_number)
            ->first();

        if (!$item) {
            return response()->json([
                'status' => 'error',
                'message' => 'No document found with that reference number'
            ], 404);
        }

        // Check if document was released today (using updated_at)
        $isReleasedToday = $item->status === 'RELEASED' && 
                           Carbon::parse($item->updated_at)->isToday();

        if (!$isReleasedToday) {
            return response()->json([
                'status' => 'error',
                'message' => 'Document was not released today. Only today\'s released documents can be added to queue.',
                'data' => [
                    'released_date' => Carbon::parse($item->updated_at)->toDateString(),
                    'status' => $item->status
                ]
            ], 400);
        }

        // Check if already in queue today
        $alreadyInQueue = QueueItem::where('document_type', $request->document_type)
            ->where('document_id', $item->id)
            ->whereDate('queue_date', today())
            ->whereIn('status', ['waiting', 'serving'])
            ->exists();

        $alreadyDone = QueueItem::where('document_type', $request->document_type)
            ->where('document_id', $item->id)
            ->whereDate('queue_date', today())
            ->where('status', 'done')
            ->exists();

        return response()->json([
            'status' => 'success',
            'data' => [
                'id' => $item->id,
                'reference_number' => $item->{$refField},
                'applicant_name' => $this->getApplicantName($item),
                'business_name' => $item->business_name ?? $item->establishment ?? null,
                'already_in_queue' => $alreadyInQueue,
                'already_done' => $alreadyDone,
                'released_date' => Carbon::parse($item->updated_at)->toDateString()
            ]
        ]);
    }

    // ─────────────────────────────────────────────
    // MANUAL ADD (For both Manual form and QR scan)
    // ─────────────────────────────────────────────

    public function manualAdd(Request $request)
    {
        $request->validate([
            'document_type'    => 'required|string',
            'document_id'      => 'required|integer',
            'reference_number' => 'required|string',
            'force'            => 'nullable|boolean'
        ]);

        $today = Carbon::today();

        $existing = QueueItem::where('document_type', $request->document_type)
            ->where('document_id', $request->document_id)
            ->whereDate('queue_date', $today)
            ->first();

        // If exists and force is true, delete the existing entry
        if ($existing && $request->force) {
            $existing->delete();
        } 
        // If exists and force is false, return error
        elseif ($existing && !$request->force) {
            $statusMessage = $existing->status === 'done' 
                ? 'This document was already processed today. Use force option to add again.'
                : 'Already in queue today. Use force option to requeue.';
                
            return response()->json([
                'status' => 'error',
                'message' => $statusMessage,
                'data' => [
                    'existing_status' => $existing->status,
                    'reference_number' => $existing->reference_number
                ]
            ], 409);
        }

        // Create new queue entry
        $queueItem = QueueItem::create([
            'document_type'    => $request->document_type,
            'document_id'      => $request->document_id,
            'reference_number' => $request->reference_number,
            'status'           => 'waiting',
            'queue_date'       => $today,
            'manual_added'     => true,
        ]);

        return response()->json([
            'status' => 'success',
            'message' => $existing ? 'Requeued successfully' : 'Added to queue successfully',
            'data' => $queueItem
        ]);
    }

    // ─────────────────────────────────────────────
    // NEXT (CALL NEXT IN LINE)
    // ─────────────────────────────────────────────

    public function next()
    {
        DB::beginTransaction();
        
        try {
            // Mark any currently-serving item back to waiting
            QueueItem::whereDate('queue_date', today())
                ->where('status', 'serving')
                ->update(['status' => 'waiting']);

            $next = QueueItem::whereDate('queue_date', today())
                ->where('status', 'waiting')
                ->orderBy('id')
                ->first();

            if (!$next) {
                DB::commit();
                return response()->json([
                    'status' => 'empty',
                    'message' => 'No queue available'
                ]);
            }

            $next->update(['status' => 'serving']);
            
            DB::commit();

            return response()->json([
                'status' => 'success',
                'data'   => $next
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to call next'
            ], 500);
        }
    }

    // ─────────────────────────────────────────────
    // DONE (MARK AS DONE)
    // ─────────────────────────────────────────────

    public function done($id)
    {
        $item = QueueItem::findOrFail($id);

        $item->update([
            'status' => 'done'
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Document marked as done'
        ]);
    }

    // ─────────────────────────────────────────────
    // CLEANUP OLD QUEUE ENTRIES (Optional - can be removed)
    // ─────────────────────────────────────────────

    public function cleanup()
    {
        $today = Carbon::today();
        $deleted = QueueItem::whereDate('queue_date', '<', $today)->delete();
        
        return response()->json([
            'status' => 'success',
            'message' => "Cleaned up {$deleted} old queue entries",
            'data' => ['deleted' => $deleted]
        ]);
    }

    // ─────────────────────────────────────────────
    // HELPER: Get applicant name from model
    // ─────────────────────────────────────────────

    private function getApplicantName($item)
    {
        $nameParts = [];
        
        if (isset($item->first_name)) $nameParts[] = $item->first_name;
        if (isset($item->middle_name) && $item->middle_name) $nameParts[] = $item->middle_name;
        if (isset($item->surname)) $nameParts[] = $item->surname;
        
        return !empty($nameParts) ? implode(' ', $nameParts) : 'N/A';
    }
}