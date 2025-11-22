<?php

namespace App\Traits;

use Illuminate\Support\Facades\DB;

trait TicketNumberTrait
{
    protected static $prefixes = [
        'Barangay Clearance' => 'BGC',
        'Business Clearance' => 'BUS',
        'Building Clearance' => 'BLD',
        'Barangay Certificate' => 'CERT',
        'Resident Registration' => 'RES',
    ];

    /**
     * Generate next ticket number for given service type
     * Format: PREFIX-{6-digit}
     */
    protected function generateTicketNumber(string $serviceType): string
    {
        $prefix = self::$prefixes[$serviceType] ?? strtoupper(substr($serviceType, 0, 3));

        // Get last ticket number for this service type
        $last = DB::table('tickets')
            ->where('service_type', $serviceType)
            ->whereNotNull('ticket_number')
            ->orderBy('id', 'desc')
            ->value('ticket_number');

        $next = 1;
        if ($last) {
            $parts = explode('-', $last);
            $num = end($parts);
            if (is_numeric($num)) {
                $next = intval($num) + 1;
            }
        }

        return sprintf('%s-%06d', $prefix, $next);
    }
}
