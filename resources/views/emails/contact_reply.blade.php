<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Reply</title>
</head>
<body style="margin:0;padding:0;background-color:#f0f2f5;font-family:Arial,Helvetica,sans-serif;color:#0a1628;">

    <table width="100%" cellpadding="0" cellspacing="0" style="background-color:#f0f2f5;padding:40px 16px;">
        <tr>
            <td align="center">

                <!-- Card -->
                <table width="100%" cellpadding="0" cellspacing="0" style="max-width:580px;background-color:#ffffff;border-radius:16px;overflow:hidden;box-shadow:0 4px 24px rgba(10,22,40,0.12);">

                    <!-- Header -->
                    <tr>
                        <td style="background:linear-gradient(135deg,#0a1628 0%,#1e3a8a 100%);padding:36px 40px 28px;text-align:center;">
                            <div style="margin-bottom:16px;">
                                <img src="{{  $message->embed(public_path('images/West_Rembo_Logo.png')) }}" width="80" height="80" style="display:block;margin:0 auto;object-fit:contain;" alt="West Rembo Logo" />
                            </div>
                            <h1 style="margin:0;color:#ffffff;font-size:22px;font-weight:700;letter-spacing:0.3px;">Barangay Document System</h1>
                            <p style="margin:6px 0 0;color:rgba(255,255,255,0.70);font-size:13px;">Official Document Management Portal</p>
                        </td>
                    </tr>

                    <!-- Pink accent bar -->
                    <tr>
                        <td style="background:linear-gradient(90deg,#ec4899,#f472b6);height:4px;font-size:0;">&nbsp;</td>
                    </tr>

                    <!-- Body -->
                    <tr>
                        <td style="padding:36px 40px 28px;">

                            <p style="margin:0 0 4px;font-size:15px;color:#0a1628;">Hello, <strong>{{ $name }}</strong>!</p>
                            <p style="margin:0 0 24px;font-size:13px;color:#6b7280;line-height:1.7;">
                                Thank you for reaching out to us. Please see our official response to your inquiry below.
                            </p>

                            <!-- Topic badge -->
                            <p style="margin:0 0 6px;font-size:10px;font-weight:700;letter-spacing:0.14em;text-transform:uppercase;color:#ec4899;">Your Inquiry</p>
                            <div style="background:linear-gradient(135deg,#fce7f3,#eff6ff);border:1px solid #fbcfe8;border-radius:8px;padding:12px 16px;font-size:14px;font-weight:600;color:#0a1628;margin-bottom:20px;">
                                {{ $topic }}
                            </div>

                            <!-- Reply box -->
                            <table width="100%" cellpadding="0" cellspacing="0" style="margin-bottom:24px;border:1px solid #dde3ed;border-radius:10px;overflow:hidden;">
                                <tr>
                                    <td style="background:#eef2ff;padding:10px 18px;font-size:9px;font-weight:700;letter-spacing:0.16em;text-transform:uppercase;color:#1e3a8a;border-bottom:1px solid #dde3ed;">
                                        Barangay Response
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background:#f8faff;padding:20px 18px;font-size:14px;color:#374151;line-height:1.75;">
                                        {{ $replyMessage }}
                                    </td>
                                </tr>
                            </table>

                            <!-- Note -->
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="background:#fff0f7;border-left:4px solid #ec4899;border-radius:0 8px 8px 0;padding:14px 16px;font-size:12px;color:#1e3a8a;line-height:1.6;">
                                        ⚠️ <strong>Need further help?</strong> Visit the barangay hall during office hours or contact us directly. Please bring a valid ID and reference your inquiry topic.
                                    </td>
                                </tr>
                            </table>

                        </td>
                    </tr>

                    <!-- Footer -->
                    <tr>
                        <td style="background:#eef2ff;border-top:1px solid #dde5f7;padding:20px 40px;text-align:center;">
                            <p style="margin:0 0 4px;font-size:12px;font-weight:600;color:#1e3a8a;">Barangay Management Information System</p>
                            <p style="margin:0 0 8px;font-size:11px;color:#9ca3af;">Official Digital Records System</p>
                            <p style="margin:0;font-size:10px;color:#aaaaaa;line-height:1.6;">
                                This is an automated message. Please do not reply to this email.<br>
                                &copy; {{ date('Y') }} Barangay Document Management System. All rights reserved.
                            </p>
                        </td>
                    </tr>

                    <!-- Bottom strip -->
                    <tr>
                        <td style="background:linear-gradient(90deg,#0a1628 0%,#ec4899 50%,#0a1628 100%);height:4px;font-size:0;">&nbsp;</td>
                    </tr>

                </table>
            </td>
        </tr>
    </table>

</body>
</html>