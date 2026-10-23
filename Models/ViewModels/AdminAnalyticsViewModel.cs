namespace HealthTrack.Models.ViewModels
{
    public class AdminAnalyticsViewModel
    {
        // Admin Info
        public string AdminFullName { get; set; } = "System Administrator";
        public string AdminEmail { get; set; } = "admin@healthtrack.com";
        public string AdminRole { get; set; } = "Administrator";
        public string AdminInitials { get; set; } = "SA";
        public int UnreadNotificationsCount { get; set; } = 0;

        // Filters
        public string SelectedTimeframe { get; set; } = "Last 30 days"; // Last 7 days, Last 30 days, Last 90 days, This year
        public string SelectedMetric { get; set; } = "All metrics"; // All metrics, User Growth, Workouts, Appointments, Coach Capacity

        // 4 KPI Executive Metric Cards (Excluding Admin - Clients and Trainers only)
        public int TotalActiveUsers { get; set; } = 0;
        public string UserGrowthText { get; set; } = "0 active";

        public int TotalWorkoutsLogged { get; set; } = 0;
        public string WorkoutCompletionRate { get; set; } = "0%";
        public string WorkoutGrowthText { get; set; } = "No workouts yet";

        public int TotalConsultations { get; set; } = 0;
        public string ConsultationFulfillmentRate { get; set; } = "0%";
        public string ConsultationsGrowthText { get; set; } = "No bookings yet";

        public double AvgCoachWorkload { get; set; } = 0.0;
        public string CoachCapacityStatus { get; set; } = "0 coaches";
        public string CoachCapacityGrowthText { get; set; } = "No coaches registered";

        // Chart 1: Platform Growth & Engagement (Monthly Curve)
        public List<string> GrowthChartLabels { get; set; } = new();
        public List<int> ActiveUsersChartData { get; set; } = new();
        public List<int> WorkoutsChartData { get; set; } = new();

        // Chart 2: Platform Engagement by Department (Bar Chart)
        public string WeeklyActivityRate { get; set; } = "0%";
        public string WeeklyActivityTrendText { get; set; } = "No activity this week";
        public List<string> DepartmentLabels { get; set; } = new() { "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" };
        public List<int> DailyEngagementData { get; set; } = new() { 0, 0, 0, 0, 0, 0, 0 };

        // Coach Utilization & Performance Leaderboard Table
        public List<AdminCoachPerformanceItemViewModel> CoachLeaderboard { get; set; } = new();
    }

    public class AdminCoachPerformanceItemViewModel
    {
        public string Id { get; set; } = string.Empty;
        public string CoachName { get; set; } = string.Empty;
        public string CoachEmail { get; set; } = string.Empty;
        public string Specialty { get; set; } = string.Empty;
        public string Initials { get; set; } = "MP";
        public string AvatarBgColor { get; set; } = "#ECFDF5";
        public string AvatarTextColor { get; set; } = "#059669";
        public int AssignedClients { get; set; } = 24;
        public int SessionsDelivered { get; set; } = 48;
        public double CompletionRatePercent { get; set; } = 96.5;
        public string Status { get; set; } = "High Performing"; // High Performing, On Track, Available
    }
}
