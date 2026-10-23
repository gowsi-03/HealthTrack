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
        public int AssignedClientsCount { get; set; } = 0;
        public string AssignedClientsTrend { get; set; } = "0 clients enrolled";

        public int ActivePlansCount { get; set; } = 0;
        public string ActivePlansTrend { get; set; } = "0 active plans";

        public int UpcomingVisitsCount { get; set; } = 0;
        public string UpcomingVisitsTrend { get; set; } = "0 upcoming visits";

        // Client Progress Overview Chart
        public double AverageCompletionRate { get; set; } = 0;
        public string MonthlyChangeRate { get; set; } = "No activity yet";
        public List<string> ChartLabels { get; set; } = new() { "Week 1", "Week 2", "Week 3", "Week 4", "Week 5" };
        public List<double> ChartValues { get; set; } = new() { 0, 0, 0, 0, 0 };

        // Pending Requests
        public List<TrainerPendingRequestItem> PendingRequests { get; set; } = new();

        // Client Progress Table
        public List<TrainerClientProgressItem> RecentClients { get; set; } = new();

        // Available Clients for Assigning Workout/Diet Plans
        public List<TrainerClientLookupItem> AvailableClients { get; set; } = new();

        // Unread Notifications Count
        public int UnreadNotificationsCount { get; set; } = 0;

        // First-Time Setup
        public bool ShowFirstTimeSetup { get; set; } = false;
        public string TrainerSpecialty { get; set; } = "General Fitness & Health";

        // Modal for Creating New Plan
        public CreatePlanFormModel CreatePlanForm { get; set; } = new();
    }

    public class TrainerClientLookupItem
    {
        public string Id { get; set; } = string.Empty;
        public string FullName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
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
