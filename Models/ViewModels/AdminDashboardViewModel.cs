using System.ComponentModel.DataAnnotations;

namespace HealthTrack.Models.ViewModels
{
    public class AdminDashboardViewModel
    {
        // Admin Profile Info
        public string AdminFullName { get; set; } = "Jordan Lee";
        public string AdminEmail { get; set; } = "admin@healthtrack.com";
        public string AdminRole { get; set; } = "Administrator";
        public string AdminInitials { get; set; } = "JL";
        public int UnreadNotificationsCount { get; set; } = 3;

        // Metric Stat Cards (Row 1)
        public int TotalUsers { get; set; } = 2846;
        public string UsersGrowthText { get; set; } = "+8.2% from last month";

        public int TotalClients { get; set; } = 2492;
        public string ClientsGrowthText { get; set; } = "+7.8% from last month";

        public int TotalTrainers { get; set; } = 354;
        public string TrainersGrowthText { get; set; } = "+11.4% from last month";

        public int TotalAppointments { get; set; } = 1278;
        public string AppointmentsGrowthText { get; set; } = "+15.2% from last month";

        // System Usage Chart (Row 2 Left)
        public int ActiveUsersCount { get; set; } = 1984;
        public string UsageGrowthText { get; set; } = "+12.4%";
        public string SelectedUsageTimeRange { get; set; } = "Last 30 days";
        public List<string> UsageLabels { get; set; } = new() { "Mar 01", "Mar 08", "Mar 15", "Mar 22", "Mar 29" };
        public List<int> UsageData { get; set; } = new() { 66, 68, 73, 76, 81 };

        // User Distribution Donut Chart (Row 2 Right)
        public double ClientsPercentage { get; set; } = 87.6;
        public double TrainersPercentage { get; set; } = 12.4;

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
