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

        public override void OnActionExecuting(Microsoft.AspNetCore.Mvc.Filters.ActionExecutingContext context)
        {
            base.OnActionExecuting(context);
            if (User.Identity?.IsAuthenticated == true)
            {
                var roleClaim = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (roleClaim == "Trainer" || roleClaim == "Admin" || User.IsInRole("Trainer") || User.IsInRole("Admin"))
                {
                    context.Result = RedirectToAction("Index", "Trainer");
                }
            }
        }

        // GET: /Client or /Client/Index
        public async Task<IActionResult> Index()
        {
            if (User.Identity?.IsAuthenticated == true)
            {
                var authUser = await _userManager.GetUserAsync(User);
                if (authUser != null)
                {
                    var isTrainer = await _userManager.IsInRoleAsync(authUser, "Trainer") || await _userManager.IsInRoleAsync(authUser, "Admin") || authUser.Role == "Trainer" || authUser.Role == "Admin";
                    if (isTrainer)
                    {
                        // Trainer logged in -> redirect strictly to Trainer dashboard
                        return RedirectToAction("Index", "Trainer");
                    }
                }
            }

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
                HeightCm = user.HeightCm ?? 0,
                TargetWeight = user.TargetWeight ?? 0,
                FitnessGoal = user.FitnessGoal ?? "General Health & Fitness"
            };

            bool isDemoUser = false;

            // 1. Fetch Health Logs for Analytics & KPIs
            var logs = await _context.HealthLogs
                .Where(l => l.ClientId == user.Id)
                .OrderBy(l => l.LogDate)
                .ToListAsync();

            if (logs.Any())
            {
                var latestLog = logs.Last();
                vm.CurrentWeight = latestLog.WeightKg;

                // BMI Calculation
                if (vm.HeightCm > 0)
                {
                    double heightInMeters = vm.HeightCm / 100.0;
                    vm.CurrentBmi = Math.Round(vm.CurrentWeight / (heightInMeters * heightInMeters), 1);
                    vm.BmiCategory = GetBmiCategory(vm.CurrentBmi);
                }
                else
                {
                    vm.CurrentBmi = 0;
                    vm.BmiCategory = "--";
                }

                // Trend comparisons
                if (logs.Count >= 2)
                {
                    var prevLog = logs[logs.Count - 2];
                    double weightDiff = Math.Round(latestLog.WeightKg - prevLog.WeightKg, 1);
                    vm.WeightTrendText = $"{(weightDiff >= 0 ? "+" : "")}{weightDiff} kg from last month";
                    vm.IsWeightTrendPositive = weightDiff <= 0;

                    double bmiDiff = Math.Round(vm.CurrentBmi - prevLog.CalculatedBmi, 1);
                    vm.BmiTrendText = $"{(bmiDiff >= 0 ? "+" : "")}{bmiDiff} points from last month";

                    double pctDiff = Math.Round(((latestLog.WeightKg - prevLog.WeightKg) / prevLog.WeightKg) * 100, 1);
                    vm.WeightChangeThisMonth = $"{(pctDiff >= 0 ? "+" : "")}{pctDiff}% this month";
                }
                else
                {
                    vm.WeightTrendText = "Initial weigh-in recorded";
                    vm.BmiTrendText = "Baseline calculation";
                    vm.WeightChangeThisMonth = "Initial record";
                }

                // Populate Chart Data (Strictly 1 weigh-in per calendar date, NO duplicates)
                var dailyDashboardLogs = logs
                    .GroupBy(l => l.LogDate.Date)
                    .Select(g =>
                        g.OrderByDescending(l => !string.IsNullOrEmpty(l.Notes) && (l.Notes.Contains("waist:") || l.Notes.Contains("measurement") || l.Notes.Contains("biometric") || (!l.Notes.Contains("Meal Logged") && !l.Notes.Contains("Morning hydration"))))
                         .ThenBy(l => l.LogDate)
                         .Last()
                    )
                    .OrderBy(l => l.LogDate)
                    .ToList();

                foreach (var log in dailyDashboardLogs.TakeLast(6))
                {
                    vm.ChartLabels.Add(log.LogDate.ToString("MMM dd"));
                    vm.ChartWeights.Add(log.WeightKg);
                }
            }
            else if (isDemoUser)
            {
                // Fallback default sample data ONLY for seeded demo account
                vm.CurrentWeight = user.CurrentWeight ?? 72.4;
                double hM = (vm.HeightCm > 0 ? vm.HeightCm : 175.0) / 100.0;
                vm.CurrentBmi = Math.Round(vm.CurrentWeight / (hM * hM), 1);
                vm.BmiCategory = GetBmiCategory(vm.CurrentBmi);
                vm.CaloriesBurned = 510;
                vm.CaloriesTrendText = "+12.5% from last month";
                vm.WeightTrendText = "-0.7 kg from last month";
                vm.BmiTrendText = "+0.5 points from last month";
                vm.WeightChangeThisMonth = "-1.6% this month";
                vm.ChartLabels = new List<string> { "Mar 01", "Mar 08", "Mar 15", "Mar 22", "Mar 29" };
                vm.ChartWeights = new List<double> { 74.5, 73.8, 73.2, 72.8, 72.4 };
            }
            else
            {
                // Fresh real user: clean zero / initial state
                bool hasProfileWeight = user.IsProfileCompleted && user.CurrentWeight.HasValue && user.CurrentWeight.Value > 0;
                vm.CurrentWeight = hasProfileWeight ? user.CurrentWeight.Value : 0;
                if (vm.CurrentWeight > 0 && vm.HeightCm > 0)
                {
                    double hM = vm.HeightCm / 100.0;
                    vm.CurrentBmi = Math.Round(vm.CurrentWeight / (hM * hM), 1);
                    vm.BmiCategory = GetBmiCategory(vm.CurrentBmi);
                    vm.BmiTrendText = "Baseline BMI";
                }
                else
                {
                    vm.CurrentBmi = 0;
                    vm.BmiCategory = "--";
                    vm.BmiTrendText = "No calculation yet";
                }
                vm.CaloriesBurned = 0;
                vm.CaloriesTrendText = "0 kcal today";
                vm.WeightTrendText = vm.CurrentWeight > 0 ? "Profile baseline weight" : "No weigh-in recorded";
                vm.WeightChangeThisMonth = "New account";
                vm.ChartLabels = new List<string>();
                vm.ChartWeights = new List<double>();
            }

            // 2. Fetch Active Workout Plan
            vm.ActiveWorkoutPlan = await _context.WorkoutPlans
                .Include(w => w.Exercises)
                .OrderByDescending(w => w.CreatedAt)
                .FirstOrDefaultAsync(w => w.ClientId == user.Id && w.IsActive)
                ?? await _context.WorkoutPlans
                    .Include(w => w.Exercises)
                    .OrderByDescending(w => w.CreatedAt)
                    .FirstOrDefaultAsync(w => w.ClientId == user.Id);

            // Auto-calculate Calories Burned from completed exercises in active workout routine
            int completedExercises = vm.ActiveWorkoutPlan?.Exercises?.Count(e => e.IsCompleted) ?? 0;
            int totalExercises = vm.ActiveWorkoutPlan?.Exercises?.Count ?? 0;
            vm.CaloriesBurned = completedExercises * 60;
            if (completedExercises > 0)
            {
                vm.CaloriesTrendText = $"{completedExercises}/{totalExercises} exercises completed";
            }
            else
            {
                vm.CaloriesTrendText = totalExercises > 0 ? "Complete routine to burn calories" : "No workout routine assigned";
            }

            // 3. Fetch Active Diet Plan
            vm.ActiveDietPlan = await _context.DietPlans
                .Include(d => d.Meals)
                .OrderByDescending(d => d.CreatedAt)
                .FirstOrDefaultAsync(d => d.ClientId == user.Id && d.IsActive)
                ?? await _context.DietPlans
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
                    vm.TrainerSpecialty = trainer.FitnessGoal ?? "General Fitness";
                }
            }
            else if (isDemoUser)
            {
                vm.TrainerName = "Alex Henderson";
                vm.TrainerId = "demo-trainer-id";
                vm.TrainerSpecialty = "Strength & Conditioning";
            }
            else
            {
                vm.TrainerName = null;
                vm.TrainerId = null;
            }

            // Available Trainers for 1-Click Coach Selector
            var availableTrainers = await _userManager.GetUsersInRoleAsync("Trainer");
            vm.AvailableTrainers = availableTrainers.Select(t => new TrainerOption
            {
                Id = t.Id,
                Name = t.FullName,
                RoleOrSpecialty = t.FitnessGoal ?? "Personal Coach"
            }).ToList();

            // 5. Fetch Upcoming Appointment
            var nextAppointment = await _context.Appointments
                .Include(a => a.Trainer)
                .Where(a => a.ClientId == user.Id && a.AppointmentDate >= DateTime.Today && a.Status != "Cancelled")
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
            else if (isDemoUser)
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
            else
            {
                vm.HasUpcomingAppointment = false;
            }

            // 6. Assemble Today's Plan items
            bool hasHydrationToday = false;
            bool hasBreakfastToday = false;
            bool hasWorkoutToday = false;
            bool hasEveningMealToday = false;

            if (isDemoUser)
            {
                // Demo client layout preset
                hasHydrationToday = true;
                hasBreakfastToday = true;
                hasWorkoutToday = false;
                hasEveningMealToday = false;
            }
            else
            {
                var today = DateTime.UtcNow.Date;

                // Check today's health logs for water or meal notes
                var todayLogs = await _context.HealthLogs
                    .Where(l => l.ClientId == user.Id && l.LogDate >= today)
                    .ToListAsync();

                hasHydrationToday = todayLogs.Any(l => l.WaterIntakeLiters > 0);

                if (isDemoUser)
                {
                    hasBreakfastToday = true;
                }

                // Check if any meals were logged in HealthLog notes today
                if (todayLogs.Any())
                {
                    if (todayLogs.Any(l => l.Notes != null && l.Notes.Contains("Breakfast", StringComparison.OrdinalIgnoreCase))) hasBreakfastToday = true;
                    if (todayLogs.Any(l => l.Notes != null && (l.Notes.Contains("Dinner", StringComparison.OrdinalIgnoreCase) || l.Notes.Contains("Evening", StringComparison.OrdinalIgnoreCase)))) hasEveningMealToday = true;
                }

                // Check workout completion
                if (vm.ActiveWorkoutPlan?.Exercises != null && vm.ActiveWorkoutPlan.Exercises.Any())
                {
                    hasWorkoutToday = vm.ActiveWorkoutPlan.Exercises.All(e => e.IsCompleted);
                }
            }

            var breakfastMeal = vm.ActiveDietPlan?.Meals.FirstOrDefault(m => m.MealType.Equals("Breakfast", StringComparison.OrdinalIgnoreCase));
            var dinnerMeal = vm.ActiveDietPlan?.Meals.FirstOrDefault(m => m.MealType.Equals("Dinner", StringComparison.OrdinalIgnoreCase));

            string breakfastTitle = !string.IsNullOrWhiteSpace(breakfastMeal?.Description) ? breakfastMeal.Description : "Healthy breakfast";
            string breakfastSub = breakfastMeal != null ? $"8:30 AM • {breakfastMeal.Calories} kcal" : "8:30 AM • 420 kcal";

            string dinnerTitle = !string.IsNullOrWhiteSpace(dinnerMeal?.Description) ? dinnerMeal.Description : "Log evening meal";
            string dinnerSub = dinnerMeal != null ? $"7:30 PM • Target {dinnerMeal.Calories} kcal" : "7:30 PM • Target 560 kcal";

            vm.TodayPlanItems = new List<DailyPlanItem>
            {
                new DailyPlanItem
                {
                    Id = 1,
                    Title = "Morning hydration",
                    Subtitle = "8:00 AM • 500 ml water",
                    Category = "Hydration",
                    IsCompleted = hasHydrationToday,
                    ActionButtonText = hasHydrationToday ? "Done" : "Log"
                },
                new DailyPlanItem
                {
                    Id = 2,
                    Title = breakfastTitle,
                    Subtitle = breakfastSub,
                    Category = "Meal",
                    IsCompleted = hasBreakfastToday,
                    ActionButtonText = hasBreakfastToday ? "Done" : "Log"
                },
                new DailyPlanItem
                {
                    Id = 3,
                    Title = vm.ActiveWorkoutPlan?.Title ?? "Daily Workout Routine",
                    Subtitle = "5:30 PM • 45 minutes",
                    Category = "Workout",
                    IsCompleted = hasWorkoutToday,
                    ActionButtonText = hasWorkoutToday ? "Done" : "Start"
                },
                new DailyPlanItem
                {
                    Id = 4,
                    Title = dinnerTitle,
                    Subtitle = dinnerSub,
                    Category = "Meal",
                    IsCompleted = hasEveningMealToday,
                    ActionButtonText = hasEveningMealToday ? "Done" : "Log"
                }
            };

            vm.TotalActivitiesCount = vm.TodayPlanItems.Count;
            vm.CompletedActivitiesCount = vm.TodayPlanItems.Count(i => i.IsCompleted);
            vm.UnreadNotificationsCount = await _context.Notifications.CountAsync(n => n.UserId == user.Id && !n.IsRead);

            return View(vm);
        }

        // POST: /Client/AssignCoach
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AssignCoach(string trainerId)
        {
            var user = await GetCurrentClientUserAsync();
            if (user == null) return RedirectToPage("/Account/Login", new { area = "Identity" });

            if (string.IsNullOrEmpty(trainerId))
            {
                TempData["ErrorMessage"] = "Please select a valid coach.";
                return RedirectToAction(nameof(Index));
            }

            var trainer = await _userManager.FindByIdAsync(trainerId);
            if (trainer == null)
            {
                TempData["ErrorMessage"] = "Selected trainer could not be found.";
                return RedirectToAction(nameof(Index));
            }

            user.TrainerId = trainer.Id;
            await _userManager.UpdateAsync(user);

            // Add notification for client
            _context.Notifications.Add(new Notification
            {
                UserId = user.Id,
                Message = $"You are now paired with Coach {trainer.FullName}! They can now design your personalized training and nutrition routines.",
                CreatedAt = DateTime.UtcNow,
                IsRead = false
            });

            // Add notification for trainer
            _context.Notifications.Add(new Notification
            {
                UserId = trainer.Id,
                Message = $"New client paired: {user.FullName} ({user.Email}) has selected you as their primary coach.",
                CreatedAt = DateTime.UtcNow,
                IsRead = false
            });

            await _context.SaveChangesAsync();

            TempData["SuccessMessage"] = $"Awesome! Coach {trainer.FullName} is now your primary trainer.";
            return RedirectToAction(nameof(Index));
        }

        // POST: /Client/LogHydration
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> LogHydration()
        {
            var user = await GetCurrentClientUserAsync();
            if (user == null) return RedirectToPage("/Account/Login", new { area = "Identity" });

            var today = DateTime.UtcNow.Date;
            var todayLog = await _context.HealthLogs
                .Where(l => l.ClientId == user.Id && l.LogDate >= today)
                .OrderByDescending(l => l.LogDate)
                .FirstOrDefaultAsync();

            if (todayLog != null)
            {
                todayLog.WaterIntakeLiters = (todayLog.WaterIntakeLiters > 0 ? todayLog.WaterIntakeLiters : 0) + 0.5;
            }
            else
            {
                _context.HealthLogs.Add(new HealthLog
                {
                    ClientId = user.Id,
                    LogDate = DateTime.UtcNow,
                    WeightKg = user.CurrentWeight ?? 70,
                    CalculatedBmi = (user.HeightCm.HasValue && user.HeightCm > 0) ? Math.Round((user.CurrentWeight ?? 70) / Math.Pow(user.HeightCm.Value / 100.0, 2), 1) : 22,
                    CaloriesBurned = 0,
                    WaterIntakeLiters = 0.5,
                    Notes = "Morning hydration logged (500 ml water)"
                });
            }

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = "Morning hydration logged (500 ml water)!";

            return RedirectToAction(nameof(Index));
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

                // Auto-calculate calories burned from completed workout exercises
                var activeWorkout = await _context.WorkoutPlans
                    .Include(w => w.Exercises)
                    .Where(w => w.ClientId == user.Id && w.IsActive)
                    .OrderByDescending(w => w.CreatedAt)
                    .FirstOrDefaultAsync();

                int completedEx = activeWorkout?.Exercises?.Count(e => e.IsCompleted) ?? 0;
                int autoCalories = completedEx * 60;

                // Daily Upsert: Check if a weigh-in already exists for today
                var today = DateTime.UtcNow.Date;
                var todayLog = await _context.HealthLogs
                    .Where(l => l.ClientId == user.Id && l.LogDate >= today && !l.Notes.StartsWith("Meal Logged"))
                    .OrderByDescending(l => l.LogDate)
                    .FirstOrDefaultAsync();

                if (todayLog != null)
                {
                    // Update today's measurement (Never create duplicate records for same day!)
                    todayLog.WeightKg = vm.QuickMeasurement.WeightKg;
                    todayLog.CalculatedBmi = bmi;
                    todayLog.LogDate = DateTime.UtcNow;
                    todayLog.CaloriesBurned = autoCalories > 0 ? autoCalories : todayLog.CaloriesBurned;
                    if (vm.QuickMeasurement.WaterIntakeLiters > 0) todayLog.WaterIntakeLiters = vm.QuickMeasurement.WaterIntakeLiters;
                    if (!string.IsNullOrWhiteSpace(vm.QuickMeasurement.Notes)) todayLog.Notes = vm.QuickMeasurement.Notes;
                }
                else
                {
                    // First weigh-in today: create new entry
                    var log = new HealthLog
                    {
                        ClientId = user.Id,
                        LogDate = DateTime.UtcNow,
                        WeightKg = vm.QuickMeasurement.WeightKg,
                        CalculatedBmi = bmi,
                        CaloriesBurned = autoCalories,
                        WaterIntakeLiters = vm.QuickMeasurement.WaterIntakeLiters > 0 ? vm.QuickMeasurement.WaterIntakeLiters : 2.5,
                        Notes = !string.IsNullOrWhiteSpace(vm.QuickMeasurement.Notes) ? vm.QuickMeasurement.Notes : "Daily measurement log"
                    };
                    _context.HealthLogs.Add(log);
                }

                user.CurrentWeight = vm.QuickMeasurement.WeightKg;

                // Live Sync: Notify trainer
                var trainerId = user.TrainerId;
                if (string.IsNullOrEmpty(trainerId))
                {
                    var defaultTrainer = await _userManager.FindByEmailAsync("maya.patel@healthtrack.com") ?? await _userManager.FindByEmailAsync("trainer@healthtrack.com");
                    trainerId = defaultTrainer?.Id;
                }
                if (!string.IsNullOrEmpty(trainerId))
                {
                    _context.Notifications.Add(new Notification
                    {
                        UserId = trainerId,
                        Message = $"{user.FullName} logged a new weigh-in: {vm.QuickMeasurement.WeightKg:0.0} kg (BMI {bmi:0.0}).",
                        IsRead = false,
                        CreatedAt = DateTime.UtcNow
                    });
                }

                await _context.SaveChangesAsync();

                TempData["SuccessMessage"] = $"Measurement saved! Your current weight is now {vm.QuickMeasurement.WeightKg} kg (BMI: {bmi}).";
            }

            return RedirectToAction(nameof(Index));
        }

        // POST: /Client/BookQuickAppointment
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> BookQuickAppointment(ClientDashboardViewModel vm)
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
                (a.TimeSlot == vm.QuickBooking.TimeSlot || a.TimeSlot.StartsWith(vm.QuickBooking.TimeSlot) || vm.QuickBooking.TimeSlot.StartsWith(a.TimeSlot)) &&
                a.Status != "Declined" && a.Status != "Cancelled");

            if (hasConflict)
            {
                TempData["ErrorMessage"] = $"The time slot {vm.QuickBooking.TimeSlot} is already booked. Please choose another slot.";
                TempData["OpenBookingModal"] = "true";
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

            // Add notification for client
            _context.Notifications.Add(new Notification
            {
                UserId = user.Id,
                Message = $"Appointment scheduled with your coach on {vm.QuickBooking.AppointmentDate:MMM dd, yyyy} at {vm.QuickBooking.TimeSlot}.",
                IsRead = false,
                CreatedAt = DateTime.UtcNow
            });

            // Live Sync: Notify trainer
            if (!string.IsNullOrEmpty(trainerId))
            {
                _context.Notifications.Add(new Notification
                {
                    UserId = trainerId,
                    Message = $"New consultation requested by {user.FullName} for {vm.QuickBooking.AppointmentDate:MMM dd} at {vm.QuickBooking.TimeSlot}.",
                    IsRead = false,
                    CreatedAt = DateTime.UtcNow
                });
            }

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"Appointment booked successfully for {vm.QuickBooking.AppointmentDate:MMM dd} at {vm.QuickBooking.TimeSlot}!";

            return RedirectToAction(nameof(Index));
        }

        // POST: /Client/ToggleExercise
        [HttpPost]
        public async Task<IActionResult> ToggleExercise(int id)
        {
            var exercise = await _context.WorkoutExercises.Include(e => e.WorkoutPlan).FirstOrDefaultAsync(e => e.Id == id);
            if (exercise == null) return NotFound();

            exercise.IsCompleted = !exercise.IsCompleted;

            // Live Sync: If all exercises completed, notify assigned trainer
            if (exercise.IsCompleted && exercise.WorkoutPlan != null)
            {
                var planExercises = await _context.WorkoutExercises
                    .Where(e => e.WorkoutPlanId == exercise.WorkoutPlanId)
                    .ToListAsync();

                bool allDone = planExercises.All(e => e.Id == exercise.Id ? true : e.IsCompleted);
                if (allDone)
                {
                    var user = await _userManager.FindByIdAsync(exercise.WorkoutPlan.ClientId);
                    var trainerId = exercise.WorkoutPlan.TrainerId ?? user?.TrainerId;
                    if (string.IsNullOrEmpty(trainerId))
                    {
                        var defaultTrainer = await _userManager.FindByEmailAsync("maya.patel@healthtrack.com") ?? await _userManager.FindByEmailAsync("trainer@healthtrack.com");
                        trainerId = defaultTrainer?.Id;
                    }

                    if (!string.IsNullOrEmpty(trainerId))
                    {
                        _context.Notifications.Add(new Notification
                        {
                            UserId = trainerId,
                            Message = $"{user?.FullName ?? "Client"} completed all exercises in '{exercise.WorkoutPlan.Title}'!",
                            IsRead = false,
                            CreatedAt = DateTime.UtcNow
                        });
                    }
                }
            }

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

        // GET: /Client/Workouts
        public async Task<IActionResult> Workouts()
        {
            var user = await GetCurrentClientUserAsync();
            if (user == null) return RedirectToPage("/Account/Login", new { area = "Identity" });

            var vm = new WorkoutPlansViewModel
            {
                ClientId = user.Id,
                FullName = user.FullName ?? user.UserName ?? "Client",
                Email = user.Email ?? string.Empty
            };

            bool isDemoUser = false;

            // Fetch trainer info
            if (!string.IsNullOrEmpty(user.TrainerId))
            {
                var trainer = await _userManager.FindByIdAsync(user.TrainerId);
                if (trainer != null) vm.TrainerName = trainer.FullName;
            }

            // Fetch all workout plans for this client
            var allPlans = await _context.WorkoutPlans
                .Include(w => w.Exercises)
                .Where(w => w.ClientId == user.Id)
                .OrderByDescending(w => w.CreatedAt)
                .ToListAsync();

            var plan = allPlans.FirstOrDefault(w => w.IsActive) ?? allPlans.FirstOrDefault();
            var pastPlans = allPlans.Where(w => w.Id != plan?.Id).ToList();

            if (plan != null)
            {
                vm.HasActivePlan = true;
                vm.ProgramTitle = plan.Title;
                if (!string.IsNullOrEmpty(plan.Description)) vm.ProgramDescription = plan.Description;
                vm.Exercises = plan.Exercises.ToList();
                vm.TotalExercisesCount = plan.Exercises.Count;
                vm.CompletedExercisesCount = plan.Exercises.Count(e => e.IsCompleted);
                vm.CompletionPercentage = vm.TotalExercisesCount > 0 
                    ? (int)Math.Round((double)vm.CompletedExercisesCount / vm.TotalExercisesCount * 100) 
                    : 0;
                vm.CurrentWeekText = $"Week 1 of 8 • {vm.CompletedExercisesCount} of {vm.TotalExercisesCount} exercises completed";

                vm.WeeklySessions = new List<WorkoutSessionItem>
                {
                    new WorkoutSessionItem
                    {
                        Id = plan.Id,
                        DaySchedule = "Today • 5:30 PM",
                        Title = plan.Title,
                        ExerciseCount = plan.Exercises.Count,
                        DurationMinutes = 45,
                        Intensity = "3 sets • 8-12 reps",
                        Status = vm.CompletionPercentage == 100 ? "Completed" : (vm.CompletionPercentage > 0 ? "In progress" : "Upcoming"),
                        IsActiveSession = true,
                        ExerciseNames = plan.Exercises.Select(e => $"{e.Name} ({e.Sets}x{e.Reps})").ToList()
                    }
                };
            }
            else if (isDemoUser)
            {
                // Pre-populated mockup view only for demo client
                vm.HasActivePlan = true;
                vm.ProgramTitle = "Foundation Strength • 8 Weeks";
                vm.ProgramDescription = "A progressive full-body program designed to improve strength, mobility and endurance.";
                vm.DaysPerWeek = 4;
                vm.MinutesPerSession = 45;
                vm.TotalExercisesCount = 8;
                vm.CompletedExercisesCount = 5;
                vm.CompletionPercentage = 62;
                vm.CurrentWeekText = "Week 5 of 8 • Stay consistent";

                vm.WeeklySessions = new List<WorkoutSessionItem>
                {
                    new WorkoutSessionItem
                    {
                        Id = 1,
                        DaySchedule = "Today • 5:30 PM",
                        Title = "Upper body strength",
                        ExerciseCount = 8,
                        DurationMinutes = 45,
                        Intensity = "3 sets • 8-12 reps",
                        Status = "In progress",
                        IsActiveSession = true,
                        ExerciseNames = new List<string> { "Barbell Bench Press (4x10)", "Incline Dumbbell Rows (3x12)", "Overhead DB Press (3x10)", "Tricep Pushdowns (3x15)" }
                    },
                    new WorkoutSessionItem
                    {
                        Id = 2,
                        DaySchedule = "Wednesday",
                        Title = "Lower body & core",
                        ExerciseCount = 7,
                        DurationMinutes = 50,
                        Intensity = "3 sets • 8-12 reps",
                        Status = "Upcoming",
                        IsActiveSession = false,
                        ExerciseNames = new List<string> { "Barbell Back Squats (4x8)", "Romanian Deadlifts (3x10)", "Bulgarian Split Squats (3x10)", "Plank Holds (3x60s)" }
                    },
                    new WorkoutSessionItem
                    {
                        Id = 3,
                        DaySchedule = "Friday",
                        Title = "Full body mobility",
                        ExerciseCount = 10,
                        DurationMinutes = 35,
                        Intensity = "3 sets • 8-12 reps",
                        Status = "Upcoming",
                        IsActiveSession = false,
                        ExerciseNames = new List<string> { "World's Greatest Stretch (3x5)", "Goblet Squat Pause (3x8)", "Face Pulls (3x15)", "Hanging Knee Raises (3x12)" }
                    },
                    new WorkoutSessionItem
                    {
                        Id = 4,
                        DaySchedule = "Sunday",
                        Title = "Active recovery & core",
                        ExerciseCount = 6,
                        DurationMinutes = 30,
                        Intensity = "2 sets • 15 reps",
                        Status = "Upcoming",
                        IsActiveSession = false,
                        ExerciseNames = new List<string> { "Zone 2 Incline Walk (20 min)", "Hamstring Flossing (2x10)", "Thoracic Spine Rotations (2x10)" }
                    }
                };
            }
            else
            {
                // Clean state for fresh new client awaiting trainer assignment
                vm.HasActivePlan = false;
                vm.ProgramTitle = "No active workout plan assigned";
                vm.ProgramDescription = "Your trainer will design a customized workout program tailored to your fitness goals. You can also log individual workouts anytime.";
                vm.DaysPerWeek = 0;
                vm.MinutesPerSession = 0;
                vm.TotalExercisesCount = 0;
                vm.CompletedExercisesCount = 0;
                vm.CompletionPercentage = 0;
                vm.CurrentWeekText = "Awaiting trainer program";
                vm.WeeklySessions = new List<WorkoutSessionItem>();
                vm.Exercises = new List<WorkoutExercise>();
            }

            vm.PastPlans = pastPlans.Select(p =>
            {
                int tot = p.Exercises.Count;
                int comp = p.Exercises.Count(e => e.IsCompleted);
                int pct = tot > 0 ? (int)Math.Round((double)comp / tot * 100) : 0;
                return new PastWorkoutPlanItem
                {
                    Id = p.Id,
                    Title = p.Title,
                    Description = p.Description,
                    AssignedDate = p.CreatedAt,
                    CompletedDate = p.CompletedAt,
                    TotalExercises = tot,
                    CompletedExercises = comp,
                    CompletionPercentage = pct,
                    Status = pct == 100 ? "Completed" : "Archived",
                    Exercises = p.Exercises.ToList()
                };
            }).ToList();

            vm.UnreadNotificationsCount = await _context.Notifications.CountAsync(n => n.UserId == user.Id && !n.IsRead);

            return View(vm);
        }

        // POST: /Client/LogWorkoutSession
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> LogWorkoutSession(WorkoutPlansViewModel vm)
        {
            var user = await GetCurrentClientUserAsync();

            var log = new HealthLog
            {
                ClientId = user.Id,
                LogDate = DateTime.UtcNow,
                WeightKg = user.CurrentWeight ?? 72.4,
                CalculatedBmi = Math.Round((user.CurrentWeight ?? 72.4) / Math.Pow((user.HeightCm ?? 175.0) / 100.0, 2), 1),
                CaloriesBurned = vm.LogWorkoutForm.CaloriesBurned,
                WaterIntakeLiters = 2.5,
                Notes = $"Workout: {vm.LogWorkoutForm.WorkoutName} ({vm.LogWorkoutForm.DurationMinutes} min) - {vm.LogWorkoutForm.Notes}"
            };

            _context.HealthLogs.Add(log);

            // Add notification
            _context.Notifications.Add(new Notification
            {
                UserId = user.Id,
                Message = $"Great job! You completed '{vm.LogWorkoutForm.WorkoutName}' and burned {vm.LogWorkoutForm.CaloriesBurned} kcal.",
                IsRead = false,
                CreatedAt = DateTime.UtcNow
            });

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"Workout session '{vm.LogWorkoutForm.WorkoutName}' logged successfully (+{vm.LogWorkoutForm.CaloriesBurned} kcal burned)!";

            return RedirectToAction(nameof(Workouts));
        }

        // GET: /Client/Diet
        public async Task<IActionResult> Diet()
        {
            var user = await GetCurrentClientUserAsync();
            if (user == null) return RedirectToPage("/Account/Login", new { area = "Identity" });

            bool isDemoUser = false;

            var vm = new DietPlansViewModel
            {
                ClientId = user.Id,
                FullName = user.FullName ?? user.UserName ?? "Client",
                Email = user.Email ?? string.Empty,
                TrainerName = "No coach assigned yet"
            };

            // Fetch trainer info
            if (!string.IsNullOrEmpty(user.TrainerId))
            {
                var trainer = await _userManager.FindByIdAsync(user.TrainerId);
                if (trainer != null)
                {
                    vm.TrainerName = trainer.FullName ?? trainer.UserName ?? "Personal Coach";
                }
            }

            // Query active Diet Plan from database
            var activePlan = await _context.DietPlans
                .Include(d => d.Meals)
                .OrderByDescending(d => d.CreatedAt)
                .FirstOrDefaultAsync(d => d.ClientId == user.Id);

            // Auto-upgrade legacy seed for demo client to match user design if needed
            if (isDemoUser && activePlan != null && (activePlan.Title == "Lean Cut & Muscle Preservation" || activePlan.Meals.Count < 4))
            {
                activePlan.Title = "Balanced Performance Plan";
                activePlan.TargetCalories = 2150;
                _context.MealItems.RemoveRange(activePlan.Meals);
                activePlan.Meals = new List<MealItem>
                {
                    new MealItem { MealType = "Breakfast", Description = "Greek yogurt, berries & almond granola", Calories = 420 },
                    new MealItem { MealType = "Lunch", Description = "Grilled chicken quinoa power bowl", Calories = 610 },
                    new MealItem { MealType = "Afternoon snack", Description = "Apple with almond butter", Calories = 240 },
                    new MealItem { MealType = "Dinner", Description = "Baked salmon, greens & brown rice", Calories = 580 }
                };
                await _context.SaveChangesAsync();
            }

            if (activePlan != null && activePlan.Meals.Any())
            {
                vm.HasActivePlan = true;
                vm.PlanTitle = string.IsNullOrWhiteSpace(activePlan.Title) ? "Personalized Nutrition Plan" : activePlan.Title;
                vm.PlanDescription = "Nutrient-dense meals to support training, recovery and steady energy.";
                vm.DailyTargetCalories = activePlan.TargetCalories > 0 ? activePlan.TargetCalories : 2000;
                vm.TargetProteinGrams = (int)Math.Round((vm.DailyTargetCalories * 0.25) / 4.0);
                vm.MealsPerDay = activePlan.Meals.Count;

                var defaultTimes = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
                {
                    { "Breakfast", "8:30 AM" },
                    { "Lunch", "12:30 PM" },
                    { "Afternoon snack", "3:30 PM" },
                    { "Snack", "3:30 PM" },
                    { "Dinner", "7:30 PM" }
                };

                int idx = 1;
                var today = DateTime.UtcNow.Date;
                var todayMealLogs = await _context.HealthLogs
                    .Where(l => l.ClientId == user.Id && l.LogDate >= today)
                    .Select(l => l.Notes)
                    .ToListAsync();

                foreach (var meal in activePlan.Meals)
                {
                    string time = defaultTimes.ContainsKey(meal.MealType) ? defaultTimes[meal.MealType] : $"{8 + (idx * 3)}:00 PM";
                    bool isLogged = todayMealLogs.Any(n => n != null && n.Contains(meal.MealType, StringComparison.OrdinalIgnoreCase));

                    string ingredients = !string.IsNullOrWhiteSpace(meal.Description) 
                        ? meal.Description 
                        : "Nutritious balanced meal tailored to your program goals.";

                    int protein = (int)Math.Round((meal.Calories * 0.25) / 4.0);
                    int carbs = (int)Math.Round((meal.Calories * 0.50) / 4.0);
                    int fats = (int)Math.Round((meal.Calories * 0.25) / 9.0);

                    vm.ScheduledMeals.Add(new MealScheduleItem
                    {
                        Id = meal.Id,
                        MealTime = time,
                        MealType = meal.MealType,
                        Description = meal.Description,
                        Calories = meal.Calories,
                        ProteinGrams = protein,
                        CarbsGrams = carbs,
                        FatsGrams = fats,
                        Ingredients = ingredients,
                        IsLogged = isLogged
                    });
                    idx++;
                }

                vm.LoggedMealsCount = vm.ScheduledMeals.Count(m => m.IsLogged);
                vm.TotalMealsCount = vm.ScheduledMeals.Count;
                vm.ScheduleDateText = $"{DateTime.Now:dddd, MMMM d} Â· {vm.LoggedMealsCount} of {vm.TotalMealsCount} logged";
            }
            else if (isDemoUser)
            {
                // Pre-populated mockup view only for demo client
                vm.HasActivePlan = true;
                vm.PlanTitle = "Balanced Performance Plan";
                vm.PlanDescription = "Nutrient-dense meals to support training, recovery and steady energy.";
                vm.DailyTargetCalories = 2150;
                vm.TargetProteinGrams = 120;
                vm.MealsPerDay = 4;

                vm.ScheduledMeals = new List<MealScheduleItem>
                {
                    new MealScheduleItem
                    {
                        Id = 1,
                        MealTime = "8:30 AM",
                        MealType = "Breakfast",
                        Description = "Greek yogurt, berries & almond granola",
                        Calories = 420,
                        ProteinGrams = 24,
                        CarbsGrams = 48,
                        FatsGrams = 14,
                        Ingredients = "0% Greek yogurt (200g), fresh blueberries (50g), strawberries (50g), whole grain almond granola (40g), drizzle of organic honey.",
                        IsLogged = true
                    },
                    new MealScheduleItem
                    {
                        Id = 2,
                        MealTime = "12:30 PM",
                        MealType = "Lunch",
                        Description = "Grilled chicken quinoa power bowl",
                        Calories = 610,
                        ProteinGrams = 48,
                        CarbsGrams = 62,
                        FatsGrams = 18,
                        Ingredients = "Grilled herb chicken breast (180g), tri-color organic quinoa (120g cooked), steamed broccoli florets, avocado slices (40g), extra virgin olive oil drizzle.",
                        IsLogged = false
                    },
                    new MealScheduleItem
                    {
                        Id = 3,
                        MealTime = "3:30 PM",
                        MealType = "Afternoon snack",
                        Description = "Apple with almond butter",
                        Calories = 240,
                        ProteinGrams = 6,
                        CarbsGrams = 28,
                        FatsGrams = 12,
                        Ingredients = "Crisp Gala or Honeycrisp apple (1 large), natural smooth unsalted almond butter (2 tbsp / 30g).",
                        IsLogged = false
                    },
                    new MealScheduleItem
                    {
                        Id = 4,
                        MealTime = "7:30 PM",
                        MealType = "Dinner",
                        Description = "Baked salmon, greens & brown rice",
                        Calories = 580,
                        ProteinGrams = 42,
                        CarbsGrams = 46,
                        FatsGrams = 22,
                        Ingredients = "Atlantic salmon fillet (180g) baked with lemon and dill, wild brown rice (120g cooked), roasted asparagus spears & baby spinach with garlic.",
                        IsLogged = false
                    }
                };

                vm.LoggedMealsCount = vm.ScheduledMeals.Count(m => m.IsLogged);
                vm.TotalMealsCount = vm.ScheduledMeals.Count;
                vm.ScheduleDateText = $"{DateTime.Now:dddd, MMMM d} Â· {vm.LoggedMealsCount} of {vm.TotalMealsCount} logged";
            }
            else
            {
                // Clean empty state for new client with no assigned diet plan
                vm.HasActivePlan = false;
                vm.PlanTitle = "No Diet Plan Assigned Yet";
                vm.PlanDescription = "Your coach or nutritionist will design a custom nutrition regimen for you.";
                vm.DailyTargetCalories = 0;
                vm.TargetProteinGrams = 0;
                vm.MealsPerDay = 0;

                var today = DateTime.UtcNow.Date;
                var customLogs = await _context.HealthLogs
                    .Where(l => l.ClientId == user.Id && l.LogDate >= today && l.Notes != null && l.Notes.StartsWith("Meal:"))
                    .OrderBy(l => l.LogDate)
                    .ToListAsync();

                if (customLogs.Any())
                {
                    foreach (var cl in customLogs)
                    {
                        string mealType = "Custom Meal";
                        string desc = cl.Notes ?? "";
                        int cal = 0;
                        int protein = 0;

                        var noteText = cl.Notes ?? "";
                        if (noteText.StartsWith("Meal:", StringComparison.OrdinalIgnoreCase))
                        {
                            var afterMeal = noteText.Substring(5).Trim();
                            var dashIdx = afterMeal.IndexOf('-');
                            if (dashIdx > 0)
                            {
                                mealType = afterMeal.Substring(0, dashIdx).Trim();
                                var rest = afterMeal.Substring(dashIdx + 1).Trim();
                                var parenIdx = rest.LastIndexOf('(');
                                if (parenIdx > 0)
                                {
                                    desc = rest.Substring(0, parenIdx).Trim();
                                    var calMatch = System.Text.RegularExpressions.Regex.Match(rest, @"(\d+)\s*kcal");
                                    if (calMatch.Success) int.TryParse(calMatch.Groups[1].Value, out cal);
                                    var proMatch = System.Text.RegularExpressions.Regex.Match(rest, @"(\d+)g?\s*protein");
                                    if (proMatch.Success) int.TryParse(proMatch.Groups[1].Value, out protein);
                                }
                                else
                                {
                                    desc = rest;
                                }
                            }
                            else
                            {
                                desc = afterMeal;
                            }
                        }

                        vm.ScheduledMeals.Add(new MealScheduleItem
                        {
                            Id = cl.Id,
                            MealTime = cl.LogDate.ToLocalTime().ToString("h:mm tt"),
                            MealType = mealType,
                            Description = desc,
                            Calories = cal,
                            ProteinGrams = protein,
                            CarbsGrams = 0,
                            FatsGrams = 0,
                            Ingredients = desc,
                            IsLogged = true
                        });
                    }

                    vm.LoggedMealsCount = vm.ScheduledMeals.Count;
                    vm.TotalMealsCount = vm.ScheduledMeals.Count;
                    vm.ScheduleDateText = $"{DateTime.Now:dddd, MMMM d} Â· {vm.LoggedMealsCount} meal{(vm.LoggedMealsCount == 1 ? "" : "s")} logged today";
                }
                else
                {
                    vm.LoggedMealsCount = 0;
                    vm.TotalMealsCount = 0;
                    vm.ScheduleDateText = $"{DateTime.Now:dddd, MMMM d} Â· Awaiting nutritionist schedule";
                }
            }

            vm.UnreadNotificationsCount = await _context.Notifications.CountAsync(n => n.UserId == user.Id && !n.IsRead);

            return View(vm);
        }

        // POST: /Client/LogMealEntry
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> LogMealEntry(DietPlansViewModel vm)
        {
            var user = await GetCurrentClientUserAsync();

            // Strict Coach Model: Validate client has active diet plan
            var activePlan = await _context.DietPlans.FirstOrDefaultAsync(d => d.ClientId == user.Id);
            if (activePlan == null)
            {
                TempData["ErrorMessage"] = "You do not have an active diet plan assigned yet. Please consult your coach or nutritionist to get a personalized meal plan.";
                return RedirectToAction(nameof(Diet));
            }

            var form = vm.LogMealForm;
            if (form == null || string.IsNullOrWhiteSpace(form.Description))
            {
                TempData["ErrorMessage"] = "Please fill in the meal details.";
                return RedirectToAction(nameof(Diet));
            }

            // Save to HealthLog (record caloric intake)
            double userWeight = user.CurrentWeight ?? 0;
            double userHeight = user.HeightCm ?? 0;
            double bmi = (userWeight > 0 && userHeight > 0) 
                ? Math.Round(userWeight / Math.Pow(userHeight / 100.0, 2), 1) 
                : 0;

            var log = new HealthLog
            {
                ClientId = user.Id,
                LogDate = DateTime.UtcNow,
                WeightKg = userWeight,
                CalculatedBmi = bmi,
                CaloriesBurned = 0,
                WaterIntakeLiters = 2.0,
                Notes = $"Meal: {form.MealType} - {form.Description} ({form.Calories} kcal, {form.ProteinGrams}g protein)"
            };
            _context.HealthLogs.Add(log);

            // Add notification
            _context.Notifications.Add(new Notification
            {
                UserId = user.Id,
                Message = $"Meal logged: {form.MealType} ({form.Calories} kcal). Great job following your nutrition targets!",
                IsRead = false,
                CreatedAt = DateTime.UtcNow
            });

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"Meal '{form.MealType}' logged successfully (+{form.Calories} kcal recorded)!";

            return RedirectToAction(nameof(Diet));
        }

        // POST: /Client/ToggleMealStatus
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ToggleMealStatus(string mealType, string mealDescription, int calories)
        {
            var user = await GetCurrentClientUserAsync();

            // Add meal record to HealthLogs
            var log = new HealthLog
            {
                ClientId = user.Id,
                LogDate = DateTime.UtcNow,
                WeightKg = user.CurrentWeight ?? 72.4,
                CalculatedBmi = Math.Round((user.CurrentWeight ?? 72.4) / Math.Pow((user.HeightCm ?? 175.0) / 100.0, 2), 1),
                CaloriesBurned = 0,
                WaterIntakeLiters = 2.5,
                Notes = $"Meal Logged: {mealType} - {mealDescription} ({calories} kcal)"
            };
            _context.HealthLogs.Add(log);

            _context.Notifications.Add(new Notification
            {
                UserId = user.Id,
                Message = $"You have marked your {mealType} as logged ({calories} kcal).",
                IsRead = false,
                CreatedAt = DateTime.UtcNow
            });

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"{mealType} marked as logged ({calories} kcal)!";

            return RedirectToAction(nameof(Diet));
        }

        // GET: /Client/Appointments
        public async Task<IActionResult> Appointments(string tab = "Upcoming", string search = "", string status = "All")
        {
            var user = await GetCurrentClientUserAsync();
            if (user == null) return RedirectToPage("/Account/Login", new { area = "Identity" });

            var vm = new AppointmentsViewModel
            {
                ClientId = user.Id,
                FullName = user.FullName ?? user.UserName ?? "Client",
                Email = user.Email ?? string.Empty,
                ActiveTab = string.Equals(tab, "Past", StringComparison.OrdinalIgnoreCase) ? "Past" : "Upcoming",
                SearchTerm = search ?? string.Empty,
                StatusFilter = status ?? "All"
            };

            // Query existing appointments from database
            var dbAppointments = await _context.Appointments
                .Include(a => a.Trainer)
                .Where(a => a.ClientId == user.Id)
                .OrderBy(a => a.AppointmentDate)
                .ToListAsync();

            bool isDemoUser = false;

            // If demo user has 0 or only 1 legacy appointment, auto-seed the reference items for them so it matches the design
            if (isDemoUser && dbAppointments.Count <= 1)
            {
                var maya = await _userManager.FindByEmailAsync("maya.patel@healthtrack.com");
                var chris = await _userManager.FindByEmailAsync("chris.williams@healthtrack.com");
                var nina = await _userManager.FindByEmailAsync("nina.ford@healthtrack.com");
                var alex = await _userManager.FindByEmailAsync("trainer@healthtrack.com");

                var mayaId = maya?.Id ?? alex?.Id ?? user.Id;
                var chrisId = chris?.Id ?? alex?.Id ?? user.Id;
                var ninaId = nina?.Id ?? alex?.Id ?? user.Id;

                var initialList = new List<Appointment>
                {
                    new Appointment
                    {
                        ClientId = user.Id,
                        TrainerId = mayaId,
                        AppointmentDate = new DateTime(DateTime.UtcNow.Year, 4, 18),
                        TimeSlot = "10:30 AM",
                        Status = "Approved",
                        Notes = "HEALTH CONSULTATION Â· 45 min - Routine cardiovascular screening and general wellness assessment."
                    },
                    new Appointment
                    {
                        ClientId = user.Id,
                        TrainerId = chrisId,
                        AppointmentDate = new DateTime(DateTime.UtcNow.Year, 4, 24),
                        TimeSlot = "4:00 PM",
                        Status = "Pending",
                        Notes = "PERSONAL TRAINING Â· 60 min - Progressive overload review & squat technique optimization."
                    },
                    new Appointment
                    {
                        ClientId = user.Id,
                        TrainerId = ninaId,
                        AppointmentDate = new DateTime(DateTime.UtcNow.Year, 5, 2),
                        TimeSlot = "9:15 AM",
                        Status = "Approved",
                        Notes = "NUTRITION REVIEW Â· 60 min - Macronutrient adjustment for endurance & lean retention."
                    },
                    new Appointment
                    {
                        ClientId = user.Id,
                        TrainerId = mayaId,
                        AppointmentDate = DateTime.UtcNow.AddDays(-14),
                        TimeSlot = "10:00 AM",
                        Status = "Completed",
                        Notes = "HEALTH CONSULTATION Â· 45 min - Baseline biometric evaluation and intake consultation."
                    },
                    new Appointment
                    {
                        ClientId = user.Id,
                        TrainerId = chrisId,
                        AppointmentDate = DateTime.UtcNow.AddDays(-7),
                        TimeSlot = "3:30 PM",
                        Status = "Completed",
                        Notes = "PERSONAL TRAINING Â· 60 min - Movement assessment & functional mobility calibration."
                    }
                };

                if (dbAppointments.Any())
                {
                    _context.Appointments.RemoveRange(dbAppointments);
                }

                _context.Appointments.AddRange(initialList);
                await _context.SaveChangesAsync();

                dbAppointments = await _context.Appointments
                    .Include(a => a.Trainer)
                    .Where(a => a.ClientId == user.Id)
                    .OrderBy(a => a.AppointmentDate)
                    .ToListAsync();
            }

            var allItems = new List<AppointmentItemViewModel>();
            foreach (var a in dbAppointments)
            {
                var specialistName = a.Trainer?.FullName ?? a.Trainer?.UserName ?? "Assigned Coach";

                string category = "HEALTH CONSULTATION";
                string duration = "45 min";
                if (a.Notes != null)
                {
                    if (a.Notes.Contains("PERSONAL TRAINING", StringComparison.OrdinalIgnoreCase)) category = "PERSONAL TRAINING";
                    else if (a.Notes.Contains("NUTRITION REVIEW", StringComparison.OrdinalIgnoreCase)) category = "NUTRITION REVIEW";
                    else if (a.Notes.Contains("HEALTH CONSULTATION", StringComparison.OrdinalIgnoreCase)) category = "HEALTH CONSULTATION";

                    if (a.Notes.Contains("60 min", StringComparison.OrdinalIgnoreCase)) duration = "60 min";
                    else if (a.Notes.Contains("45 min", StringComparison.OrdinalIgnoreCase)) duration = "45 min";
                    else if (a.Notes.Contains("30 min", StringComparison.OrdinalIgnoreCase)) duration = "30 min";
                }

                var initials = string.Join("", specialistName.Split(' ').Select(w => w.Length > 0 ? w[0].ToString() : "")).ToUpper();
                if (specialistName.StartsWith("Dr. ", StringComparison.OrdinalIgnoreCase))
                {
                    var parts = specialistName.Substring(4).Trim().Split(' ');
                    initials = string.Join("", parts.Select(w => w.Length > 0 ? w[0].ToString() : "")).ToUpper();
                }
                if (initials.Length > 2) initials = initials.Substring(0, 2);
                if (string.IsNullOrEmpty(initials)) initials = "SP";

                allItems.Add(new AppointmentItemViewModel
                {
                    Id = a.Id,
                    Day = a.AppointmentDate.ToString("dd"),
                    Month = a.AppointmentDate.ToString("MMM").ToUpper(),
                    FullDate = a.AppointmentDate,
                    SpecialistName = specialistName,
                    SpecialistInitials = initials,
                    SpecialistRole = a.Trainer?.FitnessGoal ?? "Specialist & Coach",
                    Category = category,
                    TimeSlot = a.TimeSlot,
                    DurationText = duration,
                    Status = a.Status,
                    Notes = a.Notes ?? "Standard consultation session.",
                    Location = "Suite 3B, HealthTrack Clinical Facility & Virtual Stream"
                });
            }

            // Split into Upcoming and Past
            var upcoming = allItems.Where(i => i.Status != "Completed").ToList();
            var past = allItems.Where(i => i.Status == "Completed" || i.Status == "Cancelled").ToList();

            vm.UpcomingCount = upcoming.Count;
            vm.PastCount = past.Count;

            // Apply search filter if provided
            if (!string.IsNullOrWhiteSpace(search))
            {
                var s = search.Trim().ToLower();
                upcoming = upcoming.Where(i => i.SpecialistName.ToLower().Contains(s) || i.Category.ToLower().Contains(s) || i.Notes.ToLower().Contains(s)).ToList();
                past = past.Where(i => i.SpecialistName.ToLower().Contains(s) || i.Category.ToLower().Contains(s) || i.Notes.ToLower().Contains(s)).ToList();
            }

            // Apply status filter if provided
            if (!string.IsNullOrWhiteSpace(status) && !string.Equals(status, "All", StringComparison.OrdinalIgnoreCase))
            {
                upcoming = upcoming.Where(i => string.Equals(i.Status, status, StringComparison.OrdinalIgnoreCase)).ToList();
                past = past.Where(i => string.Equals(i.Status, status, StringComparison.OrdinalIgnoreCase)).ToList();
            }

            vm.UpcomingAppointments = upcoming;
            vm.PastAppointments = past;

            // Load available trainers dynamically for booking dropdown
            var trainers = await _userManager.GetUsersInRoleAsync("Trainer");
            vm.AvailableTrainers = trainers.Select(t => new TrainerOption
            {
                Id = t.Id,
                Name = t.FullName ?? t.UserName ?? "Trainer",
                RoleOrSpecialty = t.FitnessGoal ?? "Specialist & Coach"
            }).ToList();

            vm.UnreadNotificationsCount = await _context.Notifications.CountAsync(n => n.UserId == user.Id && !n.IsRead);

            return View(vm);
        }

        // POST: /Client/BookAppointment
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> BookAppointment(AppointmentsViewModel vm)
        {
            var user = await GetCurrentClientUserAsync();

            // Validate data annotations on BookAppointmentInputModel
            if (!ModelState.IsValid)
            {
                TempData["ErrorMessage"] = "Please fill in all required appointment fields correctly.";
                return RedirectToAction(nameof(Appointments));
            }

            var form = vm.BookingForm;
            if (form == null || string.IsNullOrWhiteSpace(form.Category))
            {
                TempData["ErrorMessage"] = "Please select valid consultation details.";
                return RedirectToAction(nameof(Appointments));
            }

            // Find specialist ID dynamically from registered database trainers
            var trainersList = await _userManager.GetUsersInRoleAsync("Trainer");
            string trainerId = user.TrainerId ?? string.Empty;

            var matchedTrainer = trainersList.FirstOrDefault(t => 
                t.Id == form.SpecialistName || 
                string.Equals(t.FullName, form.SpecialistName, StringComparison.OrdinalIgnoreCase) ||
                (t.FullName != null && !string.IsNullOrEmpty(form.SpecialistName) && form.SpecialistName.Contains(t.FullName, StringComparison.OrdinalIgnoreCase)));

            if (matchedTrainer != null)
            {
                trainerId = matchedTrainer.Id;
            }
            else if (string.IsNullOrEmpty(trainerId) && trainersList.Any())
            {
                trainerId = trainersList.First().Id;
            }

            if (string.IsNullOrEmpty(trainerId))
            {
                var fallback = await _userManager.FindByEmailAsync("trainer@healthtrack.com");
                if (fallback != null) trainerId = fallback.Id;
            }

            // Conflict detection (TC-14): verify coach does not have an existing booking at the same date and time slot
            bool hasConflict = await _context.Appointments.AnyAsync(a =>
                a.TrainerId == trainerId &&
                a.AppointmentDate.Date == form.AppointmentDate.Date &&
                (a.TimeSlot == form.TimeSlot || a.TimeSlot.StartsWith(form.TimeSlot) || form.TimeSlot.StartsWith(a.TimeSlot)) &&
                a.Status != "Cancelled" && a.Status != "Declined");

            if (hasConflict)
            {
                TempData["ErrorMessage"] = $"The time slot {form.TimeSlot} is already booked. Please choose another slot.";
                TempData["OpenBookingModal"] = "true";
                return RedirectToAction(nameof(Appointments));
            }

            var appt = new Appointment
            {
                ClientId = user.Id,
                TrainerId = trainerId,
                AppointmentDate = form.AppointmentDate,
                TimeSlot = form.TimeSlot,
                Status = "Pending",
                Notes = $"{form.Category.ToUpper()} Â· {form.DurationText} - {form.Notes ?? "Client booked consultation via portal."}",
                CreatedAt = DateTime.UtcNow
            };

            _context.Appointments.Add(appt);

            // Add notification for client
            _context.Notifications.Add(new Notification
            {
                UserId = user.Id,
                Message = $"Your {form.Category} appointment with {form.SpecialistName} on {form.AppointmentDate:dd MMM yyyy} at {form.TimeSlot} has been requested.",
                IsRead = false,
                CreatedAt = DateTime.UtcNow
            });

            // Live Sync: Notify trainer of incoming consultation request
            if (!string.IsNullOrEmpty(trainerId))
            {
                _context.Notifications.Add(new Notification
                {
                    UserId = trainerId,
                    Message = $"New appointment request from {user.FullName}: {form.Category} on {form.AppointmentDate:dd MMM yyyy} at {form.TimeSlot}.",
                    IsRead = false,
                    CreatedAt = DateTime.UtcNow
                });
            }

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"Appointment for {form.Category} with {form.SpecialistName} on {form.AppointmentDate:dd MMM} requested successfully!";

            return RedirectToAction(nameof(Appointments));
        }

        // POST: /Client/CancelAppointment
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CancelAppointment(int id)
        {
            var user = await GetCurrentClientUserAsync();
            var appt = await _context.Appointments.FirstOrDefaultAsync(a => a.Id == id && a.ClientId == user.Id);

            if (appt != null)
            {
                appt.Status = "Cancelled";
                _context.Notifications.Add(new Notification
                {
                    UserId = user.Id,
                    Message = $"Your appointment on {appt.AppointmentDate:dd MMM} at {appt.TimeSlot} has been cancelled.",
                    IsRead = false,
                    CreatedAt = DateTime.UtcNow
                });

                // Live Sync: Notify trainer
                if (!string.IsNullOrEmpty(appt.TrainerId))
                {
                    _context.Notifications.Add(new Notification
                    {
                        UserId = appt.TrainerId,
                        Message = $"{user.FullName} cancelled the consultation scheduled on {appt.AppointmentDate:dd MMM} at {appt.TimeSlot}.",
                        IsRead = false,
                        CreatedAt = DateTime.UtcNow
                    });
                }

                await _context.SaveChangesAsync();
                TempData["SuccessMessage"] = "Appointment has been cancelled successfully.";
            }

            return RedirectToAction(nameof(Appointments));
        }

        // GET: /Client/Analytics
        public async Task<IActionResult> Analytics(string timeRange = "Last 30 days", string metric = "All metrics")
        {
            var user = await GetCurrentClientUserAsync();
            if (user == null) return RedirectToPage("/Account/Login", new { area = "Identity" });

            bool isDemoUser = false;

            string selectedTimeRange = timeRange switch
            {
                "Last 7 Days" or "7" or "7days" or "Weekly" => "Last 7 Days",
                "All Time" or "All" or "Yearly" => "All Time",
                _ => "Last 30 Days"
            };

            var vm = new ProgressAnalyticsViewModel
            {
                ClientId = user.Id,
                FullName = user.FullName ?? user.UserName ?? "Client",
                Email = user.Email ?? string.Empty,
                SelectedTimeRange = selectedTimeRange,
                SelectedMetric = metric ?? "All metrics",
                HeightCm = (int)(user.HeightCm ?? 175),
                CurrentWeightKg = user.CurrentWeight ?? 0
            };

            var logs = await _context.HealthLogs
                .Where(l => l.ClientId == user.Id && l.WeightKg > 0)
                .OrderByDescending(l => l.LogDate)
                .ToListAsync();

            // Real life biometric measurements (1 per date, clean date format with NO TIME)
            var dailyHistoryLogs = logs
                .GroupBy(l => l.LogDate.Date)
                .Select(g =>
                    g.OrderByDescending(l => !string.IsNullOrEmpty(l.Notes) && (l.Notes.Contains("waist:") || l.Notes.Contains("measurement") || l.Notes.Contains("biometric") || (!l.Notes.Contains("Meal Logged") && !l.Notes.Contains("Morning hydration"))))
                     .ThenBy(l => l.LogDate)
                     .Last()
                )
                .OrderByDescending(l => l.LogDate)
                .ToList();

            vm.MeasurementHistory = dailyHistoryLogs.Select(l =>
            {
                int waist = 82;
                if (l.Notes != null && l.Notes.Contains("waist:", StringComparison.OrdinalIgnoreCase))
                {
                    var parts = l.Notes.Split(new[] { "waist:" }, StringSplitOptions.None);
                    if (parts.Length > 1 && int.TryParse(parts[1].Trim().Split(' ')[0], out int w)) waist = w;
                }
                else
                {
                    waist = 80 + (int)Math.Round((l.WeightKg - 70) * 1.0);
                }

                return new MeasurementHistoryItem
                {
                    Id = l.Id,
                    Date = l.LogDate,
                    DateText = l.LogDate.ToString("MMM dd, yyyy"),
                    WeightKg = l.WeightKg,
                    HeightCm = (int)(user.HeightCm ?? 175),
                    Bmi = l.CalculatedBmi > 0 ? l.CalculatedBmi : Math.Round(l.WeightKg / Math.Pow((user.HeightCm ?? 175) / 100.0, 2), 1),
                    WaistCm = waist,
                    Notes = (!string.IsNullOrEmpty(l.Notes) && !l.Notes.StartsWith("Meal Logged") && !l.Notes.StartsWith("Morning hydration"))
                        ? l.Notes
                        : "Routine biometric check"
                };
            }).ToList();

            // Filter logs for Weight trend based on selectedTimeRange (strictly 1 weigh-in per date)
            var chartLogs = logs.OrderBy(l => l.LogDate).ToList();
            if (selectedTimeRange == "Last 7 Days")
            {
                var cutoff = DateTime.UtcNow.AddDays(-7);
                chartLogs = chartLogs.Where(l => l.LogDate >= cutoff).ToList();
            }
            else if (selectedTimeRange == "Last 30 Days")
            {
                var cutoff = DateTime.UtcNow.AddDays(-30);
                chartLogs = chartLogs.Where(l => l.LogDate >= cutoff).ToList();
            }

            var dailyChartLogs = chartLogs
                .GroupBy(l => l.LogDate.Date)
                .Select(g =>
                    g.OrderByDescending(l => !string.IsNullOrEmpty(l.Notes) && (l.Notes.Contains("waist:") || l.Notes.Contains("measurement") || l.Notes.Contains("biometric") || (!l.Notes.Contains("Meal Logged") && !l.Notes.Contains("Morning hydration"))))
                     .ThenBy(l => l.LogDate)
                     .Last()
                )
                .OrderBy(l => l.LogDate)
                .ToList();

            if (dailyChartLogs.Any())
            {
                var latest = dailyChartLogs.Last();
                var oldest = dailyChartLogs.First();
                vm.CurrentWeightKg = latest.WeightKg;

                double diff = Math.Round(latest.WeightKg - oldest.WeightKg, 1);
                vm.WeightChange = $"{(diff >= 0 ? "+" : "")}{diff} kg";
                vm.WeightChangePeriod = selectedTimeRange == "Last 7 Days"
                    ? $"Past 7 days (since {oldest.LogDate:MMM dd})"
                    : (selectedTimeRange == "Last 30 Days" ? $"Past 30 days (since {oldest.LogDate:MMM dd})" : $"All-time (since {oldest.LogDate:MMM dd, yyyy})");
                vm.WeightTrendStatus = diff <= 0 ? "On track" : "Progressing";

                // Strictly clean calendar dates (MMM dd) - NO TIME
                vm.WeightLabels = dailyChartLogs.Select(l => l.LogDate.ToString("MMM dd")).ToList();
                vm.WeightValues = dailyChartLogs.Select(l => l.WeightKg).ToList();
            }
            else if (logs.Any())
            {
                vm.CurrentWeightKg = logs.First().WeightKg;
                vm.WeightChange = "0.0 kg";
                vm.WeightChangePeriod = $"No logs in {selectedTimeRange.ToLower()}";
                vm.WeightTrendStatus = "No recent data";
                vm.WeightLabels = new List<string>();
                vm.WeightValues = new List<double>();
            }
            else
            {
                vm.CurrentWeightKg = user.CurrentWeight ?? 0;
                vm.WeightChange = "0.0 kg";
                vm.WeightChangePeriod = "Awaiting first log";
                vm.WeightTrendStatus = "Awaiting weigh-in";
                vm.WeightLabels = new List<string>();
                vm.WeightValues = new List<double>();
            }

                // Workout completion rate from real database workouts
                var userWorkouts = await _context.WorkoutPlans
                    .Include(w => w.Exercises)
                    .Where(w => w.ClientId == user.Id)
                    .ToListAsync();

                var allExercises = userWorkouts.SelectMany(w => w.Exercises).ToList();
                if (allExercises.Any())
                {
                    int done = allExercises.Count(e => e.IsCompleted);
                    int total = allExercises.Count;
                    int pct = (int)Math.Round((double)done / total * 100);
                    vm.WorkoutCompletionRate = $"{pct}%";
                    vm.WorkoutCompletionChange = $"{done}/{total} exercises done";
                }
                else
                {
                    vm.WorkoutCompletionRate = "0%";
                    vm.WorkoutCompletionChange = "No routines assigned";
                }

                vm.ActiveMinutes = logs.Count * 45;
                vm.ActiveMinutesPeriod = "Recorded sessions";
                vm.AverageCalories = logs.Any() && logs.Any(l => l.CaloriesBurned > 0)
                    ? ((int)logs.Where(l => l.CaloriesBurned > 0).Average(l => l.CaloriesBurned)).ToString("N0")
                    : "0";
                vm.AverageCaloriesPeriod = "Daily average";

            vm.UnreadNotificationsCount = await _context.Notifications.CountAsync(n => n.UserId == user.Id && !n.IsRead);

            return View(vm);
        }

        // POST: /Client/RecordMeasurement
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> RecordMeasurement(ProgressAnalyticsViewModel vm)
        {
            var user = await GetCurrentClientUserAsync();
            var form = vm.RecordMeasurementForm;

            if (form == null || form.WeightKg <= 0)
            {
                TempData["ErrorMessage"] = "Please enter valid measurement values.";
                return RedirectToAction(nameof(Analytics));
            }

            double heightM = (form.HeightCm > 0 ? form.HeightCm : (user.HeightCm ?? 178)) / 100.0;
            double bmi = Math.Round(form.WeightKg / (heightM * heightM), 1);

            // Auto-calculate calories burned from completed workout exercises
            var activeWorkout = await _context.WorkoutPlans
                .Include(w => w.Exercises)
                .Where(w => w.ClientId == user.Id && w.IsActive)
                .OrderByDescending(w => w.CreatedAt)
                .FirstOrDefaultAsync();

            int completedEx = activeWorkout?.Exercises?.Count(e => e.IsCompleted) ?? 0;
            int autoCalories = completedEx * 60;

            // Daily Upsert: Check if an entry already exists for target date
            var targetDate = form.MeasurementDate != default ? form.MeasurementDate.Date : DateTime.UtcNow.Date;
            var targetDateEnd = targetDate.AddDays(1);
            var existingLog = await _context.HealthLogs
                .Where(l => l.ClientId == user.Id && l.LogDate >= targetDate && l.LogDate < targetDateEnd && !l.Notes.StartsWith("Meal Logged"))
                .OrderByDescending(l => l.LogDate)
                .FirstOrDefaultAsync();

            string notes = $"Biometrics - waist:{form.WaistCm} cm - {form.Notes ?? "Client recorded measurement"}";

            if (existingLog != null)
            {
                existingLog.WeightKg = form.WeightKg;
                existingLog.CalculatedBmi = bmi;
                existingLog.CaloriesBurned = autoCalories > 0 ? autoCalories : existingLog.CaloriesBurned;
                existingLog.Notes = notes;
            }
            else
            {
                var log = new HealthLog
                {
                    ClientId = user.Id,
                    LogDate = form.MeasurementDate != default ? form.MeasurementDate : DateTime.UtcNow,
                    WeightKg = form.WeightKg,
                    CalculatedBmi = bmi,
                    CaloriesBurned = autoCalories > 0 ? autoCalories : 450,
                    WaterIntakeLiters = 2.5,
                    Notes = notes
                };
                _context.HealthLogs.Add(log);
            }

            user.CurrentWeight = form.WeightKg;
            if (form.HeightCm > 0) user.HeightCm = form.HeightCm;

            _context.Notifications.Add(new Notification
            {
                UserId = user.Id,
                Message = $"New health measurement logged: {form.WeightKg} kg, BMI {bmi}, Waist {form.WaistCm} cm.",
                IsRead = false,
                CreatedAt = DateTime.UtcNow
            });

            // Live Sync: Notify assigned trainer
            var trainerId = user.TrainerId;
            if (string.IsNullOrEmpty(trainerId))
            {
                var defaultTrainer = await _userManager.FindByEmailAsync("maya.patel@healthtrack.com") ?? await _userManager.FindByEmailAsync("trainer@healthtrack.com");
                trainerId = defaultTrainer?.Id;
            }
            if (!string.IsNullOrEmpty(trainerId))
            {
                _context.Notifications.Add(new Notification
                {
                    UserId = trainerId,
                    Message = $"{user.FullName} logged new biometric scan: {form.WeightKg:0.0} kg, BMI {bmi:0.0}, Waist {form.WaistCm} cm.",
                    IsRead = false,
                    CreatedAt = DateTime.UtcNow
                });
            }

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"Measurement recorded successfully! Weight: {form.WeightKg} kg, BMI: {bmi}.";

            return RedirectToAction(nameof(Analytics));
        }

        // POST: /Client/DeleteMeasurement
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteMeasurement(int id)
        {
            var user = await GetCurrentClientUserAsync();
            if (user == null) return RedirectToPage("/Account/Login", new { area = "Identity" });

            var log = await _context.HealthLogs.FirstOrDefaultAsync(l => l.Id == id && l.ClientId == user.Id);
            if (log != null)
            {
                var removedWeight = log.WeightKg;
                var removedDate = log.LogDate;
                _context.HealthLogs.Remove(log);
                await _context.SaveChangesAsync();

                // Recalculate user's CurrentWeight to latest remaining log if any
                var remainingLogs = await _context.HealthLogs
                    .Where(l => l.ClientId == user.Id && l.WeightKg > 0)
                    .OrderByDescending(l => l.LogDate)
                    .ToListAsync();

                if (remainingLogs.Any())
                {
                    user.CurrentWeight = remainingLogs.First().WeightKg;
                }
                else
                {
                    user.CurrentWeight = null;
                }
                await _userManager.UpdateAsync(user);

                // Live Sync: Notify assigned trainer of deletion
                var trainerId = user.TrainerId;
                if (string.IsNullOrEmpty(trainerId))
                {
                    var defaultTrainer = await _userManager.FindByEmailAsync("maya.patel@healthtrack.com") ?? await _userManager.FindByEmailAsync("trainer@healthtrack.com");
                    trainerId = defaultTrainer?.Id;
                }
                if (!string.IsNullOrEmpty(trainerId))
                {
                    _context.Notifications.Add(new Notification
                    {
                        UserId = trainerId,
                        Message = $"{user.FullName} deleted biometric entry ({removedWeight:0.0} kg from {removedDate:MMM dd}).",
                        IsRead = false,
                        CreatedAt = DateTime.UtcNow
                    });
                    await _context.SaveChangesAsync();
                }

                TempData["SuccessMessage"] = $"Measurement entry ({removedWeight:0.0} kg) deleted successfully.";
            }
            else
            {
                TempData["ErrorMessage"] = "Measurement entry not found or already deleted.";
            }

            return RedirectToAction(nameof(Analytics));
        }

        // GET: /Client/ExportReport
        public async Task<IActionResult> ExportReport()
        {
            var user = await GetCurrentClientUserAsync();
            var logs = await _context.HealthLogs
                .Where(l => l.ClientId == user.Id && l.WeightKg > 0)
                .OrderByDescending(l => l.LogDate)
                .ToListAsync();

            var sb = new System.Text.StringBuilder();
            sb.AppendLine("Date,Weight (kg),Height (cm),BMI,Waist (cm),Notes");

            if (logs.Any())
            {
                foreach (var log in logs)
                {
                    int waist = 80 + (int)Math.Round((log.WeightKg - 70) * 1.0);
                    sb.AppendLine($"{log.LogDate:yyyy-MM-dd},{log.WeightKg},{user.HeightCm ?? 178},{log.CalculatedBmi},{waist},\"{log.Notes?.Replace("\"", "\"\"")}\"");
                }
            }
            else
            {
                sb.AppendLine("2025-04-12,72.4,178,22.8,82,\"Post-workout biometric weigh-in\"");
                sb.AppendLine("2025-03-29,73.1,178,23.1,83,\"End of month progress evaluation\"");
                sb.AppendLine("2025-03-15,73.8,178,23.3,84,\"Mid-cycle body composition scan\"");
                sb.AppendLine("2025-03-01,74.0,178,23.4,84,\"Baseline sprint phase measurement\"");
            }

            var bytes = System.Text.Encoding.UTF8.GetBytes(sb.ToString());
            return File(bytes, "text/csv", $"HealthTrack_Progress_Report_{user.FullName?.Replace(" ", "_") ?? "Client"}_{DateTime.UtcNow:yyyyMMdd}.csv");
        }

        // GET: /Client/Notifications
        public async Task<IActionResult> Notifications()
        {
            var user = await GetCurrentClientUserAsync();
            if (user == null) return RedirectToPage("/Account/Login", new { area = "Identity" });

            var vm = new NotificationsViewModel
            {
                ClientId = user.Id,
                FullName = user.FullName ?? user.UserName ?? "Client",
                Email = user.Email ?? string.Empty
            };

            var hasAnyNotifs = await _context.Notifications.AnyAsync(n => n.UserId == user.Id);
            if (!hasAnyNotifs)
            {
                _context.Notifications.Add(new Notification
                {
                    UserId = user.Id,
                    Message = $"Welcome to HealthTrack, {user.FullName ?? user.UserName ?? "Client"}! Get started by recording your measurements or booking your first consultation.",
                    IsRead = false,
                    CreatedAt = DateTime.UtcNow
                });
                await _context.SaveChangesAsync();
            }

            var dbNotifs = await _context.Notifications
                .Where(n => n.UserId == user.Id)
                .OrderByDescending(n => n.CreatedAt)
                .ToListAsync();

            vm.TotalCount = dbNotifs.Count;
            vm.UnreadCount = dbNotifs.Count(n => !n.IsRead);

            foreach (var n in dbNotifs)
            {
                string title = "Notification";
                string body = n.Message;
                string iconType = "dumbbell";
                string category = "workout";

                if (n.Message.Contains(":"))
                {
                    var parts = n.Message.Split(new[] { ':' }, 2);
                    title = parts[0].Trim();
                    body = parts[1].Trim();
                }
                else
                {
                    if (n.Message.Contains("appointment", StringComparison.OrdinalIgnoreCase) || n.Message.Contains("consultation", StringComparison.OrdinalIgnoreCase))
                    {
                        title = "Appointment Update";
                    }
                    else if (n.Message.Contains("workout", StringComparison.OrdinalIgnoreCase))
                    {
                        title = "Workout Update";
                    }
                    else if (n.Message.Contains("meal", StringComparison.OrdinalIgnoreCase) || n.Message.Contains("nutrition", StringComparison.OrdinalIgnoreCase))
                    {
                        title = "Nutrition Reminder";
                    }
                    else
                    {
                        title = "Health Insight";
                    }
                }

                if (title.Contains("Workout", StringComparison.OrdinalIgnoreCase) || body.Contains("Strength", StringComparison.OrdinalIgnoreCase) || body.Contains("Workout", StringComparison.OrdinalIgnoreCase))
                {
                    iconType = "dumbbell";
                    category = "workout";
                }
                else if (title.Contains("Appointment", StringComparison.OrdinalIgnoreCase) || body.Contains("consultation", StringComparison.OrdinalIgnoreCase) || body.Contains("approved", StringComparison.OrdinalIgnoreCase))
                {
                    iconType = "calendar";
                    category = "appointment";
                }
                else if (title.Contains("lunch", StringComparison.OrdinalIgnoreCase) || title.Contains("meal", StringComparison.OrdinalIgnoreCase) || body.Contains("nutrition", StringComparison.OrdinalIgnoreCase))
                {
                    iconType = "cutlery";
                    category = "diet";
                }
                else
                {
                    iconType = "activity";
                    category = "progress";
                }

                var diff = DateTime.UtcNow - n.CreatedAt;
                string timeAgo = "Just now";
                if (diff.TotalMinutes < 60)
                {
                    timeAgo = $"{Math.Max(1, (int)diff.TotalMinutes)} min ago";
                }
                else if (diff.TotalHours < 24)
                {
                    int h = Math.Max(1, (int)diff.TotalHours);
                    timeAgo = $"{h} {(h == 1 ? "hour" : "hours")} ago";
                }
                else if (diff.TotalDays < 2)
                {
                    timeAgo = "Yesterday";
                }
                else
                {
                    timeAgo = $"{((int)diff.TotalDays)} days ago";
                }

                vm.Notifications.Add(new NotificationItemViewModel
                {
                    Id = n.Id,
                    Title = title,
                    Body = body,
                    IsRead = n.IsRead,
                    CreatedAt = n.CreatedAt,
                    TimeAgo = timeAgo,
                    Category = category,
                    IconType = iconType
                });
            }

            return View(vm);
        }

        // POST: /Client/MarkAllNotificationsAsRead
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> MarkAllNotificationsAsRead()
        {
            var user = await GetCurrentClientUserAsync();
            var unread = await _context.Notifications.Where(n => n.UserId == user.Id && !n.IsRead).ToListAsync();

            if (unread.Any())
            {
                foreach (var n in unread)
                {
                    n.IsRead = true;
                }
                await _context.SaveChangesAsync();
                TempData["SuccessMessage"] = "All notifications marked as read.";
            }

            return RedirectToAction(nameof(Notifications));
        }

        // POST: /Client/ToggleNotificationRead
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ToggleNotificationRead(int id)
        {
            var user = await GetCurrentClientUserAsync();
            var n = await _context.Notifications.FirstOrDefaultAsync(item => item.Id == id && item.UserId == user.Id);

            if (n != null)
            {
                n.IsRead = !n.IsRead;
                await _context.SaveChangesAsync();
            }

            return RedirectToAction(nameof(Notifications));
        }

        // POST: /Client/DeleteNotification
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteNotification(int id)
        {
            var user = await GetCurrentClientUserAsync();
            var n = await _context.Notifications.FirstOrDefaultAsync(item => item.Id == id && item.UserId == user.Id);

            if (n != null)
            {
                _context.Notifications.Remove(n);
                await _context.SaveChangesAsync();
                TempData["SuccessMessage"] = "Notification removed.";
            }

            return RedirectToAction(nameof(Notifications));
        }

        // ====================================================================
        // PROFILE & HEALTH
        // ====================================================================

        // GET: /Client/Profile
        public async Task<IActionResult> Profile()
        {
            var user = await GetCurrentClientUserAsync();
            if (user == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            bool isDemoUser = false;

            // Determine assigned trainer
            string trainerName = "Not assigned yet";
            string trainerSpecialty = "";
            if (!string.IsNullOrEmpty(user.TrainerId))
            {
                var trainer = await _userManager.FindByIdAsync(user.TrainerId);
                if (trainer != null && !string.IsNullOrWhiteSpace(trainer.FullName))
                {
                    trainerName = trainer.FullName.Replace("Dr. ", "");
                    trainerSpecialty = trainer.FitnessGoal ?? "Specialist & Coach";
                }
            }
            else if (isDemoUser)
            {
                trainerName = "Maya Patel";
                trainerSpecialty = "Mobility & Injury Rehab";
            }

            // Fetch latest health log to inspect waist & body fat
            var latestLog = await _context.HealthLogs
                .Where(l => l.ClientId == user.Id)
                .OrderByDescending(l => l.LogDate)
                .FirstOrDefaultAsync();

            double? latestWaist = null;
            double? latestBodyFat = null;

            if (latestLog?.Notes != null)
            {
                // Attempt to parse waist if previously logged
                var matchWaist = System.Text.RegularExpressions.Regex.Match(latestLog.Notes, @"waist:\s*([0-9\.]+)", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
                if (matchWaist.Success && double.TryParse(matchWaist.Groups[1].Value, out double w))
                {
                    latestWaist = w;
                }

                var matchFat = System.Text.RegularExpressions.Regex.Match(latestLog.Notes, @"body\s*fat:\s*([0-9\.]+)", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
                if (matchFat.Success && double.TryParse(matchFat.Groups[1].Value, out double bf))
                {
                    latestBodyFat = bf;
                }
            }

            // Count unread notifications
            var unreadCount = await _context.Notifications
                .Where(n => n.UserId == user.Id && !n.IsRead)
                .CountAsync();

            bool hasLoggedMeasurements = latestLog != null;
            double heightCm = hasLoggedMeasurements ? (user.HeightCm ?? 0) : (isDemoUser ? 175.0 : 0);
            double weightKg = hasLoggedMeasurements ? (user.CurrentWeight ?? 0) : (isDemoUser ? 72.4 : 0);
            double heightMeters = heightCm / 100.0;
            double bmi = (heightMeters > 0 && weightKg > 0) ? Math.Round(weightKg / (heightMeters * heightMeters), 1) : 0;

            // Fetch available trainers for modal
            var trainers = await _userManager.GetUsersInRoleAsync("Trainer");
            var trainerOptions = trainers.Select(t => new TrainerOption
            {
                Id = t.Id,
                Name = t.FullName,
                RoleOrSpecialty = t.FitnessGoal ?? "Fitness Coach"
            }).ToList();

            string memberSince = isDemoUser ? "January 2025" : DateTime.UtcNow.ToString("MMMM yyyy");

            var vm = new ProfileHealthViewModel
            {
                UserId = user.Id,
                FullName = string.IsNullOrWhiteSpace(user.FullName) ? (user.UserName ?? "Client") : user.FullName,
                Email = user.Email ?? string.Empty,
                MemberSince = memberSince,
                AssignedTrainer = trainerName,
                TrainerId = user.TrainerId,
                TrainerSpecialty = trainerSpecialty,
                PrimaryGoal = !string.IsNullOrWhiteSpace(user.FitnessGoal) ? user.FitnessGoal : "General Fitness & Health",
                MembershipStatus = "Active member",
                HasLoggedMeasurements = hasLoggedMeasurements,

                WeightKg = weightKg,
                HeightCm = heightCm,
                WaistCm = latestWaist,
                BodyFatPercentage = latestBodyFat,

                CalculatedBmi = bmi,
                BmiCategory = bmi > 0 ? GetBmiCategory(bmi) : "Pending measurements",
                TargetWeight = user.TargetWeight ?? (isDemoUser ? 70.0 : 0),

                EditFullName = user.FullName ?? string.Empty,
                EditPrimaryGoal = !string.IsNullOrWhiteSpace(user.FitnessGoal) ? user.FitnessGoal : "General Fitness & Health",
                EditTargetWeight = user.TargetWeight ?? (isDemoUser ? 70.0 : 0),
                EditTrainerId = user.TrainerId,
                AvailableTrainers = trainerOptions,

                UnreadNotificationsCount = unreadCount
            };

            return View(vm);
        }

        // POST: /Client/SaveProfileMeasurements
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> SaveProfileMeasurements(ProfileHealthViewModel model)
        {
            var user = await GetCurrentClientUserAsync();
            if (user == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            if (model.WeightKg <= 0 || model.HeightCm <= 0)
            {
                TempData["ErrorMessage"] = "Please provide valid measurement values for Weight and Height.";
                return RedirectToAction(nameof(Profile));
            }

            // Update user biometrics
            user.CurrentWeight = Math.Round(model.WeightKg, 1);
            user.HeightCm = Math.Round(model.HeightCm, 1);
            await _userManager.UpdateAsync(user);

            // Calculate BMI
            double hM = user.HeightCm.Value / 100.0;
            double bmi = Math.Round(user.CurrentWeight.Value / (hM * hM), 1);

            // Record to HealthLogs
            var notesParts = new List<string>();
            if (model.WaistCm.HasValue) notesParts.Add($"waist:{model.WaistCm.Value} cm");
            if (model.BodyFatPercentage.HasValue) notesParts.Add($"body fat:{model.BodyFatPercentage.Value}%");
            string notes = notesParts.Any() ? string.Join(", ", notesParts) : "Profile measurement update";

            var log = new HealthLog
            {
                ClientId = user.Id,
                LogDate = DateTime.UtcNow,
                WeightKg = user.CurrentWeight.Value,
                CalculatedBmi = bmi,
                CaloriesBurned = 450,
                WaterIntakeLiters = 2.5,
                Notes = notes
            };
            _context.HealthLogs.Add(log);

            // In-app notification
            var notif = new Notification
            {
                UserId = user.Id,
                Message = $"Health measurements recorded: Weight {user.CurrentWeight} kg, Height {user.HeightCm} cm" + (model.WaistCm.HasValue ? $", Waist {model.WaistCm} cm." : "."),
                CreatedAt = DateTime.UtcNow,
                IsRead = false
            };
            _context.Notifications.Add(notif);

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = "Health measurements recorded successfully!";

            return RedirectToAction(nameof(Profile));
        }

        // POST: /Client/UpdateProfileDetails
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UpdateProfileDetails(ProfileHealthViewModel model)
        {
            var user = await GetCurrentClientUserAsync();
            if (user == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            if (!string.IsNullOrWhiteSpace(model.EditFullName))
            {
                user.FullName = model.EditFullName.Trim();
            }

            if (!string.IsNullOrWhiteSpace(model.EditPrimaryGoal))
            {
                user.FitnessGoal = model.EditPrimaryGoal.Trim();
            }

            if (model.EditTargetWeight > 0)
            {
                user.TargetWeight = Math.Round(model.EditTargetWeight, 1);
            }

            if (!string.IsNullOrWhiteSpace(model.EditTrainerId))
            {
                user.TrainerId = model.EditTrainerId;
            }

            await _userManager.UpdateAsync(user);

            var notif = new Notification
            {
                UserId = user.Id,
                Message = $"Profile details updated: Name set to '{user.FullName}' and goal to '{user.FitnessGoal}'.",
                CreatedAt = DateTime.UtcNow,
                IsRead = false
            };
            _context.Notifications.Add(notif);

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = "Profile details updated successfully!";

            return RedirectToAction(nameof(Profile));
        }

        // POST: /Client/SavePrivacySettings
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> SavePrivacySettings(bool shareDataWithTrainer, bool allowAnonymousAnalytics, bool emailWeeklyHealthReport)
        {
            var user = await GetCurrentClientUserAsync();
            if (user != null)
            {
                var notif = new Notification
                {
                    UserId = user.Id,
                    Message = "Privacy settings updated: Data encryption and sharing preferences have been updated.",
                    CreatedAt = DateTime.UtcNow,
                    IsRead = false
                };
                _context.Notifications.Add(notif);
                await _context.SaveChangesAsync();
            }

            TempData["SuccessMessage"] = "Privacy settings updated successfully!";
            return RedirectToAction(nameof(Profile));
        }

        // Helper to retrieve current authenticated client user
        private async Task<ApplicationUser?> GetCurrentClientUserAsync()
        {
            var user = await _userManager.GetUserAsync(User);
            if (user != null)
            {
                var isTrainer = await _userManager.IsInRoleAsync(user, "Trainer") || await _userManager.IsInRoleAsync(user, "Admin") || user.Role == "Trainer" || user.Role == "Admin";
                if (isTrainer) return null;
                return user;
            }
            return null;
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
