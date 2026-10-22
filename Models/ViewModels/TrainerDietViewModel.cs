using System.Collections.Generic;

namespace HealthTrack.Models.ViewModels
{
    public class TrainerDietViewModel
    {
        public string TrainerName { get; set; } = "Maya Patel";
        public string TrainerEmail { get; set; } = "maya.patel@healthtrack.com";
        public string TrainerInitials { get; set; } = "AM";
        public int UnreadNotificationsCount { get; set; } = 2;

        // KPI Summary Metrics
        public int TotalActiveDietPlans { get; set; } = 24;
        public int TotalTemplatesCount { get; set; } = 6;
        public int AvgMacroAdherence { get; set; } = 82;
        public int WeeklyMealLogsCount { get; set; } = 96;

        // Template Programs
        public List<DietTemplateItem> Templates { get; set; } = new();

        // Active Client Nutrition Roster
        public List<ClientDietRosterItem> ClientDietRosters { get; set; } = new();

        // Available clients for assignment modal dropdown
        public List<ClientDropdownOption> AvailableClients { get; set; } = new();

        // Modal Form Model
        public CreateDietPlanFormModel CreateForm { get; set; } = new();
    }

    public class DietTemplateItem
    {
        public string Id { get; set; } = string.Empty;
        public string Title { get; set; } = string.Empty;
        public string Category { get; set; } = "Balanced"; // Balanced, High Protein, Fat Loss, Hypertrophy, Plant-Based
        public int DailyCalories { get; set; } = 2150;
        public int ProteinGrams { get; set; } = 120;
        public int MealsPerDay { get; set; } = 4;
        public int AssignedClientsCount { get; set; } = 10;
        public string Description { get; set; } = string.Empty;
        public string BadgeClass { get; set; } = "badge-teal";
    }

    public class ClientDietRosterItem
    {
        public string ClientId { get; set; } = string.Empty;
        public string ClientName { get; set; } = string.Empty;
        public string ClientEmail { get; set; } = string.Empty;
        public string ClientInitials { get; set; } = "AM";
        public string PlanTitle { get; set; } = string.Empty;
        public string Category { get; set; } = "Balanced";
        public int TargetCalories { get; set; } = 2150;
        public int TargetProtein { get; set; } = 120;
        public int MealsLoggedToday { get; set; } = 3;
        public int TotalMealsScheduled { get; set; } = 4;
        public int AdherencePercentage { get; set; } = 85;
        public string Status { get; set; } = "Active"; // Active, At risk
        public string LastMealLogged { get; set; } = "Lunch (12:30 PM)";
    }

    public class CreateDietPlanFormModel
    {
        public string ClientId { get; set; } = string.Empty;
        public string Title { get; set; } = string.Empty;
        public string Category { get; set; } = "Balanced Performance";
        public int TargetCalories { get; set; } = 2150;
        public int TargetProtein { get; set; } = 120;
        public int MealsPerDay { get; set; } = 4;
        public string DietaryNotes { get; set; } = string.Empty;
    }
}
