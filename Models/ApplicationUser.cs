using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HealthTrack.Models
{
    public class ApplicationUser : IdentityUser
    {
        [Required]
        [StringLength(100)]
        [Display(Name = "Full Name")]
        public string FullName { get; set; } = string.Empty;

        [Required]
        [StringLength(20)]
        [Display(Name = "Account Role")]
        public string Role { get; set; } = "Client"; // Client, Trainer, Admin

        [Display(Name = "Is Approved")]
        public bool IsApproved { get; set; } = true;

        [Display(Name = "Height (cm)")]
        [Range(50, 250, ErrorMessage = "Please enter a valid height in cm.")]
        public double? HeightCm { get; set; } = 175.0;

        [Display(Name = "Target Weight (kg)")]
        [Range(20, 300, ErrorMessage = "Please enter a realistic target weight.")]
        public double? TargetWeight { get; set; } = 70.0;

        [Display(Name = "Current Weight (kg)")]
        [Range(20, 300, ErrorMessage = "Please enter your current weight.")]
        public double? CurrentWeight { get; set; } = 75.0;

        [Display(Name = "Fitness Goal")]
        [StringLength(150)]
        public string? FitnessGoal { get; set; } = "General Fitness & Health";

        public string? TrainerId { get; set; }

        [ForeignKey("TrainerId")]
        public virtual ApplicationUser? Trainer { get; set; }

        public virtual ICollection<WorkoutPlan> WorkoutPlans { get; set; } = new List<WorkoutPlan>();
        public virtual ICollection<HealthLog> HealthLogs { get; set; } = new List<HealthLog>();
        public virtual ICollection<Appointment> AppointmentsAsClient { get; set; } = new List<Appointment>();
        public virtual ICollection<Appointment> AppointmentsAsTrainer { get; set; } = new List<Appointment>();
        public virtual ICollection<Notification> Notifications { get; set; } = new List<Notification>();
    }
}
