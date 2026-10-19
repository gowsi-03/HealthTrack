using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HealthTrack.Models
{
    public class HealthLog
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string ClientId { get; set; } = string.Empty;

        [ForeignKey("ClientId")]
        public virtual ApplicationUser? Client { get; set; }

        [Display(Name = "Log Date")]
        public DateTime LogDate { get; set; } = DateTime.UtcNow;

        [Required]
        [Range(20, 300)]
        [Display(Name = "Weight (kg)")]
        public double WeightKg { get; set; }

        [Display(Name = "Calculated BMI")]
        public double CalculatedBmi { get; set; }

        [Range(0, 5000)]
        [Display(Name = "Calories Burned")]
        public int CaloriesBurned { get; set; } = 0;

        [Range(0, 10)]
        [Display(Name = "Water Intake (Liters)")]
        public double WaterIntakeLiters { get; set; } = 2.0;

        [StringLength(250)]
        public string? Notes { get; set; }
    }
}
