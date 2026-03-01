<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
</head>
<body>
    <h2>Hello {{ $name }},</h2>

    <p>
        This is a response regarding your inquiry about:
    </p>

    <h3>Topic: {{ $topic }}</h3>

    <hr>

    <p>{{ $replyMessage }}</p>

    <br>
    <p>Thank you,</p>
</body>
</html>