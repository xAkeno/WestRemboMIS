<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Secure Document</title>
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
                            <div style="display:inline-block;background:rgba(255,255,255,0.15);border-radius:50%;width:64px;height:64px;line-height:64px;font-size:28px;margin-bottom:16px;">📄</div>
                            <h1 style="margin:0;color:#ffffff;font-size:22px;font-weight:700;letter-spacing:0.3px;">Your Secure Document</h1>
                            <p style="margin:6px 0 0;color:rgba(255,255,255,0.70);font-size:13px;">Barangay Document Management Portal</p>
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

                            <p style="margin:0 0 24px;font-size:14px;color:#555555;line-height:1.7;">
                                Your barangay document has been officially processed and released. Your <strong>password-protected PDF</strong> is attached to this email.
                            </p>

                            <!-- Document info card -->
                            <table width="100%" cellpadding="0" cellspacing="0" style="background:#eff6ff;border:1px solid #bfdbfe;border-radius:12px;margin-bottom:24px;">
                                <tr>
                                    <td style="padding:20px 24px;">
                                        <table width="100%" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="font-size:13px;color:#1e3a8a;font-weight:700;padding-bottom:4px;">📎 &nbsp;Attached File</td>
                                            </tr>
                                            <tr>
                                                <td style="font-size:15px;color:#0a1628;font-weight:600;padding-bottom:12px;">document.pdf</td>
                                            </tr>
                                            <tr>
                                                <td style="border-top:1px solid #bfdbfe;padding-top:12px;font-size:13px;color:#555555;line-height:1.6;">
                                                    🔐 &nbsp;This file is <strong>password-protected</strong>. Use the password sent in the previous email to unlock it.
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>

                            <!-- Steps -->
                            <p style="margin:0 0 14px;font-size:14px;color:#0a1628;font-weight:700;">How to open your document:</p>

                            <table width="100%" cellpadding="0" cellspacing="0" style="margin-bottom:24px;">
                                <tr>
                                    <td style="vertical-align:top;padding-bottom:12px;">
                                        <table cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="background:linear-gradient(135deg,#ec4899,#1e3a8a);color:#fff;font-size:12px;font-weight:700;border-radius:50%;width:26px;height:26px;text-align:center;line-height:26px;vertical-align:top;">1</td>
                                                <td style="padding-left:12px;font-size:13px;color:#555555;line-height:1.6;vertical-align:top;">Save the attached <strong>document.pdf</strong> to your device.</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="vertical-align:top;padding-bottom:12px;">
                                        <table cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="background:linear-gradient(135deg,#ec4899,#1e3a8a);color:#fff;font-size:12px;font-weight:700;border-radius:50%;width:26px;height:26px;text-align:center;line-height:26px;vertical-align:top;">2</td>
                                                <td style="padding-left:12px;font-size:13px;color:#555555;line-height:1.6;vertical-align:top;">Open it using any PDF reader (Adobe Acrobat, Preview, or your browser).</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="vertical-align:top;">
                                        <table cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="background:linear-gradient(135deg,#ec4899,#1e3a8a);color:#fff;font-size:12px;font-weight:700;border-radius:50%;width:26px;height:26px;text-align:center;line-height:26px;vertical-align:top;">3</td>
                                                <td style="padding-left:12px;font-size:13px;color:#555555;line-height:1.6;vertical-align:top;">Enter the password from the <strong>separate email</strong> we sent you moments ago.</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>

                            <!-- Warning note -->
                            <table width="100%" cellpadding="0" cellspacing="0" style="background:#fff0f7;border-left:4px solid #ec4899;border-radius:0 8px 8px 0;margin-bottom:24px;">
                                <tr>
                                    <td style="padding:14px 16px;font-size:13px;color:#1e3a8a;line-height:1.6;">
                                        ⚠️ <strong>Did not receive the password email?</strong> Check your spam/junk folder, or contact the barangay office for assistance.
                                    </td>
                                </tr>
                            </table>

                            <p style="margin:0;font-size:13px;color:#888;line-height:1.6;">
                                If you did not request this document or believe this email was sent in error, please contact your barangay office immediately.
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