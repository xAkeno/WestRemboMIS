<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <title>Account Status — Barangay MIS</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Crimson+Pro:ital,wght@0,400;0,600;1,400&family=DM+Sans:wght@400;500;600&display=swap');

    * { margin: 0; padding: 0; box-sizing: border-box; }

    body {
      background-color: #eef1f6;
      font-family: 'DM Sans', sans-serif;
      -webkit-font-smoothing: antialiased;
      padding: 40px 16px;
    }

    .wrapper {
      max-width: 560px;
      margin: 0 auto;
    }

    /* ── Top tab ── */
    .top-tab {
      text-align: center;
      margin-bottom: 0;
    }
    .top-tab-inner {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 9px 22px;
      border-radius: 30px 30px 0 0;
      font-size: 10px;
      font-weight: 600;
      letter-spacing: 0.15em;
      text-transform: uppercase;
      color: #fff;
      background: #0f2a5e;
    }
    .top-tab-dot {
      width: 5px;
      height: 5px;
      border-radius: 50%;
      background: #c2467d;
      flex-shrink: 0;
    }

    /* ── Card ── */
    .card {
      background: #fff;
      border-radius: 0 0 16px 16px;
      overflow: hidden;
      box-shadow: 0 12px 48px rgba(15,42,94,0.13), 0 2px 8px rgba(15,42,94,0.06);
    }

    /* ── Hero ── */
    .hero {
      position: relative;
      padding: 44px 40px 52px;
      overflow: hidden;
    }
    .hero-approved {
      background: linear-gradient(135deg, #0f2a5e 0%, #1a3d7c 70%, #0f2a5e 100%);
    }
    .hero-rejected {
      background: linear-gradient(135deg, #1c1c2e 0%, #2d1b3d 70%, #1c1c2e 100%);
    }
    .hero::before {
      content: '';
      position: absolute;
      top: -40px; right: -40px;
      width: 220px; height: 220px;
      border-radius: 50%;
      opacity: 0.1;
    }
    .hero-approved::before { background: #c2467d; }
    .hero-rejected::before { background: #e11d48; }

    .hero::after {
      content: '';
      position: absolute;
      bottom: -60px; left: -30px;
      width: 180px; height: 180px;
      border-radius: 50%;
      background: rgba(255,255,255,0.04);
    }

    .hero-icon {
      position: relative;
      z-index: 1;
      width: 56px;
      height: 56px;
      border-radius: 14px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 18px;
      font-size: 26px;
    }
    .hero-icon-approved { background: rgba(22,163,74,0.2); border: 1px solid rgba(22,163,74,0.35); }
    .hero-icon-rejected { background: rgba(225,29,72,0.2); border: 1px solid rgba(225,29,72,0.35); }

    .hero-eyebrow {
      position: relative;
      z-index: 1;
      font-size: 10px;
      font-weight: 600;
      letter-spacing: 0.18em;
      text-transform: uppercase;
      margin-bottom: 10px;
      display: flex;
      align-items: center;
      gap: 8px;
    }
    .hero-eyebrow-approved { color: #86efac; }
    .hero-eyebrow-rejected { color: #fca5a5; }
    .hero-eyebrow::before {
      content: '';
      display: inline-block;
      width: 20px;
      height: 1.5px;
    }
    .hero-eyebrow-approved::before { background: #86efac; }
    .hero-eyebrow-rejected::before { background: #fca5a5; }

    .hero-title {
      position: relative;
      z-index: 1;
      font-family: 'Crimson Pro', Georgia, serif;
      font-size: 32px;
      font-weight: 600;
      color: #fff;
      line-height: 1.15;
      margin-bottom: 6px;
    }
    .hero-sub {
      position: relative;
      z-index: 1;
      font-size: 12px;
      color: rgba(255,255,255,0.45);
    }

    /* ── Status strip (overlapping) ── */
    .status-strip-wrap {
      padding: 0 36px;
      margin-top: -22px;
      position: relative;
      z-index: 2;
    }
    .status-strip {
      display: inline-flex;
      align-items: center;
      gap: 10px;
      padding: 11px 20px;
      border-radius: 99px;
      font-size: 13px;
      font-weight: 600;
      box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    }
    .status-strip-approved {
      background: #f0fdf4;
      color: #15803d;
      border: 1.5px solid #86efac;
    }
    .status-strip-rejected {
      background: #fff1f2;
      color: #9f1239;
      border: 1.5px solid #fecdd3;
    }
    .status-dot {
      width: 8px;
      height: 8px;
      border-radius: 50%;
      flex-shrink: 0;
    }
    .status-dot-approved { background: #16a34a; }
    .status-dot-rejected { background: #e11d48; }

    /* ── Body ── */
    .body {
      padding: 32px 36px 36px;
    }

    .greeting {
      font-family: 'Crimson Pro', Georgia, serif;
      font-size: 22px;
      font-weight: 600;
      color: #0f2a5e;
      margin-bottom: 14px;
    }

    .message {
      font-size: 14px;
      line-height: 1.75;
      color: #4b5563;
      margin-bottom: 24px;
    }
    .message strong { color: #0f2a5e; font-weight: 600; }

    /* ── Info box ── */
    .info-box {
      border-radius: 10px;
      overflow: hidden;
      margin-bottom: 28px;
    }
    .info-box-approved {
      background: #f0fdf4;
      border: 1px solid #bbf7d0;
      border-left: 3px solid #16a34a;
    }
    .info-box-rejected {
      background: #fff1f2;
      border: 1px solid #fecdd3;
      border-left: 3px solid #e11d48;
    }
    .info-box-header {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 10px 16px;
      font-size: 9px;
      font-weight: 700;
      letter-spacing: 0.15em;
      text-transform: uppercase;
    }
    .info-box-header-approved {
      background: #dcfce7;
      color: #15803d;
      border-bottom: 1px solid #bbf7d0;
    }
    .info-box-header-rejected {
      background: #ffe4e6;
      color: #9f1239;
      border-bottom: 1px solid #fecdd3;
    }
    .info-box-body {
      padding: 14px 16px;
      font-size: 13px;
      line-height: 1.65;
    }
    .info-box-body-approved { color: #15803d; }
    .info-box-body-rejected { color: #9f1239; }

    /* ── Next steps ── */
    .steps {
      margin-bottom: 28px;
    }
    .steps-title {
      font-size: 10px;
      font-weight: 700;
      letter-spacing: 0.12em;
      text-transform: uppercase;
      color: #c2467d;
      margin-bottom: 12px;
      display: flex;
      align-items: center;
      gap: 6px;
    }
    .steps-title::after {
      content: '';
      flex: 1;
      height: 1px;
      background: #e5e7eb;
    }
    .step-item {
      display: flex;
      align-items: flex-start;
      gap: 12px;
      margin-bottom: 10px;
    }
    .step-num {
      width: 22px;
      height: 22px;
      border-radius: 50%;
      font-size: 10px;
      font-weight: 700;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
      margin-top: 1px;
    }
    .step-num-approved { background: #dcfce7; color: #15803d; }
    .step-num-rejected { background: #fee2e2; color: #b91c1c; }
    .step-text {
      font-size: 13px;
      color: #6b7280;
      line-height: 1.5;
    }
    .step-text strong { color: #374151; font-weight: 600; }

    /* ── CTA ── */
    .cta-wrap { text-align: center; margin-bottom: 28px; }
    .cta-btn {
      display: inline-block;
      padding: 14px 40px;
      font-size: 12px;
      font-weight: 600;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      text-decoration: none;
      border-radius: 4px;
      color: #fff !important;
    }
    .cta-btn-approved { background: #0f2a5e; box-shadow: 0 4px 14px rgba(15,42,94,0.28); }
    .cta-btn-rejected { background: #374151; box-shadow: 0 4px 14px rgba(55,65,81,0.25); }

    /* ── Divider ── */
    .divider {
      height: 1px;
      background: linear-gradient(90deg, transparent, #e5e7eb, transparent);
      margin: 0 0 24px;
    }

    /* ── Footer ── */
    .footer {
      padding: 0 36px 32px;
      text-align: center;
    }
    .footer-logo {
      font-family: 'Crimson Pro', Georgia, serif;
      font-size: 20px;
      font-weight: 600;
      color: #0f2a5e;
      margin-bottom: 4px;
    }
    .footer-tagline {
      font-size: 11px;
      color: #9ca3af;
      margin-bottom: 16px;
    }
    .footer-note {
      font-size: 10px;
      color: #d1d5db;
      line-height: 1.7;
    }
    .footer-accent { color: #c2467d; font-weight: 600; }

    /* ── Bottom bar ── */
    .bottom-bar {
      height: 4px;
      background: linear-gradient(90deg, #0f2a5e 0%, #c2467d 50%, #0f2a5e 100%);
    }
  </style>
</head>
<body>
  <div class="wrapper">

    <!-- Top tab -->
    <div class="top-tab">
      <div class="top-tab-inner">
        <span class="top-tab-dot"></span>
        Barangay Management Information System
        <span class="top-tab-dot"></span>
      </div>
    </div>

    <div class="card">

      <!-- Hero -->
      @if($status === 'approved')
      <div class="hero hero-approved">
          <div class="hero-icon hero-icon-approved" style="overflow:hidden;padding:4px;">
            <img src="{{ $message->embed(public_path('images/West_Rembo_Logo.png')) }}" width="48" height="48" style="display:block;object-fit:contain;border-radius:8px;" alt="West Rembo Logo" />
          </div>
        <div class="hero-eyebrow hero-eyebrow-approved">Account Notification</div>
        <div class="hero-title">Your Account<br>Has Been Approved</div>
        <div class="hero-sub">{{ now()->format('F j, Y \a\t g:i A') }}</div>
      </div>
      @else
      <div class="hero hero-rejected">
        <div class="hero-icon hero-icon-rejected" style="overflow:hidden;padding:4px;">
          <img src="{{ $message->embed(public_path('images/West_Rembo_Logo.png')) }}" width="48" height="48" style="display:block;object-fit:contain;border-radius:8px;" alt="West Rembo Logo" />
        </div>
        <div class="hero-eyebrow hero-eyebrow-rejected">Account Notification</div>
        <div class="hero-title">Account<br>Not Approved</div>
        <div class="hero-sub">{{ now()->format('F j, Y \a\t g:i A') }}</div>
      </div>
      @endif

      <!-- Status pill -->
      <div class="status-strip-wrap">
        @if($status === 'approved')
        <div class="status-strip status-strip-approved">
          <span class="status-dot status-dot-approved"></span>
          <span style="font-size:10px;font-weight:700;letter-spacing:.06em;text-transform:uppercase;color:#9ca3af;margin-right:2px;">Status —</span>
          Account Active
        </div>
        @else
        <div class="status-strip status-strip-rejected">
          <span class="status-dot status-dot-rejected"></span>
          <span style="font-size:10px;font-weight:700;letter-spacing:.06em;text-transform:uppercase;color:#9ca3af;margin-right:2px;">Status —</span>
          Not Approved
        </div>
        @endif
      </div>

      <!-- Body -->
      <div class="body">

        <div class="greeting">Hello, {{ $user->first_name }}.</div>

        @if($status === 'approved')
        <p class="message">
          Congratulations! Your account registration with the
          <strong>Barangay Management Information System</strong> has been reviewed
          and officially approved by our administration. You now have full access
          to request documents and track your applications online.
        </p>

        <!-- Info box -->
        <div class="info-box info-box-approved">
          <div class="info-box-header info-box-header-approved">
            ✓ &nbsp;What this means for you
          </div>
          <div class="info-box-body info-box-body-approved">
            Your account is now <strong>active and verified</strong>. You may log in
            at any time using the credentials you registered with.
          </div>
        </div>

        <!-- Next steps -->
        <div class="steps">
          <div class="steps-title">Next Steps</div>
          <div class="step-item">
            <div class="step-num step-num-approved">1</div>
            <div class="step-text"><strong>Log in</strong> to your account using your registered email and password.</div>
          </div>
          <div class="step-item">
            <div class="step-num step-num-approved">2</div>
            <div class="step-text"><strong>Request documents</strong> such as barangay clearance, certificates, and more.</div>
          </div>
          <div class="step-item">
            <div class="step-num step-num-approved">3</div>
            <div class="step-text"><strong>Track your requests</strong> in real time from your personal dashboard.</div>
          </div>
        </div>

        <div class="cta-wrap">
          <a href="#" class="cta-btn cta-btn-approved">Log In to Your Account</a>
        </div>

        @else
        <p class="message">
          Thank you for registering with the <strong>Barangay Management Information System</strong>.
          After careful review, we regret to inform you that your account application
          has not been approved at this time.
        </p>

        <!-- Info box -->
        <div class="info-box info-box-rejected">
          <div class="info-box-header info-box-header-rejected">
            ✕ &nbsp;Reason for rejection
          </div>
          <div class="info-box-body info-box-body-rejected">
            This may be due to <strong>incomplete information</strong>, an unverifiable
            government ID, or other verification requirements that were not met.
            Please contact our office for clarification.
          </div>
        </div>

        <!-- Next steps -->
        <div class="steps">
          <div class="steps-title">What You Can Do</div>
          <div class="step-item">
            <div class="step-num step-num-rejected">1</div>
            <div class="step-text"><strong>Visit the barangay hall</strong> and speak with our staff to understand the reason for rejection.</div>
          </div>
          <div class="step-item">
            <div class="step-num step-num-rejected">2</div>
            <div class="step-text"><strong>Prepare valid documents</strong> — a clear photo of a government-issued ID is required.</div>
          </div>
          <div class="step-item">
            <div class="step-num step-num-rejected">3</div>
            <div class="step-text"><strong>Re-register</strong> with complete and accurate information once you have your documents ready.</div>
          </div>
        </div>

        <div class="cta-wrap">
          <a href="#" class="cta-btn cta-btn-rejected">Contact Barangay Office</a>
        </div>
        @endif

      </div><!-- /body -->

      <div class="divider"></div>

      <!-- Footer -->
      <div class="footer">
        <div class="footer-logo">Barangay MIS</div>
        <div class="footer-tagline">Official Digital Records System</div>
        <div class="footer-note">
          This is an automated message from the
          <span class="footer-accent">Barangay Management Information System</span>.<br>
          Please do not reply directly to this email.<br>
          For assistance, visit the barangay hall during office hours.
        </div>
      </div>

      <div class="bottom-bar"></div>

    </div><!-- /card -->
  </div><!-- /wrapper -->
</body>
</html>