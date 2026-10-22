using System.ComponentModel.DataAnnotations;
using HealthTrack.Models;

namespace HealthTrack.Models.ViewModels
{
    public class ClientDashboardViewModel
    {
        // Client Info
        public string ClientId { get; set; } = string.Empty;
        public string FullName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public double HeightCm { get; set; } = 175.0;
        public double TargetWeight { get; set; } = 70.0;
        public string FitnessGoal { get; set; } = "General Fitness";
        public string? TrainerName { get; set; }
        public string? TrainerId { get; set; }
        public bool HasAssignedTrainer => !string.IsNullOrEmpty(TrainerId);
        public List<TrainerOption> AvailableTrainers { get; set; } = new();

        // Top 3 Stat Cards
        public double CurrentWeight { get; set; } = 72.4;
        public string WeightTrendText { get; set; } = "-1.2 kg from last month";
        public bool IsWeightTrendPositive { get; set; } = true; // weight loss for fitness goal

        public double CurrentBmi { get; set; } = 22.8;
        public string BmiCategory { get; set; } = "Normal weight";
        public string BmiTrendText { get; set; } = "-0.4 points from last month";

        public int CaloriesBurned { get; set; } = 1842;
        public string CaloriesTrendText { get; set; } = "+12.5% from last month";

        // Weight Progress Graph Data
        public List<string> ChartLabels { get; set; } = new();
        public List<double> ChartWeights { get; set; } = new();
        public string WeightChangeThisMonth { get; set; } = "-1.6% this month";

        // Upcoming Appointment
        public bool HasUpcomingAppointment { get; set; }
        public int? UpcomingAppointmentId { get; set; }
        public string AppointmentDateFormatted { get; set; } = string.Empty;
        public string AppointmentDay { get; set; } = "18";
        public string AppointmentMonth { get; set; } = "APR";
        public string AppointmentTime { get; set; } = "10:30 AM";
        public string AppointmentProvider { get; set; } = "Alex Henderson";
        public string AppointmentType { get; set; } = "Health consultation";
        public string AppointmentStatus { get; set; } = "Confirmed";
        public string? AppointmentNotes { get; set; }

        // Today's Plan
        public int TotalActivitiesCount { get; set; } = 4;
        public int CompletedActivitiesCount { get; set; } = 2;
        public int CompletionPercentage => TotalActivitiesCount > 0 
            ? (int)Math.Round((double)CompletedActivitiesCount / TotalActivitiesCount * 100) 
            : 0;
        public List<DailyPlanItem> TodayPlanItems { get; set; } = new();

        // Active Plans
        public WorkoutPlan? ActiveWorkoutPlan { get; set; }
        public DietPlan? ActiveDietPlan { get; set; }
        public int UnreadNotificationsCount { get; set; } = 0;

        // Quick Action Forms
        public QuickLogMeasurementModel QuickMeasurement { get; set; } = new();
        public QuickBookAppointmentModel QuickBooking { get; set; } = new();
        public QuickLogMealModel QuickMeal { get; set; } = new();
    }

    public class DailyPlanItem
    {
        public int Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public string Subtitle { get; set; } = string.Empty;
        public string TimeLabel { get; set; } = string.Empty;
        public string IconClass { get; set; } = "bi-check2";
        public string Category { get; set; } = "General"; // Hydration, Meal, Workout
        public bool IsCompleted { get; set; }
        public string ActionButtonText { get; set; } = "Start";
        public string? ActionUrl { get; set; }
    }

    public class QuickLogMeasurementModel
    {
        [Required]
        [Range(30, 300)]
        [Display(Name = "Weight (kg)")]
        public double WeightKg { get; set; } = 72.4;

        [Range(0, 5000)]
        [Display(Name = "Calories Burned (kcal)")]
        public int CaloriesBurned { get; set; } = 450;

        [Range(0, 10)]
        [Display(Name = "Water Intake (Liters)")]
        public double WaterIntakeLiters { get; set; } = 2.5;

        [StringLength(200)]
        public string? Notes { get; set; }
    }

    public class QuickBookAppointmentModel
    {
        [Required]
        [DataType(DataType.Date)]
        [Display(Name = "Preferred Date")]
        public DateTime AppointmentDate { get; set; } = DateTime.Today.AddDays(2);

        [Required]
        [Display(Name = "Time Slot")]
        public string TimeSlot { get; set; } = "10:30 AM";

        [StringLength(250)]
        [Display(Name = "Consultation Reason / Notes")]
        public string? Notes { get; set; } = "Routine form check & fitness assessment";
    }

    public class QuickLogMealModel
    {
        [Required]
        [Display(Name = "Meal Timing")]
        public string MealType { get; set; } = "Dinner";

        [Required]
        [StringLength(150)]
        [Display(Name = "Food Description")]
        public string Description { get; set; } = string.Empty;

        [Range(0, 3000)]
        [Display(Name = "Calories")]
        public int Calories { get; set; } = 500;
    }
}
