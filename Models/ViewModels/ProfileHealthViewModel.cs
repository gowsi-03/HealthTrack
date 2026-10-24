using System.ComponentModel.DataAnnotations;
using HealthTrack.Models;

namespace HealthTrack.Models.ViewModels
{
    public class ProfileHealthViewModel
    {
        // User identity details
        public string UserId { get; set; } = string.Empty;
        public string FullName { get; set; } = "Alex Morgan";
        public string Email { get; set; } = "alex.morgan@email.com";
        public string MemberSince { get; set; } = "January 2025";
        public string AssignedTrainer { get; set; } = "None";
        public string? TrainerId { get; set; }
        public string? TrainerSpecialty { get; set; }
        public string PrimaryGoal { get; set; } = "General Fitness & Health";
        public string MembershipStatus { get; set; } = "Active member";
        public bool HasLoggedMeasurements { get; set; } = false;

        // Biometrics / measurements form (matches right card in image)
        [Display(Name = "Weight (kg)")]
        [Required(ErrorMessage = "Please enter your weight.")]
        [Range(20, 300, ErrorMessage = "Please enter a realistic weight in kg.")]
        public double WeightKg { get; set; } = 72.4;

        [Display(Name = "Height (cm)")]
        [Required(ErrorMessage = "Please enter your height.")]
        [Range(50, 260, ErrorMessage = "Please enter a realistic height in cm.")]
        public double HeightCm { get; set; } = 178.0;

        [Display(Name = "Waist (cm)")]
        [Range(30, 200, ErrorMessage = "Please enter a realistic waist measurement in cm.")]
        public double? WaistCm { get; set; }

        [Display(Name = "Body fat (%)")]
        [Range(1, 70, ErrorMessage = "Please enter a realistic body fat percentage.")]
        public double? BodyFatPercentage { get; set; }

        // Additional health calculations
        public double CalculatedBmi { get; set; } = 22.8;
        public string BmiCategory { get; set; } = "Normal weight";
        public double TargetWeight { get; set; } = 70.0;

        // Edit Profile Modal Fields
        [Display(Name = "Full Name")]
        [Required(ErrorMessage = "Full name is required.")]
        [StringLength(100)]
        public string EditFullName { get; set; } = "Alex Morgan";

        [Display(Name = "Primary Goal")]
        [Required(ErrorMessage = "Primary goal is required.")]
        [StringLength(150)]
        public string EditPrimaryGoal { get; set; } = "Strength & wellness";

        [Display(Name = "Target Weight (kg)")]
        [Range(20, 300, ErrorMessage = "Please enter a realistic target weight.")]
        public double EditTargetWeight { get; set; } = 70.0;

        [Display(Name = "Assigned Trainer")]
        public string? EditTrainerId { get; set; }

        public List<TrainerOption> AvailableTrainers { get; set; } = new();

        // Privacy settings options
        public bool ShareDataWithTrainer { get; set; } = true;
        public bool AllowAnonymousAnalytics { get; set; } = false;
        public bool EmailWeeklyHealthReport { get; set; } = true;

        // Unread notifications for top header
        public int UnreadNotificationsCount { get; set; } = 0;
    }

    public class TrainerOption
    {
        public string Id { get; set; } = string.Empty;
        public string Name { get; set; } = string.Empty;
        public string RoleOrSpecialty { get; set; } = string.Empty;
    }
}
