<!DOCTYPE html>
<html>
<head>
    <title>Request Warning</title>
</head>
<body>
    <h2>⚠️ Request Reminder</h2>

    <p>Hello,</p>

    <p>Your request is still pending processing:</p>

    <ul>
        <li><strong>Reference:</strong> {{ $record->bcert_number ?? $record->brgy_business_no ?? 'N/A' }}</li>
        <li><strong>Status:</strong> {{ $record->status }}</li>
        <li><strong>Created:</strong> {{ $record->created_at }}</li>
    </ul>

    <p>
    Please visit the barangay office.  
    If no action is taken within 7 days, your request will be automatically deleted.
    </p>

    <br>

    <p>Thank you.</p>
</body>
</html>