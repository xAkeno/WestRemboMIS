<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
</head>
<body>
    <h2>Hello <?php echo e($name); ?>,</h2>

    <p>
        This is a response regarding your inquiry about:
    </p>

    <h3>Topic: <?php echo e($topic); ?></h3>

    <hr>

    <p><?php echo e($replyMessage); ?></p>

    <br>
    <p>Thank you,</p>
</body>
</html><?php /**PATH C:\xampp\htdocs\Barangay MIS\resources\views/emails/contact_reply.blade.php ENDPATH**/ ?>