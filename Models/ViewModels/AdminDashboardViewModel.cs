using System.ComponentModel.DataAnnotations;

namespace HealthTrack.Models.ViewModels
{
    public class AdminDashboardViewModel
    {
        // Admin Profile Info
        public string AdminFullName { get; set; } = "System Administrator";
        public string AdminEmail { get; set; } = "admin@healthtrack.com";
        public string AdminRole { get; set; } = "Administrator";
        public string AdminInitials { get; set; } = "SA";
        public int UnreadNotificationsCount { get; set; } = 0;

        // Metric Stat Cards (Row 1)
        public int TotalUsers { get; set; } = 0;
        public string UsersGrowthText { get; set; } = "Total platform accounts";

        public int TotalClients { get; set; } = 0;
        public string ClientsGrowthText { get; set; } = "Active clients";

        public int TotalTrainers { get; set; } = 0;
        public string TrainersGrowthText { get; set; } = "Certified coaches";

        public int TotalAdmins { get; set; } = 0;
        public string AdminsGrowthText { get; set; } = "System managers";

        public int TotalAppointments { get; set; } = 0;
        public string AppointmentsGrowthText { get; set; } = "Scheduled sessions";

        // System Usage Chart (Row 2 Left)
        public int ActiveUsersCount { get; set; } = 0;
        public string UsageGrowthText { get; set; } = "Active now";
        public string SelectedUsageTimeRange { get; set; } = "Last 30 days";
        public List<string> UsageLabels { get; set; } = new();
        public List<int> UsageData { get; set; } = new();

        // User Distribution Donut Chart (Row 2 Right)
        public double ClientsPercentage { get; set; } = 0.0;
        public double TrainersPercentage { get; set; } = 0.0;
        public double AdminsPercentage { get; set; } = 0.0;

        // Recent Activity Table (Row 3)
        public List<AdminRecentActivityItem> RecentActivities { get; set; } = new();

        // Form for Add User modal
        public AdminAddUserInputModel NewUserForm { get; set; } = new();
    }

    public class AdminRecentActivityItem
    {
        public string Id { get; set; } = string.Empty;
        public string FullName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Role { get; set; } = "Client"; // Client, Trainer, Admin
        public string Status { get; set; } = "Active"; // Active, Inactive
        public string LastActive { get; set; } = "Apr 12, 2025";
        public string Initials { get; set; } = "AM";
        public string AvatarBgColor { get; set; } = "#E0F2FE"; // Soft pastel
        public string AvatarTextColor { get; set; } = "#0284C7";
    }

    public class AdminAddUserInputModel
    {
        [Required(ErrorMessage = "Full Name is required.")]
        [StringLength(100)]
        public string FullName { get; set; } = string.Empty;

        [Required(ErrorMessage = "Email is required.")]
        [EmailAddress(ErrorMessage = "Please enter a valid email address.")]
        public string Email { get; set; } = string.Empty;

        [Required]
        public string Role { get; set; } = "Client"; // Client, Trainer, Admin

        [Required(ErrorMessage = "Temporary password is required.")]
        [StringLength(100, MinimumLength = 6, ErrorMessage = "Password must be at least 6 characters.")]
        public string Password { get; set; } = "HealthTrack123!";
    }
}
