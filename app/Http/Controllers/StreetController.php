<?php

namespace App\Http\Controllers;

use App\Models\Street;
use Illuminate\Http\Request;

class StreetController extends Controller
{
    public function index()
    {
        return response()->json(Street::all());
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'sitio' => 'nullable|string',
            'formerly' => 'nullable|string',
        ]);

        $street = Street::create($request->only('name', 'sitio', 'formerly'));

        return response()->json($street, 201);
    }

    public function show(Street $street)
    {
        return response()->json($street);
    }

    public function update(Request $request, Street $street)
    {
        $request->validate([
            'name' => 'sometimes|required|string',
            'sitio' => 'nullable|string',
            'formerly' => 'nullable|string',
        ]);

        $street->update($request->only('name', 'sitio', 'formerly'));

        return response()->json($street);
    }

    public function destroy(Street $street)
    {
        $street->delete();
        return response()->json(null, 204);
    }
}