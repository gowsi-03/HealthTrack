using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HealthTrack.Models
{
    public class DietPlan
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Diet Plan Title")]
        public string Title { get; set; } = string.Empty;

        [Range(500, 6000)]
        [Display(Name = "Daily Target Calories (kcal)")]
        public int TargetCalories { get; set; } = 2000;

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        public bool IsActive { get; set; } = true;

        [Required]
        public string ClientId { get; set; } = string.Empty;

        [ForeignKey("ClientId")]
        public virtual ApplicationUser? Client { get; set; }

        public virtual ICollection<MealItem> Meals { get; set; } = new List<MealItem>();
    }

    public class MealItem
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int DietPlanId { get; set; }

        [ForeignKey("DietPlanId")]
        public virtual DietPlan? DietPlan { get; set; }

        [Required]
        [StringLength(50)]
        [Display(Name = "Meal Timing")]
        public string MealType { get; set; } = "Breakfast"; // Breakfast, Lunch, Dinner, Snack

        [Required]
        [StringLength(200)]
        public string Description { get; set; } = string.Empty;

        [Range(0, 3000)]
        public int Calories { get; set; } = 500;
    }
}
