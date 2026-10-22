using System;
using System.Collections.Generic;

namespace HealthTrack.Models.ViewModels
{
    public class TrainerReportsViewModel
    {
        // Trainer Info
        public string TrainerName { get; set; } = "Maya Patel";
        public string TrainerEmail { get; set; } = "maya.patel@healthtrack.com";
        public string TrainerInitials { get; set; } = "AM";
        public int UnreadNotificationsCount { get; set; } = 2;

        // Filter Selections
        public string SelectedClientId { get; set; } = "c-alex";
        public string SelectedClientName { get; set; } = "Alex Morgan";
        public string SelectedMetric { get; set; } = "All metrics";
        public string SelectedTimeframe { get; set; } = "Monthly";

        // Client options for dropdown
        public List<TrainerClientFilterOption> Clients { get; set; } = new();

        // 4 Key KPI Metrics (Matches reference mockup 1)
        public string WeightChange { get; set; } = "-3.8 kg";
        public string WeightChangeSubtext { get; set; } = "Since Jan 14";
        public string WorkoutCompletionRate { get; set; } = "87%";
        public string WorkoutCompletionSubtext { get; set; } = "+6% this month";
        public int ActiveMinutes { get; set; } = 742;
        public string ActiveMinutesSubtext { get; set; } = "Last 30 days";
        public string AverageCalories { get; set; } = "2,120";
        public string AverageCaloriesSubtext { get; set; } = "Daily intake";

        // Weight Trend Line/Area Chart (Matches reference mockup 1)
        public double CurrentWeightKg { get; set; } = 72.4;
        public string WeightTrendStatus { get; set; } = "On track";
        public List<string> WeightLabels { get; set; } = new() { "Mar 01", "Mar 08", "Mar 15", "Mar 22", "Mar 29" };
        public List<double> WeightValues { get; set; } = new() { 66.5, 70.8, 73.2, 76.5, 78.4 };

        // Workout Activity Weekly Bars (Matches reference mockup 1)
        public List<string> ActivityDays { get; set; } = new() { "M", "T", "W", "T", "F", "S", "S" };
        public List<int> ActivityPercentages { get; set; } = new() { 65, 80, 72, 88, 85, 88, 96 };

        // Measurement History Table (Matches reference mockup 2)
        public List<TrainerMeasurementHistoryItem> MeasurementHistory { get; set; } = new();
    }

    public class TrainerClientFilterOption
    {
        public string Id { get; set; } = string.Empty;
        public string Name { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Initials { get; set; } = string.Empty;
    }

    public class TrainerMeasurementHistoryItem
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
}
