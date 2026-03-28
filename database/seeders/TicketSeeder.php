<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Ticket;
use Carbon\Carbon;

class TicketSeeder extends Seeder
{
    public function run()
    {
        $types = [
            'Barangay Clearance',
            'Business Clearance',
            'Building Clearance',
            'Barangay Certificate',
            'Resident Registration',
        ];

        foreach ($types as $i => $type) {
            Ticket::create([
                'ticket_number' => strtoupper(substr($type,0,3)) . sprintf('-%06d', $i + 1),
                'service_type' => $type,
                'requester_id' => null,
                'status' => 'Pending',
                'priority' => 'Normal',
                'submitted_at' => Carbon::now()->subMinutes(10 * ($i + 1)),
            ]);
        }
    }
}
