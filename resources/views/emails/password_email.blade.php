<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document Password</title>
</head>
<body style="margin:0;padding:0;background-color:#f0f4ff;font-family:Arial,Helvetica,sans-serif;color:#0a1628;">

    <table width="100%" cellpadding="0" cellspacing="0" style="background-color:#f0f4ff;padding:40px 16px;">
        <tr>
            <td align="center">

                <!-- Card -->
                <table width="100%" cellpadding="0" cellspacing="0" style="max-width:580px;background-color:#ffffff;border-radius:16px;overflow:hidden;box-shadow:0 4px 24px rgba(10,22,40,0.12);">

                    <!-- Header -->
                    <tr>
                        <td style="background:linear-gradient(135deg,#0a1628 0%,#1e3a8a 100%);padding:36px 40px 28px;text-align:center;">
                            <div style="display:inline-block;background:rgba(255,255,255,0.15);border-radius:50%;width:64px;height:64px;line-height:64px;font-size:28px;margin-bottom:16px;">🏛️</div>
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

                            <p style="margin:0 0 8px;font-size:15px;color:#0a1628;">Hello, <strong>{{ $name }}</strong>!</p>

                            <p style="margin:0 0 20px;font-size:14px;color:#555555;line-height:1.7;">
                                Your barangay document has been processed and will be sent to you in a separate email shortly. This email contains your <strong>one-time document access password</strong>.
                            </p>

                            <!-- Password card -->
                            <table width="100%" cellpadding="0" cellspacing="0" style="background:linear-gradient(135deg,#fce7f3,#eff6ff);border:1px solid #fbcfe8;border-radius:12px;margin:8px 0 24px;">
                                <tr>
                                    <td style="padding:28px 24px;text-align:center;">
                                        <p style="margin:0 0 6px;font-size:11px;font-weight:700;letter-spacing:2px;text-transform:uppercase;color:#1e3a8a;">Your Document Password</p>
                                        <p style="margin:0 0 16px;font-size:11px;color:#999;">Use this to open the PDF attached in the next email</p>

                                        <div style="background:#ffffff;border:2px dashed #ec4899;border-radius:8px;padding:18px 24px;display:inline-block;">
                                            <span style="font-family:'Courier New',Courier,monospace;font-size:30px;font-weight:700;letter-spacing:8px;color:#0a1628;">{{ $password }}</span>
                                        </div>

                                        <p style="margin:14px 0 0;font-size:12px;color:#888;">Copy this password before opening the PDF attachment.</p>
                                    </td>
                                </tr>
                            </table>

                            <!-- Warning note -->
                            <table width="100%" cellpadding="0" cellspacing="0" style="background:#fff0f7;border-left:4px solid #ec4899;border-radius:0 8px 8px 0;margin-bottom:24px;">
                                <tr>
                                    <td style="padding:14px 16px;font-size:13px;color:#1e3a8a;line-height:1.6;">
                                        ⚠️ <strong>Security Notice:</strong> Keep this password private. Do not forward this email or share the password with anyone you do not trust. This document is intended for <strong>{{ $name }}</strong> only.
                                    </td>
                                </tr>
                            </table>

                            <p style="margin:0;font-size:13px;color:#888;line-height:1.6;">
                                If you did not request this document, please contact your barangay office immediately and disregard both emails.
                            </p>

                        </td>
                    </tr>

                    <!-- Footer -->
                    <tr>
                        <td style="background:#eef2ff;border-top:1px solid #dde5f7;padding:20px 40px;text-align:center;">
                            <p style="margin:0 0 4px;font-size:12px;color:#aaaaaa;">This is an automated message. Please do not reply to this email.</p>
                            <p style="margin:0;font-size:12px;color:#aaaaaa;">&copy; {{ date('Y') }} Barangay Document Management System. All rights reserved.</p>
                        </td>
                    </tr>

                </table>

            </td>
        </tr>
    </table>

</body>
</html>