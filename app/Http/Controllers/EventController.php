<?php

namespace App\Http\Controllers;

use App\Models\Event;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use App\Mail\NewEventNotification;
use Illuminate\Support\Facades\Mail;
use App\Models\User;
class EventController extends Controller
{
    // Admin view: return all events
    public function index() {
        return response()->json([
            'status' => true,
            'data' => Event::all()
        ]);
    }

    // Public API for calendar display
    public function publicIndex()
    {
        $events = Event::where('published', true)
            ->get()
            ->map(function ($event) {
                return [
                    'id' => $event->id,
                    'title' => $event->title,
                    'start' => $event->date . 'T' . $event->start_time, // ISO format
                    'end' => $event->date . 'T' . ($event->end_time ?? $event->start_time),
                    'color' => $event->color ?? '#0047AB',
                    'extendedProps' => [
                        'description' => $event->description,
                        'location' => $event->location,
                        'image' => $event->image ? asset('storage/' . $event->image) : null,
                        'important' => $event->important,
                    ],
                ];
            });

        return response()->json([
            'status' => true,
            'data' => $events
        ]);
    }

    // Create a new event
    public function store(Request $request) {
        $data = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'location' => 'nullable|string|max:255',
            'date' => 'required|date',
            'start_time' => 'required',
            'end_time' => 'nullable',
            'published' => 'required|boolean',
            'color' => 'nullable|string|max:7',
            'important' => 'nullable|boolean',
            'image' => 'nullable|image|max:2048',
        ]);

        if ($request->hasFile('image')) {
            $data['image'] = $request->file('image')->store('events', 'public');
        }

        $event = Event::create($data);

        $users = User::all(); // or filter only active users
        foreach ($users as $user) {
            Mail::to($user->email)->queue(new NewEventNotification($event));
        }

        return response()->json(['status' => true, 'data' => $event], 201);
    }

    // Show single event
    public function show(Event $event) {
        return response()->json([
            'status' => true,
            'data' => $event
        ]);
    }

    // Update an existing event
    public function update(Request $request, Event $event) {
        $data = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'location' => 'nullable|string|max:255',
            'date' => 'required|date',
            'start_time' => 'required',
            'end_time' => 'nullable',
            'published' => 'required|boolean',
            'color' => 'nullable|string|max:7',
            'important' => 'nullable|boolean',
            'image' => 'nullable|image|max:2048',
        ]);

        if ($request->hasFile('image')) {
            if ($event->image) Storage::disk('public')->delete($event->image);
            $data['image'] = $request->file('image')->store('events', 'public');
        }

        $event->update($data);

        return response()->json(['status' => true, 'data' => $event]);
    }

    // Delete an event
    public function destroy(Event $event) {
        if ($event->image) Storage::disk('public')->delete($event->image);
        $event->delete();

        return response()->json(['status' => true, 'message' => 'Event deleted']);
    }
}