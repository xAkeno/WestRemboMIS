<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreBarangayBusinessClearanceRequest extends FormRequest
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
            'brgy_business_no' => 'nullable|string|max:50',
            'requester_type' => 'required|string|max:50',
            'issued_date' => 'nullable|date',
            'prefix' => 'nullable|string|max:10',
            'surname' => 'nullable|string|max:100',
            'first_name' => 'nullable|string|max:100',
            'middle_name' => 'nullable|string|max:100',
            'ext_name' => 'nullable|string|max:10',
            'business_name' => 'nullable|string|max:200',
            'business_type' => 'nullable|string|max:100',
            'business_details' => 'nullable|string|max:500',
            'capital' => 'nullable|numeric|min:0',
            'house_block_lot_no' => 'nullable|string|max:50',
            'street' => 'nullable|string|max:100',
            'zone' => 'nullable|string|max:50',
            'or_no' => 'nullable|string|max:50',
            'inspected_by' => 'nullable|string|max:100',
            'email' => 'nullable|email|max:255',
            'date_of_inspection' => 'nullable|date',
            'inspection_remarks' => 'nullable|string|max:500',
            'inspected_remarks' => 'nullable|string|max:500',
            'date_inspected' => 'nullable|date',
            'inspected_note' => 'nullable|string|max:500',
            'rejection_reason' => 'nullable|string|max:1000',
            'status' => 'sometimes|string|in:ENCODED,SCHEDULED,VERIFICATION,TO_PAY,PAID,RELEASED,REJECTED,RESCHEDULED,INCOMPLETE,EXPIRED,PENDING,INSPECTING,ARCHIVED,NO_SHOW,PROCESS,REVIEW',  
        ];
    }
}

