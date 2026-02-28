<?php
    namespace App\Http\Requests;

    use Illuminate\Foundation\Http\FormRequest;
    class StoreBarangayCertificateRequest extends FormRequest{
        
        public function authorize(){
            return true;
        }
        public function rules(): array
        {
            return [
                'requester_type' => 'required|string|max:50',
                'prefix' => 'nullable|string|max:10',
                'firstname' => 'required|string|max:100',
                'middle_name' => 'nullable|string|max:100',
                'surname' => 'required|string|max:100',
                'extension' => 'nullable|string|max:10',
                'house_block_lot_no' => 'nullable|string|max:50',
                'street' => 'nullable|string|max:100',
                'zone' => 'nullable|string|max:50',
                'age' => 'nullable|integer|min:0|max:150',
                'date_of_birth' => 'nullable|date',
                'place_of_birth' => 'nullable|string|max:150',
                'contact_no' => ['nullable', 'regex:/^(09|\+639)\d{9}$/', 'max:20'],
                'period_of_residency' => 'nullable|string|max:50',
                'registered_voter' => 'nullable|string|max:20',
                'house_owner' => 'nullable|string|max:100',
                'relationship_to_owner' => 'nullable|string|max:50',
                'purpose' => 'required|string|max:100',
                'purpose_details' => 'nullable|string|max:500',
                'punong_barangay' => 'nullable|string|max:100',
                'for_the_punong_barangay' => 'nullable|string|max:100',
            ];
        }

    }
?>