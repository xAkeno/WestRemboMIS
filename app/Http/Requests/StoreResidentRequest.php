<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreResidentRequest extends FormRequest
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
            // 'resident_id' => 'required|string|unique:residents,resident_id|max:50',
            'requester_type' => 'required|string|max:50',
            'prefix' => 'nullable|string|max:10',
            'surname' => 'required|string|max:100',
            'first_name' => 'required|string|max:100',
            'middle_name' => 'nullable|string|max:100',
            'ext_name' => 'nullable|string|max:10',
            'nick_name' => 'nullable|string|max:50',
            'sex' => 'nullable|string|max:10',
            'marital_status' => 'nullable|string|max:20',
            'name_of_spouse' => 'nullable|string|max:100',
            'house_block_lot_no' => 'nullable|string|max:50',
            'street' => 'nullable|string|max:100',
            'zone' => 'nullable|string|max:50',
            'resident_status' => 'nullable|string|max:50',
            'dob' => 'nullable|date',
            'pob' => 'nullable|string|max:100',
            'height_cm' => 'nullable|integer|min:0|max:300',
            'weight_kg' => 'nullable|integer|min:0|max:500',
            'blood_type' => 'nullable|string|max:10',
            'complexion' => 'nullable|string|max:50',
            'religion' => 'nullable|string|max:50',
            'voter_status' => 'nullable|string|max:20',
            'precinct_no' => 'nullable|string|max:20',
            'email' => 'nullable|email|max:255',
            'emp_status' => 'nullable|string|max:50',
            'occupation' => 'nullable|string|max:100',
            'position' => 'nullable|string|max:100',
            'pwd' => 'nullable|string|max:10',
            'period_of_residency' => 'nullable|string|max:50',
            'house_owner' => 'nullable|string|max:50',
            'relationship_to_owner' => 'nullable|string|max:50',
            'phone_number' => 'nullable|regex:/^[0-9+\-\s]+$/|max:20',
            'email_address' => 'nullable|email|max:150',
            'notes' => 'nullable|string|max:1000',
            'photo' => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
            'status' => 'sometimes|string|in:ENCODED,SCHEDULED,VERIFICATION,TO_PAY,PAID,RELEASED,REJECTED,RESCHEDULED,INCOMPLETE,EXPIRED,PENDING',   
        ];
    }
}

