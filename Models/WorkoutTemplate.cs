using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HealthTrack.Models
{
    public class WorkoutTemplate
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(120)]
        [Display(Name = "Template Title")]
        public string Title { get; set; } = string.Empty;

        [Required]
        [StringLength(80)]
        public string Category { get; set; } = "Strength & Mobility";

        [Range(1, 52)]
        public int DurationWeeks { get; set; } = 8;

        [Range(1, 7)]
        public int DaysPerWeek { get; set; } = 4;

        [Range(10, 180)]
        public int MinutesPerSession { get; set; } = 45;

        [StringLength(500)]
        public string? Description { get; set; }

        [StringLength(50)]
        public string BadgeClass { get; set; } = "badge-teal";

        public string? ExercisesText { get; set; }

        public string? TrainerId { get; set; }

        [ForeignKey("TrainerId")]
        public virtual ApplicationUser? Trainer { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}
