using System;
using System.Collections.Generic;

namespace HealthTrack.Models.ViewModels
{
    public class TrainerDashboardViewModel
    {
        // Trainer Info
        public string TrainerId { get; set; } = string.Empty;
        public string TrainerName { get; set; } = "Maya";
        public string TrainerFullName { get; set; } = "Dr. Maya Patel";
        public string TrainerEmail { get; set; } = "maya.patel@healthtrack.com";
        public string DateFormatted { get; set; } = "MONDAY, APRIL 14";

        // Top 3 Stat Cards
        public int AssignedClientsCount { get; set; } = 24;
        public string AssignedClientsTrend { get; set; } = "+3 new clients from last month";

        public int ActivePlansCount { get; set; } = 18;
        public string ActivePlansTrend { get; set; } = "+8.2% from last month";

        public int UpcomingVisitsCount { get; set; } = 7;
        public string UpcomingVisitsTrend { get; set; } = "4 requests from last month";

        // Client Progress Overview Chart
        public double AverageCompletionRate { get; set; } = 82.6;
        public string MonthlyChangeRate { get; set; } = "+6.4% this month";
        public List<string> ChartLabels { get; set; } = new() { "Mar 01", "Mar 08", "Mar 15", "Mar 22", "Mar 29" };
        public List<double> ChartValues { get; set; } = new() { 68.0, 71.5, 75.2, 78.8, 83.0 };

        // Pending Requests
        public List<TrainerPendingRequestItem> PendingRequests { get; set; } = new();

        // Client Progress Table
        public List<TrainerClientProgressItem> RecentClients { get; set; } = new();

        // Unread Notifications Count
        public int UnreadNotificationsCount { get; set; } = 2;

        // Modal for Creating New Plan
        public CreatePlanFormModel CreatePlanForm { get; set; } = new();
    }

    public class TrainerPendingRequestItem
    {
        public int AppointmentId { get; set; }
        public string ClientId { get; set; } = string.Empty;
        public string ClientName { get; set; } = string.Empty;
        public string Initials { get; set; } = "AM";
        public string ServiceType { get; set; } = "Health consultation";
        public string AppointmentDateFormatted { get; set; } = "18 APR";
        public string Status { get; set; } = "Pending";
        public string TimeSlot { get; set; } = "10:30 AM";
    }

    public class TrainerClientProgressItem
    {
        public string ClientId { get; set; } = string.Empty;
        public string ClientName { get; set; } = string.Empty;
        public string Initials { get; set; } = "AM";
        public string ActivePlan { get; set; } = "Strength & mobility";
        public int CompletionPercentage { get; set; } = 87;
        public string WeightChange { get; set; } = "-3.8 kg";
        public bool IsWeightLoss { get; set; } = true;
        public string Status { get; set; } = "Active"; // "Active", "At risk"
    }

    public class CreatePlanFormModel
    {
        public string ClientId { get; set; } = string.Empty;
        public string PlanType { get; set; } = "Workout"; // "Workout", "Diet"
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public int TargetCalories { get; set; } = 2000;
        public string ExercisesOrMeals { get; set; } = string.Empty;
    }
}
