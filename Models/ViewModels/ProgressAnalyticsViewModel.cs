using System.ComponentModel.DataAnnotations;
using HealthTrack.Models;

namespace HealthTrack.Models.ViewModels
{
    public class ProgressAnalyticsViewModel
    {
        public string ClientId { get; set; } = string.Empty;
        public string FullName { get; set; } = "John Doe";
        public string Email { get; set; } = "client@healthtrack.com";
        public int HeightCm { get; set; } = 178;

        // Filter state
        public string SelectedTimeRange { get; set; } = "Last 30 days";
        public string SelectedMetric { get; set; } = "All metrics";

        // 4 KPI Cards
        public string WeightChange { get; set; } = "-3.8 kg";
        public string WeightChangePeriod { get; set; } = "Since Jan 14";
        public string WorkoutCompletionRate { get; set; } = "87%";
        public string WorkoutCompletionChange { get; set; } = "+8% this month";
        public int ActiveMinutes { get; set; } = 742;
        public string ActiveMinutesPeriod { get; set; } = "Last 30 days";
        public string AverageCalories { get; set; } = "2,120";
        public string AverageCaloriesPeriod { get; set; } = "Daily intake";

        // Weight Trend Card
        public double CurrentWeightKg { get; set; } = 72.4;
        public string WeightTrendStatus { get; set; } = "On track";
        public List<string> WeightLabels { get; set; } = new() { "Mar 01", "Mar 08", "Mar 15", "Mar 22", "Mar 29" };
        public List<double> WeightValues { get; set; } = new() { 68.2, 70.4, 73.1, 75.8, 77.4 };

        // Workout Activity Weekly Bars
        public List<string> ActivityDays { get; set; } = new() { "M", "T", "W", "T", "F", "S", "S" };
        public List<int> ActivityPercentages { get; set; } = new() { 65, 80, 70, 90, 90, 90, 100 };

        // Measurement History Table
        public List<MeasurementHistoryItem> MeasurementHistory { get; set; } = new();

        // Form for recording new measurement
        public RecordMeasurementInputModel RecordMeasurementForm { get; set; } = new();
    }

    public class MeasurementHistoryItem
    {
        public int Id { get; set; }
        public DateTime Date { get; set; }
        public string DateText { get; set; } = "Apr 12, 2025";
        public double WeightKg { get; set; } = 72.4;
        public int HeightCm { get; set; } = 178;
        public double Bmi { get; set; } = 22.8;
        public int WaistCm { get; set; } = 82;
        public string Notes { get; set; } = string.Empty;
    }

    public class RecordMeasurementInputModel
    {
        [Required]
        [Range(30, 300)]
        [Display(Name = "Weight (kg)")]
        public double WeightKg { get; set; } = 72.4;

        [Required]
        [Range(100, 250)]
        [Display(Name = "Height (cm)")]
        public int HeightCm { get; set; } = 178;

        [Required]
        [Range(40, 200)]
        [Display(Name = "Waist Circumference (cm)")]
        public int WaistCm { get; set; } = 82;

        [Required]
        [DataType(DataType.Date)]
        [Display(Name = "Date of Measurement")]
        public DateTime MeasurementDate { get; set; } = DateTime.UtcNow;

        [StringLength(200)]
        [Display(Name = "Notes")]
        public string? Notes { get; set; } = "Routine morning biometric check";
    }
}
