<?php
    namespace App\Http\Requests;

    use Illuminate\Foundation\Http\FormRequest;
    class UpdateBarangayCertificateRequest extends FormRequest{
        
        public function authorize(){
            return true;
        }
        public function rules(){
            return [
                'trans_number' => 'sometimes|required|string|max:50',
                'bcert_number' => 'sometimes|required|string|max:50',
                'issued_date' => 'sometimes|required|date',
                'prefix' => 'sometimes|nullable|string|max:10',
                'firstname' => 'sometimes|required|string|max:100',
                'middle_name' => 'sometimes|nullable|string|max:100',
                'surname' => 'sometimes|required|string|max:100',
                'extension' => 'sometimes|nullable|string|max:10',
                'house_block_lot_no' => 'sometimes|nullable|string|max:50',
                'street' => 'sometimes|nullable|string|max:100',
                'zone' => 'sometimes|nullable|string|max:50',
                'age' => 'sometimes|nullable|integer|min:0|max:150',
                'date_of_birth' => 'sometimes|nullable|date',
                'place_of_birth' => 'sometimes|nullable|string|max:150',
                'contact_no' => ['nullable', 'regex:/^(09|\+639)\d{9}$/', 'max:20'],
                'period_of_residency' => 'sometimes|nullable|string|max:50',
                'registered_voter' => 'sometimes|nullable|string|max:20',
                'house_owner' => 'sometimes|nullable|string|max:100',
                'relationship_to_owner' => 'sometimes|nullable|string|max:50',
                'purpose' => 'sometimes|required|string|max:100',
                'purpose_details' => 'sometimes|nullable|string|max:500',
                'punong_barangay' => 'sometimes|nullable|string|max:100',
                'for_the_punong_barangay' => 'sometimes|nullable|string|max:100',
                'status' => 'sometimes|string|in:ENCODED,SCHEDULED,VERIFICATION,TO_PAY,PAID,RELEASED,REJECTED,RESCHEDULED,INCOMPLETE,EXPIRED,PENDING',   
            ];
        }
    };
?>