<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <title>Request Status Updated</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Crimson+Pro:wght@400;600&family=DM+Sans:wght@400;500;600&display=swap');

    * { margin: 0; padding: 0; box-sizing: border-box; }

    body {
      background-color: #f0f2f5;
      font-family: 'DM Sans', sans-serif;
      -webkit-font-smoothing: antialiased;
      padding: 40px 16px;
    }

    .wrapper {
      max-width: 560px;
      margin: 0 auto;
    }

    /* ── Top seal ── */
    .seal {
      text-align: center;
      margin-bottom: 0;
    }
    .seal-inner {
      display: inline-flex;
      align-items: center;
      gap: 10px;
      background: #0f2a5e;
      color: #fff;
      padding: 10px 24px;
      border-radius: 40px 40px 0 0;
      font-size: 11px;
      font-weight: 600;
      letter-spacing: 0.14em;
      text-transform: uppercase;
    }
    .seal-dot {
      width: 6px;
      height: 6px;
      background: #c2467d;
      border-radius: 50%;
      display: inline-block;
    }

    /* ── Card ── */
    .card {
      background: #ffffff;
      border-radius: 0 0 16px 16px;
      overflow: hidden;
      box-shadow: 0 8px 40px rgba(15, 42, 94, 0.13), 0 2px 8px rgba(15,42,94,0.06);
    }

    /* ── Hero band ── */
    .hero {
      background: linear-gradient(135deg, #0f2a5e 0%, #1a3d7c 60%, #0f2a5e 100%);
      padding: 40px 40px 48px;
      position: relative;
      overflow: hidden;
    }
    .hero::before {
      content: '';
      position: absolute;
      top: -30px; right: -30px;
      width: 200px; height: 200px;
      border-radius: 50%;
      background: rgba(194, 70, 125, 0.12);
    }
    .hero::after {
      content: '';
      position: absolute;
      bottom: -50px; left: -20px;
      width: 160px; height: 160px;
      border-radius: 50%;
      background: rgba(255,255,255,0.04);
    }
    .hero-label {
      font-size: 10px;
      font-weight: 600;
      letter-spacing: 0.18em;
      text-transform: uppercase;
      color: #c2467d;
      margin-bottom: 10px;
      display: flex;
      align-items: center;
      gap: 8px;
    }
    .hero-label::before {
      content: '';
      display: inline-block;
      width: 20px;
      height: 1.5px;
      background: #c2467d;
    }
    .hero-title {
      font-family: 'Crimson Pro', Georgia, serif;
      font-size: 30px;
      font-weight: 600;
      color: #ffffff;
      line-height: 1.2;
      margin-bottom: 6px;
    }
    .hero-sub {
      font-size: 13px;
      color: rgba(255,255,255,0.55);
      font-weight: 400;
    }

    /* ── Status pill (overlapping hero/body) ── */
    .status-wrap {
      padding: 0 40px;
      margin-top: -20px;
      position: relative;
      z-index: 2;
    }

    @php
      $statusColors = [
        'RELEASED'   => ['bg' => '#dcfce7', 'text' => '#15803d', 'border' => '#86efac', 'dot' => '#16a34a'],
        'PENDING'    => ['bg' => '#fef9c3', 'text' => '#92400e', 'border' => '#fde68a', 'dot' => '#ca8a04'],
        'INCOMPLETE' => ['bg' => '#fff7ed', 'text' => '#c2410c', 'border' => '#fed7aa', 'dot' => '#ea580c'],
        'REJECTED'   => ['bg' => '#fff1f2', 'text' => '#9f1239', 'border' => '#fecdd3', 'dot' => '#e11d48'],
        'ENCODED'    => ['bg' => '#f0fdf4', 'text' => '#166534', 'border' => '#bbf7d0', 'dot' => '#16a34a'],
        'TO_PAY'     => ['bg' => '#fefce8', 'text' => '#854d0e', 'border' => '#fef08a', 'dot' => '#ca8a04'],
      ];
      $sc = $statusColors[strtoupper($model->status)] ?? ['bg' => '#f3f4f6', 'text' => '#374151', 'border' => '#d1d5db', 'dot' => '#6b7280'];
    @endphp

    .status-pill {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      background: {{ $sc['bg'] }};
      color: {{ $sc['text'] }};
      border: 1.5px solid {{ $sc['border'] }};
      border-radius: 99px;
      padding: 10px 20px;
      font-size: 13px;
      font-weight: 600;
      letter-spacing: 0.03em;
      box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    }
    .status-dot {
      width: 8px;
      height: 8px;
      border-radius: 50%;
      background: {{ $sc['dot'] }};
      flex-shrink: 0;
    }
    .status-label-pre {
      font-size: 10px;
      font-weight: 600;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      color: #9ca3af;
      margin-right: 2px;
    }

    /* ── Body content ── */
    .body {
      padding: 28px 40px 36px;
    }

    .greeting {
      font-size: 15px;
      color: #374151;
      line-height: 1.65;
      margin-bottom: 24px;
    }
    .greeting strong {
      color: #0f2a5e;
      font-weight: 600;
    }

    /* ── Info card ── */
    .info-card {
      background: #f8faff;
      border: 1px solid #dde3ed;
      border-radius: 10px;
      overflow: hidden;
      margin-bottom: 24px;
    }
    .info-card-header {
      background: #eef2ff;
      padding: 10px 18px;
      font-size: 9px;
      font-weight: 700;
      letter-spacing: 0.16em;
      text-transform: uppercase;
      color: #6366f1;
      display: flex;
      align-items: center;
      gap: 6px;
    }
    .info-card-header::before {
      content: '';
      width: 3px;
      height: 12px;
      background: #6366f1;
      border-radius: 2px;
      display: inline-block;
    }
    .info-row {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 14px 18px;
      border-bottom: 1px solid #e5e9f4;
    }
    .info-row:last-child {
      border-bottom: none;
    }
    .info-key {
      font-size: 11px;
      font-weight: 600;
      letter-spacing: 0.06em;
      text-transform: uppercase;
      color: #9ca3af;
    }
    .info-val {
      font-size: 13px;
      font-weight: 600;
      color: #0f2a5e;
      font-family: 'Crimson Pro', Georgia, serif;
      font-size: 15px;
    }
    .info-val.mono {
      font-family: 'Courier New', monospace;
      font-size: 12px;
      background: #eef2ff;
      color: #3730a3;
      padding: 3px 10px;
      border-radius: 4px;
      letter-spacing: 0.08em;
    }

    /* ── Note ── */
    .note {
      background: #fffbeb;
      border: 1px solid #fde68a;
      border-left: 3px solid #f59e0b;
      border-radius: 6px;
      padding: 12px 16px;
      font-size: 12px;
      color: #92400e;
      line-height: 1.6;
      margin-bottom: 28px;
    }
    .note strong {
      font-weight: 600;
    }

    /* ── CTA Button ── */
    .cta-wrap {
      text-align: center;
      margin-bottom: 28px;
    }
    .cta-btn {
      display: inline-block;
      background: #0f2a5e;
      color: #ffffff !important;
      text-decoration: none;
      font-size: 12px;
      font-weight: 600;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      padding: 14px 36px;
      border-radius: 4px;
      box-shadow: 0 4px 14px rgba(15,42,94,0.3);
    }

    /* ── Divider ── */
    .divider {
      height: 1px;
      background: linear-gradient(90deg, transparent, #dde3ed, transparent);
      margin: 0 0 24px;
    }

    /* ── Footer ── */
    .footer {
      padding: 0 40px 32px;
      text-align: center;
    }
    .footer-brand {
      font-family: 'Crimson Pro', Georgia, serif;
      font-size: 18px;
      font-weight: 600;
      color: #0f2a5e;
      margin-bottom: 4px;
    }
    .footer-sub {
      font-size: 11px;
      color: #9ca3af;
      margin-bottom: 16px;
    }
    .footer-note {
      font-size: 10px;
      color: #c4c9d4;
      line-height: 1.6;
    }
    .footer-accent {
      color: #c2467d;
      font-weight: 600;
    }

    /* ── Bottom strip ── */
    .bottom-strip {
      height: 4px;
      background: linear-gradient(90deg, #0f2a5e 0%, #c2467d 50%, #0f2a5e 100%);
    }
  </style>
</head>
<body>
  <div class="wrapper">

    <!-- Seal tab -->
    <div class="seal">
      <div class="seal-inner">
        <span class="seal-dot"></span>
        Barangay Management Information System
        <span class="seal-dot"></span>
      </div>
    </div>

    <!-- Card -->
    <div class="card">

      <!-- Hero -->
      <div class="hero">
        <div class="hero-label">Official Notification</div>
        <div class="hero-title">Your Request<br>Has Been Updated</div>
        <div class="hero-sub">{{ now()->format('F j, Y \a\t g:i A') }}</div>
      </div>

      <!-- Status pill -->
      <div class="status-wrap">
        <div class="status-pill">
          <span class="status-dot"></span>
          <span class="status-label-pre">Status —</span>
          {{ $model->status }}
        </div>
      </div>

      <!-- Body -->
      <div class="body">

        <p class="greeting">
          Good day! Your <strong>{{ class_basename($model) }}</strong> request submitted to the barangay office
          has been reviewed and its status has been officially updated. Please see the details below.
        </p>

        <!-- Info card -->
        <div class="info-card">
          <div class="info-card-header">Request Details</div>

          <div class="info-row">
            <span class="info-key">Document Type</span>
            <span class="info-val">{{ class_basename($model) }}</span>
          </div>

          <div class="info-row">
            <span class="info-key">Reference No.</span>
            <span class="info-val mono">{{ $model->getDocumentNumber() }}</span>
          </div>

          <div class="info-row">
            <span class="info-key">Current Status</span>
            <span class="info-val" style="color: {{ $sc['text'] }};">{{ $model->status }}</span>
          </div>

          <div class="info-row">
            <span class="info-key">Last Updated</span>
            <span class="info-val" style="font-family: 'DM Sans', sans-serif; font-size: 13px;">
              {{ $model->updated_at?->format('F j, Y') ?? now()->format('F j, Y') }}
            </span>
          </div>
        </div>

        <!-- Note -->
        <div class="note">
          <strong>Note:</strong> If you have questions or concerns regarding this update,
          please visit the barangay hall during office hours or contact our office directly.
          Bring a valid ID and your reference number when visiting.
        </div>

        <!-- CTA -->
        <div class="cta-wrap">
          <a href="#" class="cta-btn">View Your Request</a>
        </div>

      </div><!-- /body -->

      <div class="divider"></div>

      <!-- Footer -->
      <div class="footer">
        <div class="footer-brand">Barangay MIS</div>
        <div class="footer-sub">Official Digital Records System</div>
        <div class="footer-note">
          This is an automated notification from the
          <span class="footer-accent">Barangay Management Information System</span>.<br>
          Please do not reply to this email. For assistance, contact your barangay office.
        </div>
      </div>

      <!-- Bottom accent strip -->
      <div class="bottom-strip"></div>

    </div><!-- /card -->

  </div><!-- /wrapper -->
</body>
</html>