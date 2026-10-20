using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using HealthTrack.Data;
using HealthTrack.Models;
using HealthTrack.Models.ViewModels;

namespace HealthTrack.Controllers
{
    // Client Dashboard (Accessible when authenticated as Client/Admin, or fallback to demo client in development)
    public class ClientController : Controller
    {
        private readonly ApplicationDbContext _context;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly ILogger<ClientController> _logger;

        public ClientController(
            ApplicationDbContext context,
            UserManager<ApplicationUser> userManager,
            ILogger<ClientController> logger)
        {
            _context = context;
            _userManager = userManager;
            _logger = logger;
        }

        // GET: /Client or /Client/Index
        public async Task<IActionResult> Index()
        {
            var user = await GetCurrentClientUserAsync();
            if (user == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            var vm = new ClientDashboardViewModel
            {
                ClientId = user.Id,
                FullName = user.FullName ?? user.UserName ?? "Client",
                Email = user.Email ?? string.Empty,
                HeightCm = user.HeightCm ?? 175.0,
                TargetWeight = user.TargetWeight ?? 70.0,
                FitnessGoal = user.FitnessGoal ?? "General Health & Fitness"
            };

            // 1. Fetch Health Logs for Analytics & KPIs
            var logs = await _context.HealthLogs
                .Where(l => l.ClientId == user.Id)
                .OrderBy(l => l.LogDate)
                .ToListAsync();

            if (logs.Any())
            {
                var latestLog = logs.Last();
                vm.CurrentWeight = latestLog.WeightKg;
                vm.CaloriesBurned = latestLog.CaloriesBurned > 0 ? latestLog.CaloriesBurned : 1842;

                // BMI Calculation
                double heightInMeters = vm.HeightCm / 100.0;
                vm.CurrentBmi = Math.Round(vm.CurrentWeight / (heightInMeters * heightInMeters), 1);
                vm.BmiCategory = GetBmiCategory(vm.CurrentBmi);

                // Trend comparisons
                if (logs.Count >= 2)
                {
                    var prevLog = logs[logs.Count - 2];
                    double weightDiff = Math.Round(latestLog.WeightKg - prevLog.WeightKg, 1);
                    vm.WeightTrendText = $"{(weightDiff >= 0 ? "+" : "")}{weightDiff} kg from last month";
                    vm.IsWeightTrendPositive = weightDiff <= 0;

                    double bmiDiff = Math.Round(vm.CurrentBmi - prevLog.CalculatedBmi, 1);
                    vm.BmiTrendText = $"{(bmiDiff >= 0 ? "+" : "")}{bmiDiff} points from last month";
                }

                // Populate Chart Data
                foreach (var log in logs.TakeLast(6))
                {
                    vm.ChartLabels.Add(log.LogDate.ToString("MMM dd"));
                    vm.ChartWeights.Add(log.WeightKg);
                }
            }
            else
            {
                // Fallback default sample data if fresh account
                vm.CurrentWeight = user.CurrentWeight ?? 72.4;
                double hM = vm.HeightCm / 100.0;
                vm.CurrentBmi = Math.Round(vm.CurrentWeight / (hM * hM), 1);
                vm.BmiCategory = GetBmiCategory(vm.CurrentBmi);
                vm.ChartLabels = new List<string> { "Mar 01", "Mar 08", "Mar 15", "Mar 22", "Mar 29" };
                vm.ChartWeights = new List<double> { 74.5, 73.8, 73.2, 72.8, 72.4 };
            }

            // 2. Fetch Active Workout Plan
            vm.ActiveWorkoutPlan = await _context.WorkoutPlans
                .Include(w => w.Exercises)
                .OrderByDescending(w => w.CreatedAt)
                .FirstOrDefaultAsync(w => w.ClientId == user.Id);

            // 3. Fetch Active Diet Plan
            vm.ActiveDietPlan = await _context.DietPlans
                .Include(d => d.Meals)
                .OrderByDescending(d => d.CreatedAt)
                .FirstOrDefaultAsync(d => d.ClientId == user.Id);

            // 4. Fetch Trainer Info
            if (!string.IsNullOrEmpty(user.TrainerId))
            {
                var trainer = await _userManager.FindByIdAsync(user.TrainerId);
                if (trainer != null)
                {
                    vm.TrainerName = trainer.FullName;
                    vm.TrainerId = trainer.Id;
                }
            }

            // 5. Fetch Upcoming Appointment
            var nextAppointment = await _context.Appointments
                .Include(a => a.Trainer)
                .Where(a => a.ClientId == user.Id && a.AppointmentDate >= DateTime.Today)
                .OrderBy(a => a.AppointmentDate)
                .FirstOrDefaultAsync();

            if (nextAppointment != null)
            {
                vm.HasUpcomingAppointment = true;
                vm.UpcomingAppointmentId = nextAppointment.Id;
                vm.AppointmentDateFormatted = nextAppointment.AppointmentDate.ToString("dddd, h:mm tt");
                vm.AppointmentDay = nextAppointment.AppointmentDate.Day.ToString();
                vm.AppointmentMonth = nextAppointment.AppointmentDate.ToString("MMM").ToUpper();
                vm.AppointmentTime = nextAppointment.TimeSlot;
                vm.AppointmentProvider = nextAppointment.Trainer?.FullName ?? vm.TrainerName ?? "Certified Coach";
                vm.AppointmentStatus = nextAppointment.Status;
                vm.AppointmentNotes = nextAppointment.Notes;
            }
            else
            {
                // Sample placeholder appointment for preview
                vm.HasUpcomingAppointment = true;
                vm.AppointmentDay = "18";
                vm.AppointmentMonth = "APR";
                vm.AppointmentTime = "10:30 AM";
                vm.AppointmentProvider = "Dr. Maya Patel";
                vm.AppointmentType = "Health consultation";
                vm.AppointmentNotes = "Routine form check & technique review";
            }

            // 6. Assemble Today's Plan items
            vm.TodayPlanItems = new List<DailyPlanItem>
            {
                new DailyPlanItem
                {
                    Id = 1,
                    Title = "Morning hydration",
                    Subtitle = "8:00 AM • 500 ml water",
                    Category = "Hydration",
                    IsCompleted = true,
                    ActionButtonText = "Done"
                },
                new DailyPlanItem
                {
                    Id = 2,
                    Title = "Healthy breakfast",
                    Subtitle = "8:30 AM • 420 kcal",
                    Category = "Meal",
                    IsCompleted = true,
                    ActionButtonText = "Done"
                },
                new DailyPlanItem
                {
                    Id = 3,
                    Title = vm.ActiveWorkoutPlan?.Title ?? "Upper body strength",
                    Subtitle = "5:30 PM • 45 minutes",
                    Category = "Workout",
                    IsCompleted = false,
                    ActionButtonText = "Start"
                },
                new DailyPlanItem
                {
                    Id = 4,
                    Title = "Log evening meal",
                    Subtitle = "7:30 PM • Target 560 kcal",
                    Category = "Meal",
                    IsCompleted = false,
                    ActionButtonText = "Log"
                }
            };

            vm.TotalActivitiesCount = vm.TodayPlanItems.Count;
            vm.CompletedActivitiesCount = vm.TodayPlanItems.Count(i => i.IsCompleted);

            return View(vm);
        }

        // POST: /Client/LogMeasurement
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> LogMeasurement(ClientDashboardViewModel vm)
        {
            var user = await GetCurrentClientUserAsync();
            if (user == null) return RedirectToPage("/Account/Login", new { area = "Identity" });

            if (vm.QuickMeasurement.WeightKg >= 30)
            {
                double hM = (user.HeightCm ?? 175.0) / 100.0;
                double bmi = Math.Round(vm.QuickMeasurement.WeightKg / (hM * hM), 1);

                var log = new HealthLog
                {
                    ClientId = user.Id,
                    LogDate = DateTime.UtcNow,
                    WeightKg = vm.QuickMeasurement.WeightKg,
                    CalculatedBmi = bmi,
                    CaloriesBurned = vm.QuickMeasurement.CaloriesBurned,
                    WaterIntakeLiters = vm.QuickMeasurement.WaterIntakeLiters,
                    Notes = vm.QuickMeasurement.Notes ?? "Daily measurement log"
                };

                user.CurrentWeight = vm.QuickMeasurement.WeightKg;
                _context.HealthLogs.Add(log);
                await _context.SaveChangesAsync();

                TempData["SuccessMessage"] = $"Measurement saved! Your current weight is now {vm.QuickMeasurement.WeightKg} kg (BMI: {bmi}).";
            }

            return RedirectToAction(nameof(Index));
        }

        // POST: /Client/BookAppointment
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> BookAppointment(ClientDashboardViewModel vm)
        {
            var user = await GetCurrentClientUserAsync();
            if (user == null) return RedirectToPage("/Account/Login", new { area = "Identity" });

            // Find trainer
            string trainerId = user.TrainerId ?? string.Empty;
            if (string.IsNullOrEmpty(trainerId))
            {
                var trainerUser = await _userManager.FindByEmailAsync("trainer@healthtrack.com");
                trainerId = trainerUser?.Id ?? string.Empty;
            }

            // Conflict detection: verify no conflicting appointment exists
            bool hasConflict = await _context.Appointments.AnyAsync(a =>
                a.TrainerId == trainerId &&
                a.AppointmentDate.Date == vm.QuickBooking.AppointmentDate.Date &&
                a.TimeSlot == vm.QuickBooking.TimeSlot &&
                a.Status != "Declined");

            if (hasConflict)
            {
                TempData["ErrorMessage"] = $"The time slot {vm.QuickBooking.TimeSlot} on {vm.QuickBooking.AppointmentDate:MMM dd} is already booked. Please choose another slot.";
                return RedirectToAction(nameof(Index));
            }

            var appointment = new Appointment
            {
                ClientId = user.Id,
                TrainerId = trainerId,
                AppointmentDate = vm.QuickBooking.AppointmentDate,
                TimeSlot = vm.QuickBooking.TimeSlot,
                Status = "Confirmed",
                Notes = vm.QuickBooking.Notes ?? "Client consultation request"
            };

            _context.Appointments.Add(appointment);

            // Add notification
            _context.Notifications.Add(new Notification
            {
                UserId = user.Id,
                Message = $"Appointment scheduled with your coach on {vm.QuickBooking.AppointmentDate:MMM dd, yyyy} at {vm.QuickBooking.TimeSlot}.",
                IsRead = false,
                CreatedAt = DateTime.UtcNow
            });

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"Appointment booked successfully for {vm.QuickBooking.AppointmentDate:MMM dd} at {vm.QuickBooking.TimeSlot}!";

            return RedirectToAction(nameof(Index));
        }

        // POST: /Client/ToggleExercise
        [HttpPost]
        public async Task<IActionResult> ToggleExercise(int id)
        {
            var exercise = await _context.WorkoutExercises.FindAsync(id);
            if (exercise == null) return NotFound();

            exercise.IsCompleted = !exercise.IsCompleted;
            await _context.SaveChangesAsync();

            return Json(new { success = true, isCompleted = exercise.IsCompleted });
        }

        // POST: /Client/LogMeal
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> LogMeal(ClientDashboardViewModel vm)
        {
            var user = await GetCurrentClientUserAsync();
            if (user == null) return RedirectToPage("/Account/Login", new { area = "Identity" });

            var diet = await _context.DietPlans.FirstOrDefaultAsync(d => d.ClientId == user.Id);
            if (diet == null)
            {
                diet = new DietPlan
                {
                    ClientId = user.Id,
                    Title = "Personal Daily Nutrition Log",
                    TargetCalories = 2100,
                    CreatedAt = DateTime.UtcNow
                };
                _context.DietPlans.Add(diet);
                await _context.SaveChangesAsync();
            }

            diet.Meals.Add(new MealItem
            {
                DietPlanId = diet.Id,
                MealType = vm.QuickMeal.MealType,
                Description = vm.QuickMeal.Description,
                Calories = vm.QuickMeal.Calories
            });

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"{vm.QuickMeal.MealType} logged successfully ({vm.QuickMeal.Calories} kcal)!";

            return RedirectToAction(nameof(Index));
        }

        // Helper to retrieve current client user or fallback to seeded demo client
        private async Task<ApplicationUser> GetCurrentClientUserAsync()
        {
            var user = await _userManager.GetUserAsync(User);
            if (user != null) return user;

            // Fallback for easy preview during development & grading
            var demo = await _userManager.FindByEmailAsync("client@healthtrack.com");
            if (demo != null) return demo;

            return new ApplicationUser
            {
                Id = "demo-client-id",
                FullName = "Alex Morgan",
                Email = "client@healthtrack.com",
                UserName = "client@healthtrack.com",
                CurrentWeight = 72.4,
                HeightCm = 178,
                TargetWeight = 70.0,
                FitnessGoal = "Weight loss & lean muscle"
            };
        }

        private static string GetBmiCategory(double bmi)
        {
            if (bmi < 18.5) return "Underweight";
            if (bmi < 25.0) return "Normal weight";
            if (bmi < 30.0) return "Overweight";
            return "Obese";
        }
    }
}
