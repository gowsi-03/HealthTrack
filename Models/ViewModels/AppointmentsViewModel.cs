using System.ComponentModel.DataAnnotations;
using HealthTrack.Models;

namespace HealthTrack.Models.ViewModels
{
    public class AppointmentsViewModel
    {
        public string ClientId { get; set; } = string.Empty;
        public string FullName { get; set; } = "John Doe";
        public string Email { get; set; } = "client@healthtrack.com";

        // Tab state: "Upcoming" or "Past"
        public string ActiveTab { get; set; } = "Upcoming";
        public int UpcomingCount { get; set; } = 3;
        public int PastCount { get; set; } = 2;

        public string SearchTerm { get; set; } = string.Empty;
        public string StatusFilter { get; set; } = "All";

        public List<AppointmentItemViewModel> UpcomingAppointments { get; set; } = new();
        public List<AppointmentItemViewModel> PastAppointments { get; set; } = new();

        public BookAppointmentInputModel BookingForm { get; set; } = new();
    }

    public class AppointmentItemViewModel
    {
        public int Id { get; set; }
        public string Day { get; set; } = "18";
        public string Month { get; set; } = "APR";
        public DateTime FullDate { get; set; }
        public string SpecialistName { get; set; } = "Dr. Maya Patel";
        public string SpecialistInitials { get; set; } = "MP";
        public string SpecialistRole { get; set; } = "Health & Wellness Physician";
        public string Category { get; set; } = "HEALTH CONSULTATION";
        public string TimeSlot { get; set; } = "10:30 AM";
        public string DurationText { get; set; } = "45 min";
        public string Status { get; set; } = "Approved"; // Approved, Pending, Completed, Cancelled
        public string Notes { get; set; } = "Routine cardiovascular checkup, blood pressure screening, and wellness consultation.";
        public string Location { get; set; } = "Consultation Suite 3B, London Wellness Clinic & Virtual Link";
        public bool IsVirtual { get; set; } = true;
    }

    public class BookAppointmentInputModel
    {
        [Required(ErrorMessage = "Please select consultation category")]
        [Display(Name = "Category")]
        public string Category { get; set; } = "Health Consultation";

        [Required(ErrorMessage = "Please select a specialist or trainer")]
        [Display(Name = "Specialist")]
        public string SpecialistName { get; set; } = "Dr. Maya Patel";

        [Required(ErrorMessage = "Please select appointment date")]
        [DataType(DataType.Date)]
        [Display(Name = "Date")]
        public DateTime AppointmentDate { get; set; } = DateTime.UtcNow.AddDays(7);

        [Required(ErrorMessage = "Please choose a time slot")]
        [Display(Name = "Time Slot")]
        public string TimeSlot { get; set; } = "10:30 AM";

        [Required]
        [Display(Name = "Duration")]
        public string DurationText { get; set; } = "45 min";

        [StringLength(300)]
        [Display(Name = "Notes / Reason for appointment")]
        public string? Notes { get; set; } = "General health checkup and routine progress review.";
    }
}
