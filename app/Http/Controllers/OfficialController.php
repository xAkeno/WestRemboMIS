<?php

namespace App\Http\Controllers;

use App\Models\Official;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class OfficialController extends Controller
{
    // Get all officials (ordered by display_order)
    public function index()
    {
        $officials = Official::orderBy('display_order')->get();

        return response()->json([
            'status' => 'success',
            'data' => $officials,
        ]);
    }

    // Store a new official
    public function store(Request $request)
    {
        $request->validate([
            'profile_image' => 'nullable|image|mimes:jpg,jpeg,png,webp|max:2048',
            'full_name' => 'required|string|max:255',
            'position' => 'required|string|max:255',
            'committee_role' => 'nullable|string|max:255',
            'term' => 'nullable|string|max:50',
            'display_order' => 'nullable|integer',
            'visible' => 'nullable|boolean',
        ]);

        $imagePath = null;
        if ($request->hasFile('profile_image')) {
            $file = $request->file('profile_image');
            $imagePath = Storage::disk('s3')->putFile('officials', $file); // 👈 S3 upload
        }

        $official = Official::create([
            'profile_image' => $imagePath,
            'full_name' => $request->full_name,
            'position' => $request->position,
            'committee_role' => $request->committee_role,
            'term' => $request->term,
            'display_order' => $request->display_order ?? 0,
            'visible' => $request->boolean('visible', false),
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Official created successfully',
            'data' => $official,
        ], 201);
    }

    // Update an official
    public function update(Request $request, $id)
    {
        $official = Official::findOrFail($id);

        $request->validate([
            'profile_image' => 'nullable|image|mimes:jpg,jpeg,png,webp|max:2048',
            'full_name' => 'required|string|max:255',
            'position' => 'required|string|max:255',
            'committee_role' => 'nullable|string|max:255',
            'term' => 'nullable|string|max:50',
            'display_order' => 'nullable|integer',
            'visible' => 'nullable|boolean',
        ]);

        if ($request->hasFile('profile_image')) {
            // Delete old image from S3
            if ($official->profile_image) {
                Storage::disk('s3')->delete($official->profile_image);
            }
            $official->profile_image = Storage::disk('s3')->putFile('officials', $request->file('profile_image'));
        }

        $official->update(array_merge(
            $request->except('profile_image'),
            ['visible' => $request->boolean('visible', $official->visible)]
        ));

        return response()->json([
            'status' => 'success',
            'message' => 'Official updated successfully',
            'data' => $official,
        ]);
    }

    // Delete an official
    public function destroy($id)
    {
        $official = Official::findOrFail($id);

        if ($official->profile_image) {
            Storage::disk('s3')->delete($official->profile_image);
        }

        $official->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Official deleted successfully',
        ]);
    }
}