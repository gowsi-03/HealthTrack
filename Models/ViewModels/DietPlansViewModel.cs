using System.ComponentModel.DataAnnotations;
using HealthTrack.Models;

namespace HealthTrack.Models.ViewModels
{
    public class DietPlansViewModel
    {
        public string ClientId { get; set; } = string.Empty;
        public string FullName { get; set; } = "John Doe";
        public string Email { get; set; } = "client@healthtrack.com";
        public string TrainerName { get; set; } = "Alex Henderson";

        // Active Banner
        public string PlanTitle { get; set; } = "Balanced Performance Plan";
        public string PlanDescription { get; set; } = "Nutrient-dense meals to support training, recovery and steady energy.";
        public int DailyTargetCalories { get; set; } = 2150;
        public int TargetProteinGrams { get; set; } = 120;
        public int MealsPerDay { get; set; } = 4;

        // Schedule
        public string ScheduleDateText { get; set; } = string.Empty;
        public int LoggedMealsCount { get; set; } = 2;
        public int TotalMealsCount { get; set; } = 4;
        public List<MealScheduleItem> ScheduledMeals { get; set; } = new();

        // Form for logging a meal
        public LogMealEntryInputModel LogMealForm { get; set; } = new();
    }

    public class MealScheduleItem
    {
        public int Id { get; set; }
        public string MealTime { get; set; } = "8:30 AM";
        public string MealType { get; set; } = "Breakfast"; // Breakfast, Lunch, Afternoon snack, Dinner
        public string Description { get; set; } = "Greek yogurt, berries & almond granola";
        public int Calories { get; set; } = 420;
        public int ProteinGrams { get; set; } = 24;
        public int CarbsGrams { get; set; } = 50;
        public int FatsGrams { get; set; } = 12;
        public string Ingredients { get; set; } = string.Empty;
        public bool IsLogged { get; set; } = false;
        public string Status => IsLogged ? "Logged" : "Upcoming";
    }

    public class LogMealEntryInputModel
    {
        [Required]
        [Display(Name = "Meal Timing")]
        public string MealType { get; set; } = "Lunch";

        [Required]
        [StringLength(150)]
        [Display(Name = "Meal Description")]
        public string Description { get; set; } = "Grilled chicken quinoa power bowl";

        [Required]
        [Range(50, 3000)]
        [Display(Name = "Calories (kcal)")]
        public int Calories { get; set; } = 610;

        [Range(0, 300)]
        [Display(Name = "Protein (g)")]
        public int ProteinGrams { get; set; } = 35;
    }
}
