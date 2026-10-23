using System.ComponentModel.DataAnnotations;

namespace HealthTrack.Models.ViewModels
{
    public class AdminAppointmentManagementViewModel
    {
        // Admin Profile Info
        public string AdminFullName { get; set; } = "Jordan Lee";
        public string AdminEmail { get; set; } = "admin@healthtrack.com";
        public string AdminRole { get; set; } = "Administrator";
        public string AdminInitials { get; set; } = "JL";
        public int UnreadNotificationsCount { get; set; } = 3;

        // KPI Metric Counters
        public int TotalAppointmentsCount { get; set; } = 0;
        public int PendingCount { get; set; } = 0;
        public int ConfirmedCount { get; set; } = 0;
        public int CompletedCount { get; set; } = 0;
        public int CancelledCount { get; set; } = 0;

        // Filters
        public string SearchTerm { get; set; } = string.Empty;
        public string StatusFilter { get; set; } = "All"; // All, Pending, Confirmed, Completed, Cancelled
        public string TrainerFilter { get; set; } = "All"; // All, or TrainerId
        public string TimeframeFilter { get; set; } = "All"; // All, Today, Upcoming, Past

        // Available Trainers for dropdown filter & reassign modal
        public List<AdminTrainerOptionViewModel> AvailableTrainers { get; set; } = new();

        // Pagination
        public int CurrentPage { get; set; } = 1;
        public int PageSize { get; set; } = 5;
        public int TotalItems { get; set; } = 0;
        public int TotalPages => (int)Math.Ceiling((double)TotalItems / (PageSize > 0 ? PageSize : 5));
        public int StartItemIndex => TotalItems == 0 ? 0 : ((CurrentPage - 1) * PageSize) + 1;
        public int EndItemIndex => Math.Min(CurrentPage * PageSize, TotalItems);

        // Appointments List
        public List<AdminAppointmentListItemViewModel> Appointments { get; set; } = new();
    }

    public class AdminTrainerOptionViewModel
    {
        public string Id { get; set; } = string.Empty;
        public string Name { get; set; } = string.Empty;
        public string Specialty { get; set; } = string.Empty;
    }

    public class AdminAppointmentListItemViewModel
    {
        public int Id { get; set; }

        // Client
        public string ClientId { get; set; } = string.Empty;
        public string ClientName { get; set; } = string.Empty;
        public string ClientEmail { get; set; } = string.Empty;
        public string ClientInitials { get; set; } = "CL";
        public string ClientAvatarBg { get; set; } = "#E0F2FE";
        public string ClientAvatarText { get; set; } = "#0284C7";

        // Trainer / Specialist
        public string TrainerId { get; set; } = string.Empty;
        public string TrainerName { get; set; } = string.Empty;
        public string TrainerSpecialty { get; set; } = "Performance Coach";
        public string TrainerInitials { get; set; } = "TR";
        public string TrainerAvatarBg { get; set; } = "#ECFDF5";
        public string TrainerAvatarText { get; set; } = "#059669";

        // Timing & Details
        public DateTime AppointmentDate { get; set; }
        public string AppointmentDateFormatted { get; set; } = string.Empty;
        public string TimeSlot { get; set; } = "10:00 AM";
        public string ConsultationType { get; set; } = "Nutrition Consultation";
        public string Status { get; set; } = "Confirmed"; // Pending, Confirmed, Completed, Cancelled
        public string Notes { get; set; } = string.Empty;
        public bool IsUpcoming { get; set; } = true;
    }
}
