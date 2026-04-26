<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Verification Code – Barangay West Rembo</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: Georgia, 'Times New Roman', serif;
            background-color: #f0f4f8;
            color: #1a1a2e;
            padding: 40px 16px;
        }

        .wrapper {
            max-width: 560px;
            margin: 0 auto;
            background: #ffffff;
            border-radius: 4px;
            overflow: hidden;
            box-shadow: 0 4px 24px rgba(15, 42, 94, 0.12);
        }

        /* ── Header ── */
        .header {
            background-color: #0f2a5e;
            padding: 32px 40px 28px;
            text-align: center;
        }

        .logo-circle {
            width: 64px;
            height: 64px;
            background-color: #c2467d;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 16px;
        }

        .logo-circle span {
            color: #ffffff;
            font-size: 28px;
            font-weight: bold;
            font-family: Georgia, serif;
        }

        .header-eyebrow {
            font-size: 10px;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 0.2em;
            color: rgba(255, 255, 255, 0.55);
            margin-bottom: 6px;
        }

        .header-title {
            font-size: 22px;
            font-weight: bold;
            color: #ffffff;
            letter-spacing: -0.01em;
            margin-bottom: 10px;
        }

        .header-divider {
            width: 40px;
            height: 2px;
            background-color: #c2467d;
            margin: 0 auto;
        }

        /* ── Body ── */
        .content {
            padding: 40px 40px 32px;
        }

        .greeting {
            font-size: 18px;
            font-weight: bold;
            color: #0f2a5e;
            margin-bottom: 10px;
        }

        .message {
            font-size: 14px;
            color: #4b5563;
            line-height: 1.7;
            margin-bottom: 28px;
        }

        /* ── Code Box ── */
        .code-box {
            background: #f8faff;
            border: 1px solid #dde3ed;
            border-left: 4px solid #c2467d;
            border-radius: 4px;
            padding: 24px;
            text-align: center;
            margin-bottom: 28px;
        }

        .code-label {
            font-size: 10px;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 0.18em;
            color: #c2467d;
            margin-bottom: 10px;
        }

        .code-value {
            font-size: 42px;
            font-weight: bold;
            color: #0f2a5e;
            letter-spacing: 0.18em;
            font-family: 'Courier New', monospace;
        }

        .expiry-note {
            font-size: 12px;
            color: #9ca3af;
            margin-top: 10px;
        }

        /* ── Warning ── */
        .warning-box {
            background: #fff5f9;
            border: 1px solid #f0c4d8;
            border-radius: 4px;
            padding: 14px 18px;
            margin-bottom: 28px;
        }

        .warning-box p {
            font-size: 12px;
            color: #9b3060;
            line-height: 1.6;
        }

        .warning-box strong {
            color: #c2467d;
        }

        /* ── Footer ── */
        .footer {
            background-color: #0f2a5e;
            padding: 20px 40px;
            text-align: center;
            border-top: 3px solid #c2467d;
        }

        .footer p {
            font-size: 10px;
            color: rgba(255, 255, 255, 0.4);
            text-transform: uppercase;
            letter-spacing: 0.14em;
            line-height: 1.8;
        }

        .footer a {
            color: rgba(194, 70, 125, 0.8);
            text-decoration: none;
        }
    </style>
</head>
<body>

    <div class="wrapper">

        {{-- ── Header ── --}}
        <div class="header">
            <div class="logo-circle">
                <span>W</span>
            </div>
            <p class="header-eyebrow">Republic of the Philippines · City of Taguig</p>
            <h1 class="header-title">Barangay West Rembo</h1>
            <div class="header-divider"></div>
        </div>

        {{-- ── Content ── --}}
        <div class="content">
            <p class="greeting">Hello!</p>
            <p class="message">
                You have requested a verification code for your Barangay West Rembo account.
                Please use the code below to complete your verification.
            </p>

            {{-- Code Box --}}
            <div class="code-box">
                <p class="code-label">Your Verification Code</p>
                <div class="code-value">{{ $code }}</div>
                <p class="expiry-note">⏱ This code expires in <strong>10 minutes</strong>.</p>
            </div>

            {{-- Security warning --}}
            <div class="warning-box">
                <p>
                    <strong>Did not request this?</strong> If you did not request a verification code,
                    please ignore this email. Do not share this code with anyone.
                    Barangay staff will never ask for your code.
                </p>
            </div>

            <p class="message" style="font-size: 13px;">
                If you have any concerns, please visit the Barangay West Rembo Hall or
                contact our office directly.
            </p>
        </div>

        {{-- ── Footer ── --}}
        <div class="footer">
            <p>Barangay West Rembo · Taguig City, Metro Manila</p>
            <p>Official Document Request System</p>
            <p style="margin-top: 6px; font-size: 9px; opacity: 0.5;">
                This is an automated message. Please do not reply to this email.
            </p>
        </div>

    </div>

</body>
</html>