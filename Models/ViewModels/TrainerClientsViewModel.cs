using System.Collections.Generic;

namespace HealthTrack.Models.ViewModels
{
    public class TrainerClientsViewModel
    {
        public string TrainerName { get; set; } = "Maya Patel";
        public string TrainerEmail { get; set; } = "maya.patel@healthtrack.com";
        public string TrainerInitials { get; set; } = "AM"; // Matching reference AM avatar for Maya Patel
        public int TotalClientsCount { get; set; } = 28;
        public int ActiveClientsCount { get; set; } = 24;
        public int AtRiskClientsCount { get; set; } = 4;

        public string SearchTerm { get; set; } = string.Empty;
        public string SelectedStatus { get; set; } = "All";
        public string SelectedPlan { get; set; } = "All";
        public int CurrentPage { get; set; } = 1;
        public int TotalPages { get; set; } = 3;

        public List<TrainerClientItem> Clients { get; set; } = new();

        public int UnreadNotificationsCount { get; set; } = 2;

        public AddClientFormModel AddClientForm { get; set; } = new();
    }

    public class TrainerClientItem
    {
        public string Id { get; set; } = string.Empty;
        public string FullName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Initials { get; set; } = "AM";
        public string ActivePlan { get; set; } = "Strength & mobility";
        public int CompletionPercentage { get; set; } = 87;
        public string WeightChange { get; set; } = "-3.8 kg";
        public bool IsWeightLoss { get; set; } = true;
        public string Status { get; set; } = "Active"; // "Active", "At risk", "Inactive"
        public string JoinedDate { get; set; } = "Jan 2025";
        public double CurrentWeight { get; set; } = 72.4;
        public double TargetWeight { get; set; } = 70.0;
    }

    public class AddClientFormModel
    {
        public string FullName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string FitnessGoal { get; set; } = "Strength & mobility";
        public double HeightCm { get; set; } = 175.0;
        public double CurrentWeight { get; set; } = 70.0;
        public double TargetWeight { get; set; } = 68.0;
    }
}
