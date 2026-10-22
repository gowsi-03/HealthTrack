using System.ComponentModel.DataAnnotations;
using HealthTrack.Models;

namespace HealthTrack.Models.ViewModels
{
    public class WorkoutPlansViewModel
    {
        public string ClientId { get; set; } = string.Empty;
        public string FullName { get; set; } = "John Doe";
        public string Email { get; set; } = "client@healthtrack.com";
        public string TrainerName { get; set; } = "Alex Henderson";
        public bool HasActivePlan { get; set; } = true;

        // Active Program Banner
        public string ProgramTitle { get; set; } = "Foundation Strength • 8 Weeks";
        public string ProgramDescription { get; set; } = "A progressive full-body program designed to improve strength, mobility and endurance.";
        public int DaysPerWeek { get; set; } = 4;
        public int MinutesPerSession { get; set; } = 45;
        public int TotalExercisesCount { get; set; } = 8;
        public int CompletedExercisesCount { get; set; } = 5;
        public int CompletionPercentage { get; set; } = 62;

        public string CurrentWeekText { get; set; } = "Week 5 of 8 • Stay consistent";

        // Weekly Sessions
        public List<WorkoutSessionItem> WeeklySessions { get; set; } = new();

        // Active Program Exercises List
        public List<WorkoutExercise> Exercises { get; set; } = new();

        // Form for logging a completed session
        public LogWorkoutInputModel LogWorkoutForm { get; set; } = new();
    }

    public class WorkoutSessionItem
    {
        public int Id { get; set; }
        public string DaySchedule { get; set; } = "Today • 5:30 PM";
        public string Title { get; set; } = "Upper body strength";
        public int ExerciseCount { get; set; } = 8;
        public int DurationMinutes { get; set; } = 45;
        public string Intensity { get; set; } = "3 sets • 8-12 reps";
        public string Status { get; set; } = "In progress"; // In progress, Upcoming, Completed
        public bool IsActiveSession { get; set; } = false;
        public List<string> ExerciseNames { get; set; } = new();
    }

    public class LogWorkoutInputModel
    {
        [Required]
        [StringLength(100)]
        [Display(Name = "Workout Session Name")]
        public string WorkoutName { get; set; } = "Upper body strength";

        [Required]
        [Range(10, 300)]
        [Display(Name = "Duration (Minutes)")]
        public int DurationMinutes { get; set; } = 45;

        [Required]
        [Range(50, 3000)]
        [Display(Name = "Calories Burned (kcal)")]
        public int CaloriesBurned { get; set; } = 420;

        [StringLength(250)]
        [Display(Name = "Workout Notes & Performance")]
        public string? Notes { get; set; } = "Completed all sets, increased weight on bench press.";
    }
}
