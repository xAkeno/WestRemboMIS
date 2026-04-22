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

            // ─── Service ─────────────────────────────────────────────
            'service_type' => 'required|string', // 🔥 remove "in" for now (or fix frontend)

            // ─── Personal ────────────────────────────────────────────
            'first_name' => 'required|string|max:100',
            'surname'    => 'required|string|max:100',

            'prefix'      => 'nullable|string|max:10',
            'middle_name' => 'nullable|string|max:100',
            'ext_name'    => 'nullable|string|max:10',

            // ─── Demographics ────────────────────────────────────────
            'sex' => 'nullable|in:Male,Female,Other',

            'marital_status' => 'nullable|in:Single,Married,Widowed,Separated,Divorced',

            'name_of_spouse' => 'nullable|string|max:255',

            'date_of_birth'  => 'nullable|date',
            'place_of_birth' => 'nullable|string|max:150',

            // ✅ FIX: allow null properly
            'age' => 'nullable|integer|min:0|max:150',

            'blood_type' => 'nullable|in:A+,A-,B+,B-,AB+,AB-,O+,O-',
            'height_cm'  => 'nullable|integer|min:0|max:300',
            'weight_kg'  => 'nullable|integer|min:0|max:500',
            'complexion' => 'nullable|string|max:100',
            'religion'   => 'nullable|string|max:100',

            // ─── Address ─────────────────────────────────────────────
            'house_block_lot_no' => 'nullable|string|max:50',
            'street' => 'required|string|max:100',
            'zone'   => 'required|string|max:50',

            // ─── Residency ───────────────────────────────────────────
            'period_of_residency'   => 'nullable|string|max:50',
            'registered_voter'      => 'nullable|in:Yes,No',
            'house_owner'           => 'nullable|string|max:100',
            'relationship_to_owner' => 'nullable|string|max:50',

            // ─── Contact ─────────────────────────────────────────────
            'contact_number' => 'required|string|max:20',
            'email_address'  => 'nullable|email|max:255',

            // ─── Purpose ─────────────────────────────────────────────
            'purpose'         => 'required|string|max:100',
            'purpose_details' => 'nullable|string',

            // ─── Queue ───────────────────────────────────────────────
            'priority' => 'nullable|in:Normal,Priority,Senior,PWD',

            // ─── Service-Specific (NOW OPTIONAL SAFE) ─────────────────

            'business_name' => 'nullable|string|max:255',
            'business_type' => 'nullable|string|max:100',
            'capital'       => 'nullable|numeric|min:0',

            'establishment' => 'nullable|string|max:255',

            'bcert_number' => 'nullable|string|max:50',
            'brgy_business_no' => 'nullable|string|max:50',
        ];
    }

    public function messages(): array
    {
        return [
            'service_type.required' => 'Please select a document type.',
            'first_name.required'   => 'First name is required.',
            'surname.required'      => 'Last name is required.',
            'street.required'       => 'Street is required.',
            'zone.required'         => 'Zone is required.',
            'contact_number.required'=> 'Contact number is required.',
            'purpose.required'      => 'Purpose of request is required.',
            'name_of_spouse.required_if' => 'Spouse name is required if married.',
            'business_name.required_if' => 'Business name is required.',
            'business_type.required_if' => 'Business type is required.',
            'capital.required_if' => 'Capital is required.',
            'establishment.required_if' => 'Establishment is required.',
            'age.required_if' => 'Age is required for certificate.',
        ];
    }
}