<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateTicketStatusRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'status' => 'required|string|in:Pending,In Progress,Approved,Rejected,Released',
            'staff_id' => 'nullable|exists:users,id',
            'remarks' => 'nullable|string|max:2000',
        ];
    }
}
