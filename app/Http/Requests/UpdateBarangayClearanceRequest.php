<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateBarangayClearanceRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'trans_number' => 'nullable|string|max:50',
            'bcert_number' => 'nullable|string|max:50',
            'issued_date' => 'nullable|date',
            'prefix' => 'nullable|string|max:10',
            'surname' => 'sometimes|required|string|max:100',
            'first_name' => 'sometimes|required|string|max:100',
            'middle_name' => 'nullable|string|max:100',
            'ext_name' => 'nullable|string|max:10',
            'house_block_lot_no' => 'nullable|string|max:50',
            'street' => 'nullable|string|max:100',
            'zone' => 'nullable|string|max:50',
            'dob' => 'nullable|date',
            'pob' => 'nullable|string|max:100',
            'contact_no' => 'nullable|regex:/^[0-9+\-\s]+$/|max:20',
            'period_of_residency' => 'nullable|string|max:50',
            'registered_voter' => 'nullable|string|max:20',
            'house_owner' => 'nullable|string|max:50',
            'relationship_to_owner' => 'nullable|string|max:50',
            'purpose' => 'nullable|string|max:100',
            'purpose_details' => 'nullable|string|max:500',
            'ctc_vrr_no' => 'nullable|string|max:50',
            'issued_at' => 'nullable|string|max:100',
            'issued_on' => 'nullable|date',
            'email' => 'nullable|email|max:255',
            'or_no' => 'nullable|string|max:50',
            'bomarke' => 'nullable|string|max:50',
            'rejection_reason' => 'nullable|string|max:1000',
            'status' => 'sometimes|string|in:ENCODED,SCHEDULED,VERIFICATION,TO_PAY,PAID,RELEASED,REJECTED,RESCHEDULED,INCOMPLETE,EXPIRED,PENDING,INSPECTING',   
        ];
    }
}

