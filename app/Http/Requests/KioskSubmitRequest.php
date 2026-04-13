<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class KioskSubmitRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
                'service_type' => 'required|string|in:Barangay Clearance,Business Clearance,Building Clearance,Barangay Certificate,Resident Registration',
                'first_name' => 'required|string|max:255',
                'surname' => 'required|string|max:255',
                'middle_name' => 'required|string|max:255',
                'authorized_person' => 'nullable|string|max:255',
                'address' => 'required|string|max:1000',
                'date_of_birth' => 'required|string', // dd/mm/yyyy expected; validate in controller
                'place_of_birth' => 'required|string|max:255',
                'period_of_residency' => 'required|string|max:255',
                'registered_voter' => 'required|string|in:Yes,No',
                'house_owner' => 'required|string|max:255',
                'relation_to_house_owner' => 'required|string|max:255',
                'contact_number' => 'required|string|max:50',
                'purpose' => 'required|string|max:1000',
                'priority' => 'nullable|string|in:Low,Normal,High',
        ];
    }
}
