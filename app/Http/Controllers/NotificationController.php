<?php
namespace App\Http\Controllers;

use App\Models\Notification;
use Illuminate\Http\Request;

class NotificationController extends Controller
{
    // Get all notifications for logged-in user
    public function index(Request $request) {
        $notifications = Notification::where('user_id', $request->user()->id)
            ->orderBy('created_at', 'desc')
            ->take(20)
            ->get();

        return response()->json([
            'status' => true,
            'data'   => $notifications,
            'unread' => $notifications->where('is_read', false)->count(),
        ]);
    }

    // Mark a single notification as read
    public function markRead($id, Request $request) {
        $notification = Notification::where('id', $id)
            ->where('user_id', $request->user()->id)
            ->firstOrFail();

        $notification->update(['is_read' => true]);

        return response()->json(['status' => true]);
    }

    // Mark all as read
    public function markAllRead(Request $request) {
        Notification::where('user_id', $request->user()->id)
            ->where('is_read', false)
            ->update(['is_read' => true]);

        return response()->json(['status' => true]);
    }
}