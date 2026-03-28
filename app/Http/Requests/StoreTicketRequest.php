<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreTicketRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'service_type' => 'required|string|in:Barangay Clearance,Business Clearance,Building Clearance,Barangay Certificate,Resident Registration',
            'priority' => 'nullable|string|in:Low,Normal,High',
            'requester_id' => 'nullable|exists:users,id',
            'submitted_at' => 'nullable|date',
            'service_data' => 'nullable|array',
        ];
    }
}
