using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HealthTrack.Models
{
    public class DietTemplate
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(120)]
        [Display(Name = "Template Title")]
        public string Title { get; set; } = string.Empty;

        [Required]
        [StringLength(80)]
        public string Category { get; set; } = "Balanced Nutrition";

        [Range(500, 6000)]
        public int DailyCalories { get; set; } = 2000;

        [Range(20, 400)]
        public int ProteinGrams { get; set; } = 120;

        [Range(1, 8)]
        public int MealsPerDay { get; set; } = 4;

        [StringLength(500)]
        public string? Description { get; set; }

        [StringLength(50)]
        public string BadgeClass { get; set; } = "badge-teal";

        public string? MealsText { get; set; }

        public string? TrainerId { get; set; }

        [ForeignKey("TrainerId")]
        public virtual ApplicationUser? Trainer { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}
