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

        [Display(Name = "Registration Date")]
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        [Display(Name = "Height (cm)")]
        [Range(50, 250, ErrorMessage = "Please enter a valid height in cm.")]
        public double? HeightCm { get; set; }

        [Display(Name = "Target Weight (kg)")]
        [Range(20, 300, ErrorMessage = "Please enter a realistic target weight.")]
        public double? TargetWeight { get; set; }

        [Display(Name = "Current Weight (kg)")]
        [Range(20, 300, ErrorMessage = "Please enter your current weight.")]
        public double? CurrentWeight { get; set; }

        [Display(Name = "Fitness Goal")]
        [StringLength(150)]
        public string? FitnessGoal { get; set; }

        [Display(Name = "Bio / Coaching Philosophy")]
        [StringLength(1000)]
        public string? Bio { get; set; }

        [Display(Name = "Certifications")]
        [StringLength(300)]
        public string? Certifications { get; set; }

        [Display(Name = "Profile Completed")]
        public bool IsProfileCompleted { get; set; } = false;

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
