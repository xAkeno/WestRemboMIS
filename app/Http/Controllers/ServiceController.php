<?php

namespace App\Http\Controllers;

use App\Models\Service;
use Illuminate\Http\Request;

class ServiceController extends Controller
{
    // Show all services
    public function index()
    {
        $services = Service::all();
        return response()->json($services);
    }

    // Show a single service
    public function show($id)
    {
        $service = Service::findOrFail($id);
        return response()->json($service);
    }

    // Create a new service
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'description' => 'required|string',
            'requirements' => 'required|string',
            'processing_time' => 'required|string',
            'fee' => 'nullable|string',
        ]);

        $service = Service::create($request->all());
        return response()->json($service, 201);
    }

    // Update a service
    public function update(Request $request, $id)
    {
        $service = Service::findOrFail($id);
        $service->update($request->all());
        return response()->json($service);
    }

    // Delete a service
    public function destroy($id)
    {
        $service = Service::findOrFail($id);
        $service->delete();
        return response()->json(['message' => 'Service deleted']);
    }
}