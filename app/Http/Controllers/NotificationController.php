<?php

namespace App\Http\Controllers;

use App\Models\Notification;
use Illuminate\Http\Request;
use App\Http\Resources\NotificationResource;

class NotificationController extends Controller
{
    public function index(Request $request)
    {
        $query = Notification::query();
        if ($request->has('user_id')) {
            $query->where('user_id', $request->user_id);
        }
        $perPage = (int) $request->get('per_page', 20);
        $notifications = $query->orderBy('created_at', 'desc')->paginate($perPage);

        return NotificationResource::collection($notifications);
    }
}
