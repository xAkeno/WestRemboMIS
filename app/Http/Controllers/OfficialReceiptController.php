<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\OfficialReceipt;
use Illuminate\Support\Facades\DB;

class OfficialReceiptController extends Controller
{
    /**
     * Auto-generate an OR number and save it to official_receipts.
     */
    public function generate(Request $request)
    {
        $request->validate([
            'type'         => 'required|string',
            'reference_id' => 'nullable|integer',
            'amount'       => 'nullable|numeric',
            'tin_no'       => 'nullable|string',
        ]);

        $orNumber = DB::transaction(function () use ($request) {

            $year = now()->year;

            $prefixMap = [
                'barangay_clearance' => 'BC',
                'business_clearance' => 'BUS',
                'building_clearance' => 'BLD',
                'certificate'        => 'CERT',
                'resident'           => 'RES',
            ];

            $prefix = $prefixMap[$request->type] ?? 'GEN';

            $latest = OfficialReceipt::where('type', $request->type)
                ->where('year', $year)
                ->lockForUpdate()
                ->orderByDesc('id')
                ->first();

            if (!$latest) {
                // No records yet — start at 1
                $nextNumber = 1;
            } elseif (str_ends_with($latest->or_number, '-SEED')) {
                // SEED record format: PREFIX-YEAR-000024-SEED
                // Extract the 6-digit part at position [2]
                $parts      = explode('-', $latest->or_number);
                $nextNumber = intval($parts[2] ?? 0) + 1;
            } else {
                // Real OR format: PREFIX-YEAR-000025
                // The last segment after the final '-' is the number
                $parts      = explode('-', $latest->or_number);
                $nextNumber = intval(end($parts)) + 1;
            }

            $formatted = str_pad($nextNumber, 6, '0', STR_PAD_LEFT);
            $orNumber  = "{$prefix}-{$year}-{$formatted}";

            OfficialReceipt::create([
                'or_number'    => $orNumber,
                'type'         => $request->type,
                'reference_id' => $request->reference_id,
                'amount'       => $request->amount,
                'year'         => $year,
                'tin_no'       => $request->tin_no ?? null,
            ]);

            return $orNumber;
        });

        return response()->json([
            'or_number' => $orNumber,
        ]);
    }

    /**
     * Set a custom starting number for a given OR type.
     * Inserts a SEED record so the next generate() picks up from that number.
     */
    public function setStartingNumber(Request $request)
    {
        $request->validate([
            'type'            => 'required|string',
            'starting_number' => 'required|integer|min:1',
        ]);

        $year = now()->year;

        DB::transaction(function () use ($request, $year) {

            $prefixMap = [
                'barangay_clearance' => 'BC',
                'business_clearance' => 'BUS',
                'building_clearance' => 'BLD',
                'certificate'        => 'CERT',
                'resident'           => 'RES',
            ];

            $prefix = $prefixMap[$request->type] ?? 'GEN';

            // Seed is (starting_number - 1) so next generate() lands on starting_number
            $seedNumber   = max(0, intval($request->starting_number) - 1);
            $formatted    = str_pad($seedNumber, 6, '0', STR_PAD_LEFT);
            $seedOrNumber = "{$prefix}-{$year}-{$formatted}-SEED";

            // Remove any existing SEED for this type + year
            OfficialReceipt::where('type', $request->type)
                ->where('year', $year)
                ->where('or_number', 'like', '%-SEED')
                ->delete();

            // Insert the new SEED record
            OfficialReceipt::create([
                'or_number'    => $seedOrNumber,
                'type'         => $request->type,
                'reference_id' => null,
                'amount'       => 0,
                'year'         => $year,
                'tin_no'       => null,
            ]);
        });

        return response()->json([
            'message'   => 'Starting number set successfully.',
            'starts_at' => str_pad($request->starting_number, 6, '0', STR_PAD_LEFT),
        ]);
    }

    /**
     * List all OR records (optional, useful for admin view).
     */
    public function index(Request $request)
    {
        $query = OfficialReceipt::query()
            ->where('or_number', 'not like', '%-SEED') // exclude seed records
            ->orderByDesc('id');

        if ($request->filled('type')) {
            $query->where('type', $request->type);
        }

        if ($request->filled('year')) {
            $query->where('year', $request->year);
        }

        if ($request->filled('search')) {
            $query->where(function ($q) use ($request) {
                $q->where('or_number', 'like', "%{$request->search}%")
                  ->orWhere('tin_no', 'like', "%{$request->search}%");
            });
        }

        return response()->json([
            'data' => $query->paginate(20),
        ]);
    }

    /**
     * Show a single OR record.
     */
    public function show($id)
    {
        $or = OfficialReceipt::findOrFail($id);

        return response()->json([
            'data' => $or,
        ]);
    }

    /**
     * Update tin_no or other fields on an existing OR record.
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'tin_no' => 'nullable|string',
            'amount' => 'nullable|numeric',
        ]);

        $or = OfficialReceipt::findOrFail($id);

        $or->update($request->only(['tin_no', 'amount']));

        return response()->json([
            'message' => 'OR record updated.',
            'data'    => $or,
        ]);
    }
    public function getByOrNumber(Request $request)
    {
        $request->validate([
            'or_number' => 'required|string'
        ]);

        $or = OfficialReceipt::where('or_number', $request->or_number)->first();

        if (!$or) {
            return response()->json([
                'message' => 'OR not found',
                'data' => null
            ], 404);
        }

        return response()->json([
            'data' => $or
        ]);
    }
    public function updateByOrNumber(Request $request)
    {
        $request->validate([
            'or_number' => 'required|string',
            'tin_no'    => 'nullable|string',
        ]);

        $or = OfficialReceipt::where('or_number', $request->or_number)->first();

        if (!$or) {
            return response()->json([
                'message' => 'OR not found'
            ], 404);
        }

        $or->update([
            'tin_no' => $request->tin_no
        ]);

        return response()->json([
            'message' => 'TIN updated successfully',
            'data' => $or
        ]);
    }
}