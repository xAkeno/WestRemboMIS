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
            'trans_number' => 'nullable|string|max:50',
            'bcert_number' => 'nullable|string|max:50',
            'issued_date' => 'nullable|date',
            'prefix' => 'nullable|string|max:10',
            'surname' => 'required|string|max:100',
            'first_name' => 'required|string|max:100',
            'middle_name' => 'nullable|string|max:100',
            'ext_name' => 'nullable|string|max:10',
            'business_name' => 'nullable|string|max:200',
            'business_type' => 'nullable|string|max:100',
            'business_details' => 'nullable|string|max:500',
            'capital' => 'nullable|numeric|min:0',
            'house_block_lot_no' => 'nullable|string|max:50',
            'street' => 'nullable|string|max:100',
            'zone' => 'nullable|string|max:50',
            'contact_no' => 'nullable|regex:/^[0-9+\-\s]+$/|max:20',
            'or_no' => 'nullable|string|max:50',
            'remarks' => 'nullable|string|max:500',
            'inspected_by' => 'nullable|string|max:100',
            'date_of_inspection' => 'nullable|date',
            'inspection_remarks' => 'nullable|string|max:500',
            'attachment' => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:5120',
            'punong_barangay' => 'nullable|string|max:100',
            'for_the_punong_barangay' => 'nullable|string|max:100',
            'barangay_position' => 'nullable|string|max:50',
        ];
    }
}

