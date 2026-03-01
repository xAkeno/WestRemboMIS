@component('mail::message')
# Barangay West Rembo - New Event Announcement

The office of **Barangay West Rembo** would like to inform you that a new community event has been scheduled:

**Event Title:** {{ $event->title }}  
**Date:** {{ $event->date }}  
**Time:** {{ $event->start_time }} @if($event->end_time)- {{ $event->end_time }}@endif  
**Location:** {{ $event->location ?? 'Barangay West Rembo Hall / Designated Area' }}

@if($event->description)
**Description:**  
{{ $event->description }}
@endif

**Event Details Link:**  
http://localhost:8000/calendar

We encourage all residents to participate and stay informed.  

Thank you,<br>
**Barangay West Rembo Office**
@endcomponent