<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Document is Ready</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333333;
            line-height: 1.6;
        }
        .wrapper {
            max-width: 600px;
            margin: 40px auto;
            background-color: #ffffff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        .header {
            background-color: #1a56db;
            color: #ffffff;
            padding: 24px 32px;
        }
        .header h1 {
            font-size: 20px;
            font-weight: 700;
            letter-spacing: 0.3px;
        }
        .body {
            padding: 32px;
        }
        .body p {
            font-size: 15px;
            color: #333333;
            margin-bottom: 16px;
        }
        .password-box {
            background-color: #f0f4ff;
            border: 1px solid #c7d7f9;
            border-radius: 6px;
            padding: 20px 24px;
            margin: 24px 0;
            text-align: center;
        }
        .password-box .label {
            font-size: 12px;
            color: #666666;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 10px;
        }
        .password-box .password-value {
            font-size: 28px;
            font-weight: 700;
            letter-spacing: 6px;
            color: #1a56db;
            font-family: 'Courier New', Courier, monospace;
        }
        .note {
            background-color: #fffbeb;
            border-left: 4px solid #f59e0b;
            padding: 12px 16px;
            border-radius: 0 4px 4px 0;
            font-size: 13px;
            color: #92400e;
            margin: 24px 0;
        }
        .footer {
            background-color: #f9f9f9;
            border-top: 1px solid #eeeeee;
            padding: 20px 32px;
            font-size: 12px;
            color: #999999;
            text-align: center;
        }
        .footer p + p {
            margin-top: 4px;
        }
    </style>
</head>
<body>
    <div class="wrapper">

        <div class="header">
            <h1>Your Document is Ready</h1>
        </div>

        <div class="body">

            <p>Hello, <strong>{{ $name }}</strong>!</p>

            <p>
                Your requested barangay document has been officially processed and released.
                Please find the attached PDF in this email.
            </p>

            <p>
                This document is <strong>password-protected</strong>. Use the password below
                every time you open the attached PDF:
            </p>

            <div class="password-box">
                <div class="label">Document Password</div>
                <div class="password-value">{{ $password }}</div>
            </div>

            <div class="note">
                &#9888; Keep this password safe. You will need it every time you open the attached PDF.
                Do not share it with anyone you do not trust.
            </div>

            <p>
                If you did not request this document or believe this was sent in error,
                please contact your barangay office immediately.
            </p>

        </div>

        <div class="footer">
            <p>This is an automated message. Please do not reply to this email.</p>
            <p>&copy; {{ date('Y') }} Barangay Document Management System</p>
        </div>

    </div>
</body>
</html>