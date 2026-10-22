using System;
using System.Collections.Generic;

namespace HealthTrack.Models.ViewModels
{
    public class TrainerAppointmentsViewModel
    {
        public string TrainerName { get; set; } = "Maya Patel";
        public string TrainerEmail { get; set; } = "maya.patel@healthtrack.com";
        public string TrainerInitials { get; set; } = "AM";
        public int UnreadNotificationsCount { get; set; } = 2;

        public int PendingRequestsCount { get; set; } = 4;
        public int ApprovedRequestsCount { get; set; } = 8;
        public int TotalRequestsCount { get; set; } = 12;

        public string ActiveTab { get; set; } = "Requests"; // "Requests" or "Calendar"
        public string SelectedStatus { get; set; } = "All";

        public List<TrainerAppointmentItem> Appointments { get; set; } = new();
    }

    public class TrainerAppointmentItem
    {
        public int Id { get; set; }
        public string ClientId { get; set; } = string.Empty;
        public string ClientName { get; set; } = string.Empty;
        public string ClientEmail { get; set; } = string.Empty;
        public string ClientInitials { get; set; } = "AM";
        public string ConsultationType { get; set; } = "HEALTH CONSULTATION"; // HEALTH CONSULTATION, PERSONAL TRAINING, NUTRITION REVIEW, POSTURE & REHAB
        public string DayNumber { get; set; } = "18";
        public string MonthText { get; set; } = "APR";
        public DateTime AppointmentDate { get; set; }
        public string TimeSlot { get; set; } = "10:30 AM";
        public int DurationMinutes { get; set; } = 45;
        public string Status { get; set; } = "Approved"; // "Approved", "Pending", "Cancelled"
        public string Notes { get; set; } = string.Empty;
    }
}
