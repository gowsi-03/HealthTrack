namespace HealthTrack.Models.ViewModels
{
    public class AdminAnalyticsViewModel
    {
        // Admin Info
        public string AdminFullName { get; set; } = "Jordan Lee";
        public string AdminEmail { get; set; } = "admin@healthtrack.com";
        public string AdminRole { get; set; } = "Administrator";
        public string AdminInitials { get; set; } = "JL";
        public int UnreadNotificationsCount { get; set; } = 3;

        // Filters
        public string SelectedTimeframe { get; set; } = "Last 30 days"; // Last 7 days, Last 30 days, Last 90 days, This year
        public string SelectedMetric { get; set; } = "All metrics"; // All metrics, User Growth, Workouts, Appointments, Coach Capacity

        // 4 KPI Executive Metric Cards
        public int TotalActiveUsers { get; set; } = 2846;
        public string UserGrowthText { get; set; } = "+12.4% vs last month";

        public int TotalWorkoutsLogged { get; set; } = 14820;
        public string WorkoutCompletionRate { get; set; } = "88.5%";
        public string WorkoutGrowthText { get; set; } = "+8.2% vs last month";

        public int TotalConsultations { get; set; } = 1278;
        public string ConsultationFulfillmentRate { get; set; } = "94.2%";
        public string ConsultationsGrowthText { get; set; } = "+15.2% vs last month";

        public double AvgCoachWorkload { get; set; } = 18.2;
        public string CoachCapacityStatus { get; set; } = "82% Capacity";
        public string CoachCapacityGrowthText { get; set; } = "Optimal allocation";

        // Chart 1: Platform Growth & Engagement (Monthly Curve)
        public List<string> GrowthChartLabels { get; set; } = new() { "Mar 01", "Mar 08", "Mar 15", "Mar 22", "Mar 29" };
        public List<int> ActiveUsersChartData { get; set; } = new() { 1984, 2120, 2350, 2580, 2846 };
        public List<int> WorkoutsChartData { get; set; } = new() { 2400, 2850, 3100, 3450, 3820 };

        // Chart 2: Platform Engagement by Department (Bar Chart)
        public List<string> DepartmentLabels { get; set; } = new() { "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" };
        public List<int> DailyEngagementData { get; set; } = new() { 420, 560, 490, 610, 580, 640, 710 };

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
