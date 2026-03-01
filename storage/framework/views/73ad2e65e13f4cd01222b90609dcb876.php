<?php $__env->startComponent('mail::message'); ?>
# Barangay West Rembo - New Event Announcement

The office of **Barangay West Rembo** would like to inform you that a new community event has been scheduled:

**Event Title:** <?php echo new \Illuminate\Support\EncodedHtmlString($event->title); ?>  
**Date:** <?php echo new \Illuminate\Support\EncodedHtmlString($event->date); ?>  
**Time:** <?php echo new \Illuminate\Support\EncodedHtmlString($event->start_time); ?> <?php if($event->end_time): ?>- <?php echo new \Illuminate\Support\EncodedHtmlString($event->end_time); ?><?php endif; ?>  
**Location:** <?php echo new \Illuminate\Support\EncodedHtmlString($event->location ?? 'Barangay West Rembo Hall / Designated Area'); ?>


<?php if($event->description): ?>
**Description:**  
<?php echo new \Illuminate\Support\EncodedHtmlString($event->description); ?>

<?php endif; ?>

**Event Details Link:**  
http://localhost:8000/event-detail/<?php echo new \Illuminate\Support\EncodedHtmlString($event->id); ?>


We encourage all residents to participate and stay informed.  

Thank you,<br>
**Barangay West Rembo Office**
<?php echo $__env->renderComponent(); ?><?php /**PATH C:\xampp\htdocs\Barangay MIS\resources\views/emails/events/new_event.blade.php ENDPATH**/ ?>