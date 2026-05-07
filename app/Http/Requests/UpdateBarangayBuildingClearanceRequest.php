<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateBarangayBuildingClearanceRequest extends FormRequest
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
            'bcert_number' => 'nullable|string|max:50',
            'issued_date' => 'nullable|date',

            'prefix' => 'nullable|string|max:10',
            'surname' => 'sometimes|required|string|max:100',
            'first_name' => 'sometimes|required|string|max:100',
            'middle_name' => 'nullable|string|max:100',
            'ext_name' => 'nullable|string|max:10',

            'establishment' => 'nullable|string|max:200',
            'house_block_lot_no' => 'nullable|string|max:50',
            'street' => 'nullable|string|max:100',
            'zone' => 'nullable|string|max:50',

            'purpose' => 'nullable|string|max:100',
            'purpose_details' => 'nullable|string|max:500',

            'or_no' => 'nullable|string|max:50', // ✅ FIXED
            'email' => 'nullable|email|max:255',
            'remarks' => 'nullable|string|max:500',
            'punong_barangay' => 'nullable|string|max:100',
            'for_the_punong_barangay' => 'nullable|string|max:100',
            'barangay_position' => 'nullable|string|max:50',
            'rejection_reason' => 'nullable|string|max:1000',
            'status' => 'sometimes|string|in:ENCODED,SCHEDULED,VERIFICATION,TO_PAY,PAID,RELEASED,REJECTED,RESCHEDULED,INCOMPLETE,EXPIRED,PENDING,INSPECTING,ARCHIVED,NO_SHOW,PROCESS',
        ];
    }

}

