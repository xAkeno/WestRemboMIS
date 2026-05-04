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
    // CONFIG: Column name that holds the scheduled date in the source models.
    // If your column is named differently (e.g. schedule_date,
    // dry_seal_schedule_date, appointment_date), change this constant.
    // ─────────────────────────────────────────────
    private const SCHEDULED_DATE_COLUMN = 'scheduled_date';


    // ─────────────────────────────────────────────
    // GET QUEUE (TODAY ONLY)
    // ─────────────────────────────────────────────


    public function index()
    {
        $queue = QueueItem::whereDate('queue_date', today())
            ->where('status', '!=', 'done')
            ->orderBy('id')
            ->get();


        // Enrich each queue item with applicant_name, business_name, and created_by
        // by looking up the source document. The frontend uses created_by to
        // determine PWD/Senior priority.
        $enriched = $queue->map(function ($q) {
            $config = $this->sources[$q->document_type] ?? null;
            if (!$config) {
                return $q->toArray();
            }


            $doc = $config['model']::find($q->document_id);
            $arr = $q->toArray();


            if ($doc) {
                $arr['applicant_name'] = $this->getApplicantName($doc);
                $arr['business_name']  = $doc->business_name ?? $doc->establishment ?? null;
                $arr['created_by']     = $doc->created_by ?? null;
            }


            return $arr;
        });


        return response()->json([
            'status' => 'success',
            'data'   => $enriched
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


        // ─────────────────────────────────────────────
        // GATE: status must be SCHEDULED AND scheduled_date == today.
        // ─────────────────────────────────────────────
        $statusOk = strtoupper((string) $item->status) === 'SCHEDULED';


        $scheduledDateRaw = $item->{self::SCHEDULED_DATE_COLUMN} ?? null;
        $scheduledDate    = $scheduledDateRaw ? Carbon::parse($scheduledDateRaw) : null;
        $scheduledIsToday = $scheduledDate ? $scheduledDate->isToday() : false;


        if (!$statusOk || !$scheduledIsToday) {
            // Build a precise reason for the frontend toast / error display.
            if (!$statusOk) {
                $message = 'Document is not scheduled. Only documents with status SCHEDULED can be added to the queue.';
            } elseif (!$scheduledDate) {
                $message = 'Document has no scheduled date set.';
            } elseif ($scheduledDate->isFuture()) {
                $message = 'Document is scheduled for ' . $scheduledDate->toDateString() . '. It can only be queued on its scheduled day.';
            } else {
                $message = 'Document\'s scheduled date has already passed (' . $scheduledDate->toDateString() . ').';
            }


            return response()->json([
                'status'  => 'error',
                'message' => $message,
                'data'    => [
                    'scheduled_date' => $scheduledDate ? $scheduledDate->toDateString() : null,
                    'status'         => $item->status,
                ],
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
                'id'                => $item->id,
                'reference_number'  => $item->{$refField},
                'applicant_name'    => $this->getApplicantName($item),
                'business_name'     => $item->business_name ?? $item->establishment ?? null,
                'created_by'        => $item->created_by ?? null,
                'already_in_queue'  => $alreadyInQueue,
                'already_done'      => $alreadyDone,
                'scheduled_date'    => $scheduledDate->toDateString(),
                'released_date'     => $scheduledDate->toDateString(), // legacy alias for older frontend builds
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


        // Look up created_by from the source document so the frontend
        // can run its PWD/Senior priority check after a successful add.
        $createdBy = null;
        $config = $this->sources[$request->document_type] ?? null;
        if ($config) {
            $sourceDoc = $config['model']::find($request->document_id);
            $createdBy = $sourceDoc->created_by ?? null;
        }


        $payload = $queueItem->toArray();
        $payload['created_by'] = $createdBy;


        return response()->json([
            'status'  => 'success',
            'message' => $existing ? 'Requeued successfully' : 'Added to queue successfully',
            'data'    => $payload,
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