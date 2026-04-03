<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\OfficialReceipt;
use Illuminate\Support\Facades\DB;

class OfficialReceiptController extends Controller
{
    public function generate(Request $request)
    {
        $request->validate([
            'type' => 'required|string',
            'reference_id' => 'nullable|integer',
            'amount' => 'nullable|numeric'
        ]);

        $orNumber = DB::transaction(function () use ($request) {

            $year = now()->year;

            $prefixMap = [
                'barangay_clearance' => 'BC',
                'business_clearance' => 'BUS',
                'building_clearance' => 'BLD',
                'certificate' => 'CERT',
            ];

            $prefix = $prefixMap[$request->type] ?? 'GEN';

            $latest = OfficialReceipt::where('type', $request->type)
                ->where('year', $year)
                ->lockForUpdate()
                ->orderByDesc('id')
                ->first();

            $nextNumber = $latest
                ? intval(substr($latest->or_number, -6)) + 1
                : 1;

            $formatted = str_pad($nextNumber, 6, '0', STR_PAD_LEFT);

            $orNumber = "{$prefix}-{$year}-{$formatted}";

            // SAVE 🔥
            OfficialReceipt::create([
                'or_number' => $orNumber,
                'type' => $request->type,
                'reference_id' => $request->reference_id,
                'amount' => $request->amount,
                'year' => $year
            ]);

            return $orNumber;
        });

        return response()->json([
            'or_number' => $orNumber
        ]);
    }
}
