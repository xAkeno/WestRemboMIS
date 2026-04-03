<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ServicePrice;

class ServicePriceController extends Controller
{
    // GET /service-prices
    public function index()
    {
        $prices = ServicePrice::all();

        return response()->json([
            'data' => $prices
        ]);
    }

    // PUT /service-prices/{type}
    public function update(Request $request, $type)
    {
        $request->validate([
            'amount' => 'required|numeric|min:0'
        ]);

        $price = ServicePrice::updateOrCreate(
            ['type' => $type],
            ['amount' => $request->amount]
        );

        return response()->json([
            'message' => 'Service price updated',
            'data' => $price
        ]);
    }
}