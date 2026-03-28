<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateUserRequest extends FormRequest
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
            // Name
            'prefix' => 'nullable|string|max:50',
            'first_name' => 'nullable|string|max:255',
            'middle_name' => 'nullable|string|max:255',
            'surname' => 'nullable|string|max:255',
            'extension_name' => 'nullable|string|max:50',
            'nickname' => 'nullable|string|max:255',

            // Personal info
            'sex' => 'nullable|in:Male,Female',
            'marital_status' => 'nullable|string|max:100',
            'name_of_spouse' => 'nullable|string|max:255',
            'date_of_birth' => 'nullable|date',
            'place_of_birth' => 'nullable|string|max:255',
            'religion' => 'nullable|string|max:100',

            // Contact
            'email' => 'nullable|email',
            'contact_number' => 'nullable|string|max:50',

            // Address
            'house_block_lot_no' => 'nullable|string|max:255',
            'street' => 'nullable|string|max:255',
            'zone_purok' => 'nullable|string|max:255',
            'house_owner' => 'nullable|string|max:255',
            'relationship_to_owner' => 'nullable|string|max:255',

            // Residency
            'resident_status' => 'nullable|string|max:100',
            'period_of_residency' => 'nullable|string|max:100',

            // Voter
            'voter_status' => 'nullable|in:Registered,Not Registered',
            'precinct_no' => 'nullable|string|max:100',

            // Employment
            'employment_status' => 'nullable|string|max:100',
            'occupation' => 'nullable|string|max:100',
            'position' => 'nullable|string|max:100',

            // Health
            'pwd_status' => 'nullable|boolean',
            'height_cm' => 'nullable|integer|min:1|max:300',
            'weight_kg' => 'nullable|integer|min:1|max:500',
            'blood_type' => 'nullable|string|max:5',
            'complexion' => 'nullable|string|max:100',
        ];
    }
}
