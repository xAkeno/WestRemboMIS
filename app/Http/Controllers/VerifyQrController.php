<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class VerifyQrController extends Controller
{
    public function verify(Request $request)
    {
        $request->validate([
            'ref' => 'required|string',
            'key' => 'required|string',
        ]);

        $ref         = $request->ref;
        $providedKey = $request->key;
        $secret      = env('QR_SECRET_KEY', 'fallback-secret');

        $expectedKey = hash_hmac('sha256', $ref, $secret);

        if (!hash_equals($expectedKey, $providedKey)) {
            return response()->json([
                'valid'   => false,
                'message' => 'Invalid or tampered QR code.',
            ], 403);
        }

        return response()->json([
            'valid'   => true,
            'message' => 'QR signature is valid.',
        ]);
    }
}