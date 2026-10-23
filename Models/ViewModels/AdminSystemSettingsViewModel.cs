using System.ComponentModel.DataAnnotations;

namespace HealthTrack.Models.ViewModels
{
    public class AdminSystemSettingsViewModel
    {
        // Admin Metadata
        public string AdminFullName { get; set; } = "Jordan Lee";
        public string AdminEmail { get; set; } = "admin@healthtrack.com";
        public string AdminRole { get; set; } = "Administrator";
        public string AdminInitials { get; set; } = "JL";
        public int UnreadNotificationsCount { get; set; } = 3;

        // Basic Settings (Left Card)
        [Required(ErrorMessage = "System name is required.")]
        [StringLength(100)]
        public string SystemName { get; set; } = "HealthTrack";

        [Required(ErrorMessage = "Support email is required.")]
        [EmailAddress(ErrorMessage = "Enter a valid support email address.")]
        public string SupportEmail { get; set; } = "support@healthtrack.com";

        [Required]
        public string DefaultTimeZone { get; set; } = "UTC -05:00 Eastern Time";

        [Required]
        public string DateFormat { get; set; } = "MMM DD, YYYY";

        // Reminder Timing (Right Card)
        public string WorkoutReminderTiming { get; set; } = "2 hours before";
        public bool WorkoutReminderEnabled { get; set; } = true;

        public string MealReminderTiming { get; set; } = "30 minutes before";
        public bool MealReminderEnabled { get; set; } = true;

        public string AppointmentReminderTiming { get; set; } = "24 hours before";
        public bool AppointmentReminderEnabled { get; set; } = true;
    }
}
