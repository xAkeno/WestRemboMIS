<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Http;

class AIController extends Controller
{
    // Embed text and search in Qdrant
    public function embedTest()
    {
        $query = "Requirements for Barangay clearance";

        // 1. Get embedding from Gemini
        $response = Http::withHeaders([
            'Content-Type' => 'application/json',
        ])->post(
            "https://generativelanguage.googleapis.com/v1beta/models/gemini-embedding-001:embedContent?key=" . env('GEMINI_API_KEY'),
            [
                "content" => [
                    "text" => $query
                ]
            ]
        );

        if ($response->failed()) {
            return response()->json(['error' => 'Failed to get embedding', 'details' => $response->body()], 500);
        }

        $embedding = $response->json()['embedding'];

        // 2. Store embedding in Qdrant
        $storeResponse = Http::post(env('VECTOR_DB').'/collections/chatbot/points', [
            "points" => [
                [
                    "id" => uniqid(),
                    "vector" => $embedding,
                    "payload" => [
                        "text" => $query,
                        "type" => "document"
                    ]
                ]
            ]
        ]);

        // 3. Optionally search right away
        $searchResponse = Http::post(env('VECTOR_DB').'/collections/chatbot/points/search', [
            "vector" => $embedding,
            "limit" => 5
        ]);

        return response()->json([
            'embedding' => $embedding,
            'stored' => $storeResponse->json(),
            'search' => $searchResponse->json()
        ]);
    }
}