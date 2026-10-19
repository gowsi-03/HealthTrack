using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HealthTrack.Models
{
    public class WorkoutPlan
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Workout Routine Title")]
        public string Title { get; set; } = string.Empty;

        [StringLength(250)]
        public string? Description { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        [Required]
        public string ClientId { get; set; } = string.Empty;

        [ForeignKey("ClientId")]
        public virtual ApplicationUser? Client { get; set; }

        [Required]
        public string TrainerId { get; set; } = string.Empty;

        [ForeignKey("TrainerId")]
        public virtual ApplicationUser? Trainer { get; set; }

        public virtual ICollection<WorkoutExercise> Exercises { get; set; } = new List<WorkoutExercise>();
    }

    public class WorkoutExercise
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int WorkoutPlanId { get; set; }

        [ForeignKey("WorkoutPlanId")]
        public virtual WorkoutPlan? WorkoutPlan { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Exercise Name")]
        public string Name { get; set; } = string.Empty;

        [Required]
        [StringLength(50)]
        public string Sets { get; set; } = "3 sets";

        [Required]
        [StringLength(50)]
        public string Reps { get; set; } = "10-12 reps";

        public bool IsCompleted { get; set; } = false;
    }
}
