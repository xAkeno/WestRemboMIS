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
            'issuedDate' => 'nullable|date',
            'prefix' => 'nullable|string|max:10',
            'surname' => 'sometimes|required|string|max:100',
            'firstname' => 'sometimes|required|string|max:100',
            'middlename' => 'nullable|string|max:100',
            'extension' => 'nullable|string|max:10',
            'establishment' => 'nullable|string|max:200',
            'houseBlockLot' => 'nullable|string|max:50',
            'street' => 'nullable|string|max:100',
            'zone' => 'nullable|string|max:50',
            'purpose' => 'nullable|string|max:100',
            'purposeDetails' => 'nullable|string|max:500',
            'orNo' => 'nullable|string|max:50',
            'remarks' => 'nullable|string|max:500',
            'punongBarangay' => 'nullable|string|max:100',
            'forThePunongBarangay' => 'nullable|string|max:100',
            'barangayPosition' => 'nullable|string|max:50',
            'status' => 'sometimes|string|in:ENCODED,SCHEDULED,VERIFICATION,TO_PAY,PAID,RELEASED,REJECTED,RESCHEDULED',  
        ];
    }

}

