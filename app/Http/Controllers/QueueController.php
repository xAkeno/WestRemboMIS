<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

use App\Models\QueueItem;
use App\Models\User;
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

    private const SCHEDULED_DATE_COLUMN = 'scheduled_date';

    // Values that mean "not PWD" — anything else is treated as a PWD condition
    private const NON_PWD_VALUES = ['', 'none', 'no', 'n/a', 'not pwd', 'false', '0'];

    // ─────────────────────────────────────────────
    // HELPER: Determine if a pwd_status string means the person IS a PWD
    // ─────────────────────────────────────────────

    private function isPwd(?string $pwdStatus): bool
    {
        if ($pwdStatus === null) return false;
        return !in_array(strtolower(trim($pwdStatus)), self::NON_PWD_VALUES, true);
    }

    // ─────────────────────────────────────────────
    // HELPER: Determine if a date_of_birth means the person is a senior (60+)
    // ─────────────────────────────────────────────

    private function isSenior(?string $dateOfBirth): bool
    {
        if (!$dateOfBirth) return false;
        try {
            return Carbon::parse($dateOfBirth)->age >= 60;
        } catch (\Exception $e) {
            return false;
        }
    }

    // ─────────────────────────────────────────────
    // HELPER: Resolve priority label for a user id
    // Returns: "PWD & Senior" | "PWD" | "Senior" | null
    // ─────────────────────────────────────────────

    private function resolvePriority(?int $userId): ?string
    {
        if (!$userId) return null;

        $user = User::find($userId);
        if (!$user) return null;

        $pwd    = $this->isPwd($user->pwd_status);
        $senior = $this->isSenior($user->date_of_birth);

        if ($pwd && $senior) return 'PWD & Senior';
        if ($pwd)            return 'PWD';
        if ($senior)         return 'Senior';

        return null;
    }

    // ─────────────────────────────────────────────
    // GET QUEUE (TODAY ONLY)
    // ─────────────────────────────────────────────

    public function index()
    {
        $queue = QueueItem::whereDate('queue_date', today())
            ->where('status', '!=', 'done')
            ->orderBy('id')
            ->get();

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

                // ── Priority fields ──────────────────────────────────────────
                // Look up the applicant's user account and attach pwd_status,
                // date_of_birth, and a pre-resolved priority_label so the
                // frontend can display priority without extra API calls.
                $createdBy = $doc->created_by ?? null;
                if ($createdBy) {
                    $user = User::find($createdBy);
                    if ($user) {
                        $arr['pwd_status']      = $user->pwd_status;    // raw string
                        $arr['date_of_birth']   = $user->date_of_birth;
                        $arr['priority_label']  = $this->resolvePriority($createdBy); // "PWD" | "Senior" | "PWD & Senior" | null
                        $arr['is_priority']     = $arr['priority_label'] !== null;
                    }
                }
            }

            return $arr;
        });

        return response()->json([
            'status' => 'success',
            'data'   => $enriched,
        ]);
    }

    // ─────────────────────────────────────────────
    // SEARCH BCERT NUMBER (For Manual/QR Add)
    // ─────────────────────────────────────────────

    public function searchBcert(Request $request)
    {
        $request->validate([
            'bcert_number'  => 'required|string',
            'document_type' => 'required|string',
            'ref_number' => 'nullable|string', // Optional additional reference number for more specific searches
        ]);

        $config = $this->sources[$request->document_type] ?? null;

        if (!$config) {
            return response()->json(['status' => 'error', 'message' => 'Invalid document type'], 400);
        }

        $refField = $config['ref'];
        $item     = $config['model']::where($refField, $request->bcert_number)->first();

        if (!$item) {
            return response()->json(['status' => 'error', 'message' => 'No document found with that reference number'], 404);
        }

        $scheduledDateRaw = $item->{self::SCHEDULED_DATE_COLUMN} ?? null;
        $scheduledDate    = $scheduledDateRaw ? Carbon::parse($scheduledDateRaw) : null;

        $alreadyInQueue = QueueItem::where('document_type', $request->document_type)
            ->where('document_id', $item->id)
            ->whereDate('queue_date', today())
            ->whereIn('status', ['waiting', 'serving'])
            ->exists();

        $alreadyDone = QueueItem::where('document_type', $request->document_type)
            ->where('document_id', $item->id)
            ->whereDate('queue_date', today ())
            ->where('status', 'done')
            ->exists();

        // Resolve priority for the search result preview
        $createdBy     = $item->created_by ?? null;
        $priorityLabel = $this->resolvePriority($createdBy);

        return response()->json([
            'status' => 'success',
            'data'   => [
                'id'               => $item->id,
                'reference_number' => $item->{$refField},
                'applicant_name'   => $this->getApplicantName($item),
                'business_name'    => $item->business_name ?? $item->establishment ?? null,
                'created_by'       => $createdBy,
                'already_in_queue' => $alreadyInQueue,
                'already_done'     => $alreadyDone,
                'scheduled_date'   => $scheduledDate ? $scheduledDate->toDateString() : null,
                'released_date'    => $scheduledDate ? $scheduledDate->toDateString() : null,
                'document_status'  => $item->status,
                'priority_label'   => $priorityLabel,   // "PWD" | "Senior" | "PWD & Senior" | null
                'is_priority'      => $priorityLabel !== null,
            ],
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
            'force'            => 'nullable|boolean',
        ]);

        $today = Carbon::today();

        $existing = QueueItem::where('document_type', $request->document_type)
            ->where('document_id', $request->document_id)
            ->whereDate('queue_date', $today)
            ->first();

        if ($existing && $request->force) {
            $existing->delete();
        } elseif ($existing && !$request->force) {
            $statusMessage = $existing->status === 'done'
                ? 'This document was already processed today. Use force option to add again.'
                : 'Already in queue today. Use force option to requeue.';

            return response()->json([
                'status'  => 'error',
                'message' => $statusMessage,
                'data'    => [
                    'existing_status'  => $existing->status,
                    'reference_number' => $existing->reference_number,
                ],
            ], 409);
        }

        $queueItem = QueueItem::create([
            'document_type'    => $request->document_type,
            'document_id'      => $request->document_id,
            'reference_number' => $request->reference_number,
            'status'           => 'waiting',
            'queue_date'       => $today,
            'manual_added'     => true,
        ]);

        // Attach created_by and priority fields to the response
        $createdBy     = null;
        $priorityLabel = null;
        $config        = $this->sources[$request->document_type] ?? null;

        if ($config) {
            $sourceDoc = $config['model']::find($request->document_id);
            $createdBy = $sourceDoc->created_by ?? null;
        }

        if ($createdBy) {
            $priorityLabel = $this->resolvePriority($createdBy);
        }

        $payload                  = $queueItem->toArray();
        $payload['created_by']    = $createdBy;
        $payload['priority_label'] = $priorityLabel;
        $payload['is_priority']   = $priorityLabel !== null;

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
            QueueItem::whereDate('queue_date', today())
                ->where('status', 'serving')
                ->update(['status' => 'waiting']);

            $next = QueueItem::whereDate('queue_date', today())
                ->where('status', 'waiting')
                ->orderBy('id')
                ->first();

            if (!$next) {
                DB::commit();
                return response()->json(['status' => 'empty', 'message' => 'No queue available']);
            }

            $next->update(['status' => 'serving']);
            DB::commit();

            return response()->json(['status' => 'success', 'data' => $next]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['status' => 'error', 'message' => 'Failed to call next'], 500);
        }
    }

    // ─────────────────────────────────────────────
    // DONE (MARK AS DONE)
    // ─────────────────────────────────────────────

    public function done($id)
    {
        $item = QueueItem::findOrFail($id);
        $item->update(['status' => 'done']);

        return response()->json(['status' => 'success', 'message' => 'Document marked as done']);
    }

    // ─────────────────────────────────────────────
    // CLEANUP OLD QUEUE ENTRIES
    // ─────────────────────────────────────────────

    public function cleanup()
    {
        $deleted = QueueItem::whereDate('queue_date', '<', Carbon::today())->delete();

        return response()->json([
            'status'  => 'success',
            'message' => "Cleaned up {$deleted} old queue entries",
            'data'    => ['deleted' => $deleted],
        ]);
    }

    // ─────────────────────────────────────────────
    // HELPER: Get applicant name from model
    // ─────────────────────────────────────────────

    private function getApplicantName($item): string
    {
        $parts = array_filter([
            $item->first_name  ?? null,
            $item->middle_name ?? null,
            $item->surname     ?? null,
        ]);

        return !empty($parts) ? implode(' ', $parts) : 'N/A';
    }
}