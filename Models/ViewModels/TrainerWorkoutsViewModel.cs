using System.Collections.Generic;

namespace HealthTrack.Models.ViewModels
{
    public class TrainerWorkoutsViewModel
    {
        public string TrainerName { get; set; } = "Maya Patel";
        public string TrainerEmail { get; set; } = "maya.patel@healthtrack.com";
        public string TrainerInitials { get; set; } = "AM";
        public int UnreadNotificationsCount { get; set; } = 2;

        // KPI Summary Metrics
        public int TotalActiveProgramsCount { get; set; } = 24;
        public int TotalTemplatesCount { get; set; } = 8;
        public int AvgCompletionRate { get; set; } = 78;
        public int WeeklyCompletedSessions { get; set; } = 142;

        // Template Programs
        public List<WorkoutTemplateItem> Templates { get; set; } = new();

        // Active Client Programs
        public List<ClientWorkoutRoutineItem> ClientRoutines { get; set; } = new();

        // Clients list for dropdown assignment
        public List<ClientDropdownOption> AvailableClients { get; set; } = new();

        // Modal Form Model
        public CreateWorkoutRoutineFormModel CreateForm { get; set; } = new();
    }

    public class WorkoutTemplateItem
    {
        public string Id { get; set; } = string.Empty;
        public string Title { get; set; } = string.Empty;
        public string Category { get; set; } = "Strength"; // Strength, Cardio, Mobility, Hypertrophy
        public int DurationWeeks { get; set; } = 8;
        public int DaysPerWeek { get; set; } = 4;
        public int MinutesPerSession { get; set; } = 45;
        public int AssignedClientsCount { get; set; } = 12;
        public string Description { get; set; } = string.Empty;
        public string BadgeClass { get; set; } = "badge-teal";
    }

    public class ClientWorkoutRoutineItem
    {
        public string ClientId { get; set; } = string.Empty;
        public string ClientName { get; set; } = string.Empty;
        public string ClientEmail { get; set; } = string.Empty;
        public string ClientInitials { get; set; } = "AM";
        public string RoutineTitle { get; set; } = string.Empty;
        public string Category { get; set; } = "Strength";
        public string DurationText { get; set; } = "Week 5 of 8 · 4 days/wk";
        public int CompletionPercentage { get; set; } = 87;
        public string Status { get; set; } = "Active"; // Active, At risk, Completed
        public string LastCompletedSession { get; set; } = "Yesterday (Upper body)";
    }

    public class ClientDropdownOption
    {
        public string Id { get; set; } = string.Empty;
        public string FullName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
    }

    public class CreateWorkoutRoutineFormModel
    {
        public string ClientId { get; set; } = string.Empty;
        public string Title { get; set; } = string.Empty;
        public string Category { get; set; } = "Strength & Mobility";
        public int DurationWeeks { get; set; } = 8;
        public int DaysPerWeek { get; set; } = 4;
        public string Description { get; set; } = string.Empty;
        public string ExercisesText { get; set; } = string.Empty;
    }

    public class CreateWorkoutTemplateFormModel
    {
        public string Title { get; set; } = string.Empty;
        public string Category { get; set; } = "Strength & Mobility";
        public int DurationWeeks { get; set; } = 8;
        public int DaysPerWeek { get; set; } = 4;
        public int MinutesPerSession { get; set; } = 45;
        public string Description { get; set; } = string.Empty;
        public string ExercisesText { get; set; } = string.Empty;
    }
}
