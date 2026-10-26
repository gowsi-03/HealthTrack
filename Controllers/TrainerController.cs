using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using HealthTrack.Data;
using HealthTrack.Models;
using HealthTrack.Models.ViewModels;

namespace HealthTrack.Controllers
{
    public class TrainerController : Controller
    {
        private readonly ApplicationDbContext _context;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly ILogger<TrainerController> _logger;

        public TrainerController(
            ApplicationDbContext context,
            UserManager<ApplicationUser> userManager,
            ILogger<TrainerController> logger)
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
                var isTrainer = roleClaim == "Trainer" || roleClaim == "Admin" || User.IsInRole("Trainer") || User.IsInRole("Admin");
                if (!isTrainer && (roleClaim == "Client" || User.IsInRole("Client")))
                {
                    context.Result = RedirectToAction("Index", "Client");
                }
            }
        }

        // GET: /Trainer or /Trainer/Index
        public async Task<IActionResult> Index()
        {
            if (User.Identity?.IsAuthenticated == true)
            {
                var authUser = await _userManager.GetUserAsync(User);
                if (authUser != null)
                {
                    var isTrainer = await _userManager.IsInRoleAsync(authUser, "Trainer") || await _userManager.IsInRoleAsync(authUser, "Admin") || authUser.Role == "Trainer" || authUser.Role == "Admin";
                    if (!isTrainer)
                    {
                        // Client user attempted to access Trainer page -> redirect to Client dashboard
                        return RedirectToAction("Index", "Client");
                    }
                    if (authUser.Role == "Trainer" && !authUser.IsApproved)
                    {
                        return RedirectToPage("/Account/TrainerPendingApproval", new { area = "Identity", email = authUser.Email, name = authUser.FullName, fromLogin = true });
                    }
                }
            }

            var trainer = await GetCurrentTrainerUserAsync();
            if (trainer == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            var trainerFirstName = (!string.IsNullOrWhiteSpace(trainer.FullName)) 
                ? trainer.FullName.Replace("Dr. ", "").Trim().Split(' ')[0] 
                : (trainer.UserName?.Split('@')[0] ?? "Trainer");

            // Query Assigned Clients from database
            var clients = await _context.Users
                .Where(u => u.TrainerId == trainer.Id && u.Role == "Client")
                .ToListAsync();

            var apptClientIds = await _context.Appointments
                .Where(a => a.TrainerId == trainer.Id)
                .Select(a => a.ClientId)
                .Distinct()
                .ToListAsync();

            if (apptClientIds.Any())
            {
                var apptClients = await _context.Users
                    .Where(u => u.Role == "Client" && apptClientIds.Contains(u.Id) && !clients.Select(c => c.Id).Contains(u.Id))
                    .ToListAsync();
                clients.AddRange(apptClients);
            }

            int clientCount = clients.Count;

            // Query Active Plans
            var assignedClientIds = clients.Select(c => c.Id).ToList();
            var activeWorkouts = await _context.WorkoutPlans.CountAsync(w => assignedClientIds.Contains(w.ClientId) && w.IsActive);
            var activeDiets = await _context.DietPlans.CountAsync(d => assignedClientIds.Contains(d.ClientId) && d.IsActive);
            int totalPlans = activeWorkouts + activeDiets;

            // Query Upcoming Visits / Appointments
            var upcomingAppts = await _context.Appointments
                .Where(a => a.TrainerId == trainer.Id && a.AppointmentDate >= DateTime.UtcNow.Date)
                .OrderBy(a => a.AppointmentDate)
                .ToListAsync();

            int upcomingVisits = upcomingAppts.Count;

            // Query Available Clients for the Create Plan modal
            var availableClients = await _context.Users
                .Where(u => u.Role == "Client")
                .OrderBy(u => u.FullName)
                .Select(u => new TrainerClientLookupItem
                {
                    Id = u.Id,
                    FullName = u.FullName ?? u.UserName ?? "Client",
                    Email = u.Email ?? string.Empty
                })
                .ToListAsync();

            // Build Pending Requests List from database
            var pendingList = new List<TrainerPendingRequestItem>();

            var dbPending = await _context.Appointments
                .Include(a => a.Client)
                .Where(a => a.TrainerId == trainer.Id && (a.Status == "Pending" || a.Status == "Waiting"))
                .OrderBy(a => a.AppointmentDate)
                .Take(5)
                .ToListAsync();

            foreach (var a in dbPending)
            {
                var cName = a.Client?.FullName ?? "Client";
                var inits = string.Join("", cName.Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(s => s[0])).ToUpper();
                if (inits.Length > 2) inits = inits.Substring(0, 2);
                if (string.IsNullOrEmpty(inits)) inits = "CL";

                var notesShort = a.Notes?.Split('·')[0].Trim() ?? "Consultation";
                if (notesShort.Length > 22) notesShort = notesShort.Substring(0, 22);

                pendingList.Add(new TrainerPendingRequestItem
                {
                    AppointmentId = a.Id,
                    ClientId = a.ClientId,
                    ClientName = cName,
                    Initials = inits,
                    ServiceType = notesShort,
                    AppointmentDateFormatted = a.AppointmentDate.ToString("dd MMM").ToUpper(),
                    TimeSlot = a.TimeSlot,
                    Status = a.Status
                });
            }

            // Build Recent Clients Table dynamically from database
            var recentClients = new List<TrainerClientProgressItem>();
            foreach (var c in clients.Take(4))
            {
                var inits = string.Join("", (c.FullName ?? "Client").Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(s => s[0])).ToUpper();
                if (inits.Length > 2) inits = inits.Substring(0, 2);
                if (string.IsNullOrEmpty(inits)) inits = "CL";

                var latestWorkout = await _context.WorkoutPlans
                    .Include(w => w.Exercises)
                    .Where(w => w.ClientId == c.Id && w.IsActive)
                    .OrderByDescending(w => w.CreatedAt)
                    .FirstOrDefaultAsync()
                    ?? await _context.WorkoutPlans
                        .Include(w => w.Exercises)
                        .Where(w => w.ClientId == c.Id)
                        .OrderByDescending(w => w.CreatedAt)
                        .FirstOrDefaultAsync();
                var planName = latestWorkout?.Title ?? (!string.IsNullOrEmpty(c.FitnessGoal) ? c.FitnessGoal : "Custom Wellness Plan");

                int clientCompRate = 0;
                if (latestWorkout != null && latestWorkout.Exercises.Any())
                {
                    int doneEx = latestWorkout.Exercises.Count(e => e.IsCompleted);
                    clientCompRate = (int)Math.Round((double)doneEx / latestWorkout.Exercises.Count * 100);
                }

                var logs = await _context.HealthLogs
                    .Where(h => h.ClientId == c.Id)
                    .OrderBy(h => h.LogDate)
                    .ToListAsync();

                string weightChange = "0.0 kg";
                bool isLoss = true;
                if (logs.Count >= 2)
                {
                    double diff = Math.Round(logs.Last().WeightKg - logs.First().WeightKg, 1);
                    weightChange = diff <= 0 ? $"{diff:F1} kg" : $"+{diff:F1} kg";
                    isLoss = diff <= 0;
                }
                else if (c.CurrentWeight.HasValue && c.TargetWeight.HasValue)
                {
                    double diff = Math.Round(c.CurrentWeight.Value - c.TargetWeight.Value, 1);
                    weightChange = diff >= 0 ? $"-{diff:F1} kg" : $"+{Math.Abs(diff):F1} kg";
                    isLoss = diff >= 0;
                }

                recentClients.Add(new TrainerClientProgressItem
                {
                    ClientId = c.Id,
                    ClientName = c.FullName ?? "Client",
                    Initials = inits,
                    ActivePlan = planName,
                    CompletionPercentage = clientCompRate,
                    WeightChange = weightChange,
                    IsWeightLoss = isLoss,
                    Status = latestWorkout != null ? "Active" : "New Client"
                });
            }

            // Unread notifications for trainer
            var unreadCount = await _context.Notifications
                .Where(n => n.UserId == trainer.Id && !n.IsRead)
                .CountAsync();

            string clientTrend = clientCount > 0 ? $"{clientCount} active client{(clientCount == 1 ? "" : "s")}" : "0 enrolled clients";
            string plansTrend = totalPlans > 0 ? $"{totalPlans} active program{(totalPlans == 1 ? "" : "s")}" : "0 active programs";
            string visitsTrend = upcomingVisits > 0 ? $"{upcomingVisits} upcoming session{(upcomingVisits == 1 ? "" : "s")}" : "0 upcoming sessions";

            var now = DateTime.UtcNow;
            var weeklyDates = new List<DateTime>
            {
                now.AddDays(-28),
                now.AddDays(-21),
                now.AddDays(-14),
                now.AddDays(-7),
                now
            };
            var chartLabels = weeklyDates.Select(d => d.ToString("MMM dd")).ToList();

            // Query real workout exercises to calculate dynamic average completion of active protocols
            var clientWorkouts = await _context.WorkoutPlans
                .Include(w => w.Exercises)
                .Where(w => assignedClientIds.Contains(w.ClientId) && w.IsActive)
                .ToListAsync();

            if (!clientWorkouts.Any())
            {
                clientWorkouts = await _context.WorkoutPlans
                    .Include(w => w.Exercises)
                    .Where(w => assignedClientIds.Contains(w.ClientId))
                    .ToListAsync();
            }

            int totalExercises = clientWorkouts.SelectMany(w => w.Exercises).Count();
            int completedExercises = clientWorkouts.SelectMany(w => w.Exercises).Count(e => e.IsCompleted);
            double realRate = totalExercises > 0
                ? Math.Round((double)completedExercises / totalExercises * 100.0, 1)
                : 0.0;

            List<double> dynamicChartValues = new();
            string dynamicChangeText;

            if (totalExercises > 0 && completedExercises > 0)
            {
                // True timeline: prior weeks where no workouts existed remain at 0%
                foreach (var targetDate in weeklyDates)
                {
                    if (targetDate.Date == now.Date)
                    {
                        dynamicChartValues.Add(realRate);
                    }
                    else
                    {
                        var workoutsOnDate = clientWorkouts
                            .Where(w => w.CreatedAt.Date <= targetDate.Date)
                            .ToList();

                        if (!workoutsOnDate.Any())
                        {
                            dynamicChartValues.Add(0.0);
                        }
                        else
                        {
                            int wTotal = workoutsOnDate.SelectMany(w => w.Exercises).Count();
                            int wDone = workoutsOnDate.SelectMany(w => w.Exercises).Count(e => e.IsCompleted);
                            double pastRate = wTotal > 0 ? Math.Round((double)wDone / wTotal * 100.0, 1) : 0.0;
                            dynamicChartValues.Add(pastRate);
                        }
                    }
                }
                dynamicChangeText = $"+{realRate}% completion";
            }
            else if (totalExercises > 0)
            {
                dynamicChangeText = "Awaiting exercise completion";
            }
            else
            {
                dynamicChangeText = clientCount > 0 ? "No active routines yet" : "No activity yet";
            }

            var vm = new TrainerDashboardViewModel
            {
                TrainerId = trainer.Id,
                TrainerName = trainerFirstName,
                TrainerFullName = trainer.FullName,
                TrainerEmail = trainer.Email ?? string.Empty,
                DateFormatted = DateTime.UtcNow.ToString("dddd, MMMM d").ToUpper(),

                AssignedClientsCount = clientCount,
                AssignedClientsTrend = clientTrend,

                ActivePlansCount = totalPlans,
                ActivePlansTrend = plansTrend,

                UpcomingVisitsCount = upcomingVisits,
                UpcomingVisitsTrend = visitsTrend,

                AverageCompletionRate = realRate,
                MonthlyChangeRate = dynamicChangeText,
                ChartLabels = dynamicChartValues.Any() ? chartLabels : new List<string>(),
                ChartValues = dynamicChartValues,

                PendingRequests = pendingList,
                RecentClients = recentClients,
                AvailableClients = availableClients,
                UnreadNotificationsCount = unreadCount,
                ShowFirstTimeSetup = !trainer.IsProfileCompleted,
                TrainerSpecialty = string.IsNullOrWhiteSpace(trainer.FitnessGoal) ? "General Fitness" : trainer.FitnessGoal
            };

            return View(vm);
        }

        // POST: /Trainer/ApproveAppointment
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ApproveAppointment(int id, string? returnUrl = null)
        {
            var trainer = await GetCurrentTrainerUserAsync();
            var appt = await _context.Appointments.Include(a => a.Client).FirstOrDefaultAsync(a => a.Id == id);

            if (appt != null)
            {
                appt.Status = "Approved";

                // Automatically link client to this trainer if not already assigned
                if (appt.Client != null && string.IsNullOrEmpty(appt.Client.TrainerId))
                {
                    appt.Client.TrainerId = trainer.Id;
                }

                // Notify client
                var notif = new Notification
                {
                    UserId = appt.ClientId,
                    Message = $"Appointment approved: {trainer.FullName} confirmed your {appt.Notes?.Split('·')[0].Trim() ?? "consultation"} on {appt.AppointmentDate:dd MMM} at {appt.TimeSlot}.",
                    CreatedAt = DateTime.UtcNow,
                    IsRead = false
                };
                _context.Notifications.Add(notif);

                await _context.SaveChangesAsync();
                TempData["SuccessMessage"] = $"Appointment for {appt.Client?.FullName ?? "Client"} approved successfully!";
            }
            else
            {
                TempData["SuccessMessage"] = "Appointment approved successfully!";
            }

            if (!string.IsNullOrEmpty(returnUrl)) return LocalRedirect(returnUrl);
            return RedirectToAction(nameof(Appointments));
        }

        // POST: /Trainer/CancelAppointment
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CancelAppointment(int id, string? returnUrl = null)
        {
            var trainer = await GetCurrentTrainerUserAsync();
            var appt = await _context.Appointments.Include(a => a.Client).FirstOrDefaultAsync(a => a.Id == id);

            if (appt != null)
            {
                appt.Status = "Cancelled";

                var notif = new Notification
                {
                    UserId = appt.ClientId,
                    Message = $"Appointment cancelled: Your consultation on {appt.AppointmentDate:dd MMM} was cancelled by {trainer.FullName}.",
                    CreatedAt = DateTime.UtcNow,
                    IsRead = false
                };
                _context.Notifications.Add(notif);

                await _context.SaveChangesAsync();
                TempData["SuccessMessage"] = "Appointment cancelled.";
            }

            if (!string.IsNullOrEmpty(returnUrl)) return LocalRedirect(returnUrl);
            return RedirectToAction(nameof(Appointments));
        }

        // POST: /Trainer/CreatePlan
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreatePlan(CreatePlanFormModel model)
        {
            var trainer = await GetCurrentTrainerUserAsync();
            if (trainer == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            if (string.IsNullOrWhiteSpace(model.Title))
            {
                TempData["ErrorMessage"] = "Please specify a plan title.";
                return RedirectToAction(nameof(Index));
            }

            if (string.IsNullOrWhiteSpace(model.ClientId))
            {
                TempData["ErrorMessage"] = "Please select a client to assign a plan.";
                return RedirectToAction(nameof(Index));
            }

            var client = await _userManager.FindByIdAsync(model.ClientId);
            if (client == null)
            {
                TempData["ErrorMessage"] = "Selected client was not found.";
                return RedirectToAction(nameof(Index));
            }

            if (model.PlanType == "Diet")
            {
                // Archive previous active diet plans for this client
                var previousDiets = await _context.DietPlans
                    .Where(d => d.ClientId == client.Id && d.IsActive)
                    .ToListAsync();
                foreach (var pd in previousDiets) pd.IsActive = false;

                var diet = new DietPlan
                {
                    ClientId = client.Id,
                    Title = model.Title,
                    TargetCalories = model.TargetCalories > 0 ? model.TargetCalories : 2100,
                    IsActive = true,
                    CreatedAt = DateTime.UtcNow
                };

                // Add sample meal items
                diet.Meals.Add(new MealItem { MealType = "Breakfast", Description = "Oatmeal with berries and protein shake", Calories = 450 });
                diet.Meals.Add(new MealItem { MealType = "Lunch", Description = "Grilled chicken quinoa salad", Calories = 650 });
                diet.Meals.Add(new MealItem { MealType = "Dinner", Description = "Baked salmon with steamed asparagus and brown rice", Calories = 600 });
                diet.Meals.Add(new MealItem { MealType = "Snack", Description = "Greek yogurt with crushed almonds", Calories = 250 });

                _context.DietPlans.Add(diet);
            }
            else
            {
                // Archive previous active workout plans for this client
                var previousWorkouts = await _context.WorkoutPlans
                    .Where(w => w.ClientId == client.Id && w.IsActive)
                    .ToListAsync();
                foreach (var pw in previousWorkouts)
                {
                    pw.IsActive = false;
                    pw.CompletedAt = DateTime.UtcNow;
                }

                var workout = new WorkoutPlan
                {
                    ClientId = client.Id,
                    TrainerId = trainer.Id,
                    Title = model.Title,
                    Description = model.Description ?? "Personalized progressive training routine.",
                    IsActive = true,
                    CreatedAt = DateTime.UtcNow
                };

                workout.Exercises.Add(new WorkoutExercise { Name = "Barbell Squats", Sets = "4 sets", Reps = "8-10 reps", IsCompleted = false });
                workout.Exercises.Add(new WorkoutExercise { Name = "Dumbbell Bench Press", Sets = "3 sets", Reps = "10-12 reps", IsCompleted = false });
                workout.Exercises.Add(new WorkoutExercise { Name = "Romanian Deadlifts", Sets = "3 sets", Reps = "10 reps", IsCompleted = false });
                workout.Exercises.Add(new WorkoutExercise { Name = "Plank & Core Hold", Sets = "3 sets", Reps = "45 sec", IsCompleted = false });

                _context.WorkoutPlans.Add(workout);
            }

            // Send notification to client
            var notif = new Notification
            {
                UserId = client.Id,
                Message = $"New plan assigned: {trainer.FullName} created '{model.Title}' for your routine.",
                CreatedAt = DateTime.UtcNow,
                IsRead = false
            };
            _context.Notifications.Add(notif);

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"New {model.PlanType.ToLower()} plan '{model.Title}' assigned to {client.FullName} successfully!";

            return RedirectToAction(nameof(Index));
        }

        // ====================================================================
        // MY CLIENTS (Matching media_1792643462910_78b85980.png)
        // ====================================================================

        // GET: /Trainer/Clients or /Trainer/MyClients
        public async Task<IActionResult> Clients(string? search = null, string? status = null, string? plan = null, int page = 1)
        {
            if (User.Identity?.IsAuthenticated == true)
            {
                var authUser = await _userManager.GetUserAsync(User);
                if (authUser != null)
                {
                    var isTrainer = await _userManager.IsInRoleAsync(authUser, "Trainer") || await _userManager.IsInRoleAsync(authUser, "Admin") || authUser.Role == "Trainer" || authUser.Role == "Admin";
                    if (!isTrainer)
                    {
                        // Client user attempted to access Trainer page -> redirect to Client dashboard
                        return RedirectToAction("Index", "Client");
                    }
                    if (authUser.Role == "Trainer" && !authUser.IsApproved)
                    {
                        return RedirectToPage("/Account/TrainerPendingApproval", new { area = "Identity", email = authUser.Email, name = authUser.FullName, fromLogin = true });
                    }
                }
            }

            var trainer = await GetCurrentTrainerUserAsync();
            if (trainer == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            var allClients = new List<TrainerClientItem>();

            // Query strictly clients assigned to this trainer
            var dbClients = await _context.Users
                .Where(u => u.Role == "Client" && u.TrainerId == trainer.Id)
                .ToListAsync();

            foreach (var dbc in dbClients)
            {
                var inits = string.Join("", (dbc.FullName ?? "Client").Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(s => s[0])).ToUpper();
                if (inits.Length > 2) inits = inits.Substring(0, 2);
                if (string.IsNullOrEmpty(inits)) inits = "CL";

                var latestWorkout = await _context.WorkoutPlans
                    .Include(w => w.Exercises)
                    .Where(w => w.ClientId == dbc.Id && w.IsActive)
                    .OrderByDescending(w => w.CreatedAt)
                    .FirstOrDefaultAsync()
                    ?? await _context.WorkoutPlans
                        .Include(w => w.Exercises)
                        .Where(w => w.ClientId == dbc.Id)
                        .OrderByDescending(w => w.CreatedAt)
                        .FirstOrDefaultAsync();
                var planName = latestWorkout?.Title ?? (!string.IsNullOrEmpty(dbc.FitnessGoal) ? dbc.FitnessGoal : "Custom Wellness Plan");

                int clientCompRate = 0;
                if (latestWorkout != null && latestWorkout.Exercises.Any())
                {
                    int doneEx = latestWorkout.Exercises.Count(e => e.IsCompleted);
                    clientCompRate = (int)Math.Round((double)doneEx / latestWorkout.Exercises.Count * 100);
                }

                var logs = await _context.HealthLogs
                    .Where(h => h.ClientId == dbc.Id)
                    .OrderBy(h => h.LogDate)
                    .ToListAsync();

                string weightChange = "0.0 kg";
                bool isLoss = true;
                if (logs.Count >= 2)
                {
                    double diff = Math.Round(logs.Last().WeightKg - logs.First().WeightKg, 1);
                    weightChange = diff <= 0 ? $"{diff:F1} kg" : $"+{diff:F1} kg";
                    isLoss = diff <= 0;
                }
                else if (dbc.CurrentWeight.HasValue && dbc.TargetWeight.HasValue)
                {
                    double diff = Math.Round(dbc.CurrentWeight.Value - dbc.TargetWeight.Value, 1);
                    weightChange = diff >= 0 ? $"-{diff:F1} kg" : $"+{Math.Abs(diff):F1} kg";
                    isLoss = diff >= 0;
                }

                double curW = dbc.CurrentWeight ?? (logs.Any() ? logs.Last().WeightKg : 0.0);
                double tarW = dbc.TargetWeight ?? 0.0;
                string clientStatus = logs.Count == 0 && (dbc.CurrentWeight == null) ? "New Client" : "Active";

                allClients.Add(new TrainerClientItem
                {
                    Id = dbc.Id,
                    FullName = dbc.FullName ?? "Client",
                    Email = dbc.Email ?? string.Empty,
                    Initials = inits,
                    ActivePlan = planName,
                    CompletionPercentage = clientCompRate,
                    WeightChange = weightChange,
                    IsWeightLoss = isLoss,
                    Status = clientStatus,
                    CurrentWeight = curW,
                    TargetWeight = tarW,
                    JoinedDate = dbc.CreatedAt > DateTime.MinValue ? dbc.CreatedAt.ToString("MMM yyyy") : DateTime.UtcNow.ToString("MMM yyyy")
                });
            }

            // Filtering
            var filtered = allClients.AsEnumerable();

            if (!string.IsNullOrWhiteSpace(search))
            {
                var q = search.Trim().ToLower();
                filtered = filtered.Where(c => c.FullName.ToLower().Contains(q) || c.Email.ToLower().Contains(q));
            }

            if (!string.IsNullOrWhiteSpace(status) && !status.Equals("All", StringComparison.OrdinalIgnoreCase))
            {
                filtered = filtered.Where(c => c.Status.Equals(status, StringComparison.OrdinalIgnoreCase));
            }

            if (!string.IsNullOrWhiteSpace(plan) && !plan.Equals("All", StringComparison.OrdinalIgnoreCase))
            {
                filtered = filtered.Where(c => c.ActivePlan.Equals(plan, StringComparison.OrdinalIgnoreCase));
            }

            var filteredList = filtered.ToList();

            // Pagination calculated dynamically from live records (8 clients per page)
            int pageSize = 8;
            int totalResults = filteredList.Count;
            int totalPages = (int)Math.Ceiling((double)totalResults / pageSize);
            if (totalPages < 1) totalPages = 1;
            if (page < 1) page = 1;
            if (page > totalPages) page = totalPages;

            var pagedItems = filteredList.Skip((page - 1) * pageSize).Take(pageSize).ToList();

            var unreadCount = await _context.Notifications
                .Where(n => n.UserId == trainer.Id && !n.IsRead)
                .CountAsync();

            var vm = new TrainerClientsViewModel
            {
                TrainerName = (!string.IsNullOrWhiteSpace(trainer.FullName)) ? trainer.FullName.Replace("Dr. ", "") : (trainer.UserName?.Split('@')[0] ?? "Trainer"),
                TrainerEmail = trainer.Email ?? string.Empty,
                TrainerInitials = GetUserInitials(trainer.FullName, "TR"),
                TotalClientsCount = allClients.Count,
                ActiveClientsCount = allClients.Count(c => c.Status == "Active"),
                AtRiskClientsCount = allClients.Count(c => c.Status == "At risk"),
                TotalResultsCount = totalResults,
                PageSize = pageSize,
                SearchTerm = search ?? string.Empty,
                SelectedStatus = status ?? "All",
                SelectedPlan = plan ?? "All",
                CurrentPage = page,
                TotalPages = totalPages,
                Clients = pagedItems,
                UnreadNotificationsCount = unreadCount
            };

            return View(vm);
        }

        // POST: /Trainer/AddClient
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddClient(AddClientFormModel model)
        {
            var trainer = await GetCurrentTrainerUserAsync();
            if (trainer == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            if (string.IsNullOrWhiteSpace(model.FullName) || string.IsNullOrWhiteSpace(model.Email))
            {
                TempData["ErrorMessage"] = "Client full name and email are required.";
                return RedirectToAction(nameof(Clients));
            }

            var existing = await _userManager.FindByEmailAsync(model.Email);
            if (existing == null)
            {
                var newUser = new ApplicationUser
                {
                    UserName = model.Email.Trim(),
                    Email = model.Email.Trim(),
                    FullName = model.FullName.Trim(),
                    Role = "Client",
                    FitnessGoal = model.FitnessGoal ?? "Strength & mobility",
                    HeightCm = model.HeightCm > 0 ? model.HeightCm : 175.0,
                    CurrentWeight = model.CurrentWeight > 0 ? model.CurrentWeight : 70.0,
                    TargetWeight = model.TargetWeight > 0 ? model.TargetWeight : 68.0,
                    TrainerId = trainer.Id,
                    EmailConfirmed = true
                };

                var res = await _userManager.CreateAsync(newUser, "Client123!");
                if (res.Succeeded)
                {
                    await _userManager.AddToRoleAsync(newUser, "Client");
                }
            }
            else
            {
                existing.TrainerId = trainer.Id;
                await _userManager.UpdateAsync(existing);
            }

            TempData["SuccessMessage"] = $"Client '{model.FullName}' added to your care roster!";
            return RedirectToAction(nameof(Clients));
        }

        // ====================================================================
        // WORKOUT PLANS MANAGEMENT (Trainer Portal)
        // ====================================================================

        // GET: /Trainer/Workouts
        public async Task<IActionResult> Workouts()
        {
            var trainer = await GetCurrentTrainerUserAsync();
            if (trainer == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            // Query strictly clients assigned to this trainer
            var dbClients = await _context.Users
                .Where(u => u.Role == "Client" && u.TrainerId == trainer.Id)
                .ToListAsync();

            var availableClients = dbClients.Select(c => new ClientDropdownOption
            {
                Id = c.Id,
                FullName = c.FullName ?? "Client",
                Email = c.Email ?? string.Empty
            }).ToList();

            var dbTemplates = await _context.WorkoutTemplates
                .OrderByDescending(t => t.CreatedAt)
                .ToListAsync();

            if (!dbTemplates.Any())
            {
                var seedList = new List<WorkoutTemplate>
                {
                    new WorkoutTemplate
                    {
                        Title = "Foundation Strength",
                        Category = "Strength & Mobility",
                        DurationWeeks = 8,
                        DaysPerWeek = 4,
                        MinutesPerSession = 45,
                        Description = "A progressive full-body program designed to improve multi-joint strength, mobility and athletic endurance.",
                        BadgeClass = "badge-teal",
                        CreatedAt = DateTime.UtcNow.AddDays(-30)
                    },
                    new WorkoutTemplate
                    {
                        Title = "Cardio & Athletic Endurance",
                        Category = "Cardio Conditioning",
                        DurationWeeks = 6,
                        DaysPerWeek = 3,
                        MinutesPerSession = 50,
                        Description = "Targeted aerobic capacity and interval metabolic conditioning for functional cardiovascular fitness.",
                        BadgeClass = "badge-blue",
                        CreatedAt = DateTime.UtcNow.AddDays(-25)
                    },
                    new WorkoutTemplate
                    {
                        Title = "Hypertrophy Push / Pull Split",
                        Category = "Hypertrophy",
                        DurationWeeks = 12,
                        DaysPerWeek = 5,
                        MinutesPerSession = 60,
                        Description = "Periodized multi-angle resistance split optimizing lean muscle protein synthesis and compound movement mastery.",
                        BadgeClass = "badge-purple",
                        CreatedAt = DateTime.UtcNow.AddDays(-20)
                    },
                    new WorkoutTemplate
                    {
                        Title = "Posture & Core Mobility",
                        Category = "Rehab & Posture",
                        DurationWeeks = 4,
                        DaysPerWeek = 3,
                        MinutesPerSession = 35,
                        Description = "Spinal decompression, glute activation, rotator cuff integrity, and deep anterior core stabilization.",
                        BadgeClass = "badge-amber",
                        CreatedAt = DateTime.UtcNow.AddDays(-15)
                    }
                };
                _context.WorkoutTemplates.AddRange(seedList);
                await _context.SaveChangesAsync();
                dbTemplates = seedList;
            }

            var allWorkoutPlans = await _context.WorkoutPlans.ToListAsync();
            var templates = dbTemplates.Select(t =>
            {
                var assignedCount = allWorkoutPlans.Count(w =>
                    w.Title.Equals(t.Title, StringComparison.OrdinalIgnoreCase) ||
                    w.Title.StartsWith(t.Title, StringComparison.OrdinalIgnoreCase) ||
                    w.Title.IndexOf(t.Title, StringComparison.OrdinalIgnoreCase) >= 0);

                return new WorkoutTemplateItem
                {
                    Id = t.Id.ToString(),
                    Title = t.Title,
                    Category = t.Category,
                    DurationWeeks = t.DurationWeeks,
                    DaysPerWeek = t.DaysPerWeek,
                    MinutesPerSession = t.MinutesPerSession,
                    AssignedClientsCount = assignedCount,
                    Description = t.Description ?? string.Empty,
                    BadgeClass = !string.IsNullOrEmpty(t.BadgeClass) ? t.BadgeClass : "badge-teal"
                };
            }).ToList();

            // Query live workout routines from database
            var dbRoutines = await _context.WorkoutPlans
                .Include(w => w.Client)
                .Include(w => w.Exercises)
                .OrderByDescending(w => w.CreatedAt)
                .ToListAsync();

            var clientRoutines = new List<ClientWorkoutRoutineItem>();
            foreach (var r in dbRoutines)
            {
                var cName = r.Client?.FullName ?? "Client";
                var inits = string.Join("", cName.Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(s => s[0])).ToUpper();
                if (inits.Length > 2) inits = inits.Substring(0, 2);
                if (string.IsNullOrEmpty(inits)) inits = "CL";

                int totalEx = r.Exercises.Count;
                int completedEx = r.Exercises.Count(e => e.IsCompleted);
                int compPercentage = totalEx > 0 ? (int)Math.Round((double)completedEx / totalEx * 100) : 0;

                string statusText = r.IsActive ? "Active" : (compPercentage == 100 ? "Completed" : "Archived");
                string lastSessionText = r.IsActive 
                    ? (completedEx > 0 ? $"{completedEx} of {totalEx} Completed" : "Awaiting start") 
                    : (r.CompletedAt.HasValue ? $"Completed {r.CompletedAt.Value:MMM dd}" : "Archived Routine");

                clientRoutines.Add(new ClientWorkoutRoutineItem
                {
                    ClientId = r.ClientId,
                    ClientName = cName,
                    ClientEmail = r.Client?.Email ?? "",
                    ClientInitials = inits,
                    RoutineTitle = r.Title,
                    Category = "Strength & Mobility",
                    DurationText = !string.IsNullOrEmpty(r.Description) ? r.Description : $"{totalEx} exercises",
                    CompletionPercentage = compPercentage,
                    Status = statusText,
                    LastCompletedSession = lastSessionText
                });
            }

            var unreadCount = await _context.Notifications
                .Where(n => n.UserId == trainer.Id && !n.IsRead)
                .CountAsync();

            var activeRoutines = clientRoutines.Where(r => r.Status == "Active").ToList();

            var vm = new TrainerWorkoutsViewModel
            {
                TrainerName = (!string.IsNullOrWhiteSpace(trainer.FullName)) ? trainer.FullName.Replace("Dr. ", "") : (trainer.UserName?.Split('@')[0] ?? "Trainer"),
                TrainerEmail = trainer.Email ?? string.Empty,
                TrainerInitials = GetUserInitials(trainer.FullName, "TR"),
                UnreadNotificationsCount = unreadCount,
                TotalActiveProgramsCount = activeRoutines.Count,
                TotalTemplatesCount = templates.Count,
                AvgCompletionRate = activeRoutines.Any() 
                    ? (int)Math.Round(activeRoutines.Average(r => r.CompletionPercentage)) 
                    : (clientRoutines.Any() ? (int)Math.Round(clientRoutines.Average(r => r.CompletionPercentage)) : 0),
                WeeklyCompletedSessions = clientRoutines.Count(r => r.CompletionPercentage > 0),
                Templates = templates,
                ClientRoutines = clientRoutines,
                AvailableClients = availableClients
            };

            return View(vm);
        }

        // POST: /Trainer/CreateWorkoutPlan
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateWorkoutPlan(CreateWorkoutRoutineFormModel model)
        {
            var trainer = await GetCurrentTrainerUserAsync();
            if (trainer == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            if (string.IsNullOrWhiteSpace(model.Title))
            {
                TempData["ErrorMessage"] = "Workout routine title is required.";
                return RedirectToAction(nameof(Workouts));
            }

            if (string.IsNullOrWhiteSpace(model.ClientId))
            {
                TempData["ErrorMessage"] = "Please select a client to assign this workout routine.";
                return RedirectToAction(nameof(Workouts));
            }

            var client = await _userManager.FindByIdAsync(model.ClientId);
            if (client == null)
            {
                TempData["ErrorMessage"] = "Selected client was not found.";
                return RedirectToAction(nameof(Workouts));
            }

            if (client != null)
            {
                if (string.IsNullOrEmpty(client.TrainerId))
                {
                    client.TrainerId = trainer.Id;
                }

                // Archive previous active workout plans for this client
                var previousWorkouts = await _context.WorkoutPlans
                    .Where(w => w.ClientId == client.Id && w.IsActive)
                    .ToListAsync();
                foreach (var pw in previousWorkouts)
                {
                    pw.IsActive = false;
                    pw.CompletedAt = DateTime.UtcNow;
                }

                var newPlan = new WorkoutPlan
                {
                    Title = model.Title.Trim(),
                    Description = !string.IsNullOrWhiteSpace(model.Description) 
                        ? model.Description.Trim() 
                        : $"{model.DurationWeeks} Weeks · {model.DaysPerWeek} days/week",
                    ClientId = client.Id,
                    TrainerId = trainer.Id,
                    IsActive = true,
                    CreatedAt = DateTime.UtcNow
                };

                if (!string.IsNullOrWhiteSpace(model.ExercisesText))
                {
                    var lines = model.ExercisesText.Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
                    foreach (var line in lines)
                    {
                        var trimmed = line.Trim().TrimStart('-', '*', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '.', ' ');
                        if (string.IsNullOrWhiteSpace(trimmed)) continue;
                        var parts = trimmed.Split('-');
                        var exName = parts[0].Trim();
                        var setsReps = parts.Length > 1 ? parts[1].Trim() : "3 sets x 10 reps";
                        newPlan.Exercises.Add(new WorkoutExercise { Name = exName, Sets = setsReps, Reps = "" });
                    }
                }

                if (!newPlan.Exercises.Any())
                {
                    newPlan.Exercises.Add(new WorkoutExercise { Name = "Barbell Squats", Sets = "3 sets", Reps = "10 reps" });
                    newPlan.Exercises.Add(new WorkoutExercise { Name = "Dumbbell Bench Press", Sets = "3 sets", Reps = "12 reps" });
                    newPlan.Exercises.Add(new WorkoutExercise { Name = "Romanian Deadlifts", Sets = "3 sets", Reps = "10 reps" });
                    newPlan.Exercises.Add(new WorkoutExercise { Name = "Plank Hold", Sets = "3 sets", Reps = "45 sec" });
                }

                _context.WorkoutPlans.Add(newPlan);

                var notif = new Notification
                {
                    UserId = client.Id,
                    Message = $"Your trainer {trainer.FullName} assigned a new workout routine: '{model.Title}'.",
                    CreatedAt = DateTime.UtcNow,
                    IsRead = false
                };
                _context.Notifications.Add(notif);

                await _context.SaveChangesAsync();
            }

            TempData["SuccessMessage"] = $"Workout routine '{model.Title}' created and assigned to client successfully!";
            return RedirectToAction(nameof(Workouts));
        }

        // POST: /Trainer/CreateWorkoutTemplate
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateWorkoutTemplate(CreateWorkoutTemplateFormModel model)
        {
            var trainer = await GetCurrentTrainerUserAsync();
            if (trainer == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            if (string.IsNullOrWhiteSpace(model.Title))
            {
                TempData["ErrorMessage"] = "Workout template title is required.";
                return RedirectToAction(nameof(Workouts));
            }

            string badgeClass = "badge-teal";
            var cat = (model.Category ?? "").ToLower();
            if (cat.Contains("cardio") || cat.Contains("endurance")) badgeClass = "badge-blue";
            else if (cat.Contains("hypertrophy") || cat.Contains("muscle")) badgeClass = "badge-purple";
            else if (cat.Contains("rehab") || cat.Contains("posture") || cat.Contains("mobility")) badgeClass = "badge-amber";
            else if (cat.Contains("weight") || cat.Contains("hiit")) badgeClass = "badge-rose";

            var tpl = new WorkoutTemplate
            {
                Title = model.Title.Trim(),
                Category = string.IsNullOrWhiteSpace(model.Category) ? "Strength & Mobility" : model.Category.Trim(),
                DurationWeeks = model.DurationWeeks > 0 ? model.DurationWeeks : 8,
                DaysPerWeek = model.DaysPerWeek > 0 ? model.DaysPerWeek : 4,
                MinutesPerSession = model.MinutesPerSession > 0 ? model.MinutesPerSession : 45,
                Description = !string.IsNullOrWhiteSpace(model.Description)
                    ? model.Description.Trim()
                    : $"A progressive {model.DurationWeeks}-week program structured for {model.DaysPerWeek} sessions per week.",
                BadgeClass = badgeClass,
                ExercisesText = model.ExercisesText,
                TrainerId = trainer.Id,
                CreatedAt = DateTime.UtcNow
            };

            _context.WorkoutTemplates.Add(tpl);
            await _context.SaveChangesAsync();

            TempData["SuccessMessage"] = $"Workout template '{tpl.Title}' created successfully! It is now available in your Program Templates Library.";
            return RedirectToAction(nameof(Workouts));
        }

        // ====================================================================
        // DIET & NUTRITION MANAGEMENT (Trainer Portal)
        // ====================================================================

        // GET: /Trainer/Diet
        public async Task<IActionResult> Diet()
        {
            var trainer = await GetCurrentTrainerUserAsync();
            if (trainer == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            // Query strictly clients assigned to this trainer
            var dbClients = await _context.Users
                .Where(u => u.Role == "Client" && u.TrainerId == trainer.Id)
                .ToListAsync();

            var availableClients = dbClients.Select(c => new ClientDropdownOption
            {
                Id = c.Id,
                FullName = c.FullName ?? "Client",
                Email = c.Email ?? string.Empty
            }).ToList();

            var dbDietTemplates = await _context.DietTemplates
                .OrderByDescending(t => t.CreatedAt)
                .ToListAsync();

            if (!dbDietTemplates.Any())
            {
                var seedList = new List<DietTemplate>
                {
                    new DietTemplate
                    {
                        Title = "Balanced Performance Plan",
                        Category = "Balanced Nutrition",
                        DailyCalories = 2150,
                        ProteinGrams = 120,
                        MealsPerDay = 4,
                        Description = "Nutrient-dense whole food meals designed to support energy equilibrium, active training, and lean body mass.",
                        BadgeClass = "badge-teal",
                        CreatedAt = DateTime.UtcNow.AddDays(-30)
                    },
                    new DietTemplate
                    {
                        Title = "High-Protein Fat Loss",
                        Category = "Caloric Deficit",
                        DailyCalories = 1850,
                        ProteinGrams = 145,
                        MealsPerDay = 4,
                        Description = "Moderate caloric deficit with high protein satiety protecting metabolic rate and lean muscular tone.",
                        BadgeClass = "badge-blue",
                        CreatedAt = DateTime.UtcNow.AddDays(-25)
                    },
                    new DietTemplate
                    {
                        Title = "Lean Mass Hypertrophy Protocol",
                        Category = "Mass Building",
                        DailyCalories = 2600,
                        ProteinGrams = 160,
                        MealsPerDay = 5,
                        Description = "Caloric surplus with high-carb intra-workout timing maximizing muscle glycogen replenishment and hypertrophy.",
                        BadgeClass = "badge-purple",
                        CreatedAt = DateTime.UtcNow.AddDays(-20)
                    },
                    new DietTemplate
                    {
                        Title = "Plant-Based Metabolic Fuel",
                        Category = "Vegan & Plant",
                        DailyCalories = 2000,
                        ProteinGrams = 105,
                        MealsPerDay = 4,
                        Description = "Whole food plant-based protocol rich in polyphenols, micronutrients, complex fiber and clean plant proteins.",
                        BadgeClass = "badge-amber",
                        CreatedAt = DateTime.UtcNow.AddDays(-15)
                    }
                };
                _context.DietTemplates.AddRange(seedList);
                await _context.SaveChangesAsync();
                dbDietTemplates = seedList;
            }

            var allDietPlans = await _context.DietPlans.ToListAsync();
            var templates = dbDietTemplates.Select(t =>
            {
                var assignedCount = allDietPlans.Count(d =>
                    d.Title.Equals(t.Title, StringComparison.OrdinalIgnoreCase) ||
                    d.Title.StartsWith(t.Title, StringComparison.OrdinalIgnoreCase) ||
                    d.Title.IndexOf(t.Title, StringComparison.OrdinalIgnoreCase) >= 0);
                return new DietTemplateItem
                {
                    Id = t.Id.ToString(),
                    Title = t.Title,
                    Category = t.Category,
                    DailyCalories = t.DailyCalories,
                    ProteinGrams = t.ProteinGrams,
                    MealsPerDay = t.MealsPerDay,
                    AssignedClientsCount = assignedCount,
                    Description = t.Description ?? string.Empty,
                    BadgeClass = !string.IsNullOrEmpty(t.BadgeClass) ? t.BadgeClass : "badge-teal"
                };
            }).ToList();

            // Query live diet plans from database
            var dbDiets = await _context.DietPlans
                .Include(d => d.Client)
                .Include(d => d.Meals)
                .OrderByDescending(d => d.CreatedAt)
                .ToListAsync();

            var todayStart = DateTime.UtcNow.Date;
            var weekAgo = DateTime.UtcNow.AddDays(-7);
            var assignedClientIds = dbClients.Select(c => c.Id).ToList();

            var recentDietHealthLogs = await _context.HealthLogs
                .Where(l => assignedClientIds.Contains(l.ClientId) && l.LogDate >= weekAgo)
                .ToListAsync();

            var clientRosters = new List<ClientDietRosterItem>();
            foreach (var d in dbDiets)
            {
                var cName = d.Client?.FullName ?? "Client";
                var inits = string.Join("", cName.Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(s => s[0])).ToUpper();
                if (inits.Length > 2) inits = inits.Substring(0, 2);
                if (string.IsNullOrEmpty(inits)) inits = "CL";

                int mealsScheduled = d.Meals.Count > 0 ? d.Meals.Count : 4;
                int targetProtein = (int)Math.Round((d.TargetCalories * 0.25) / 4.0);

                int mealsLoggedToday = recentDietHealthLogs
                    .Count(l => l.ClientId == d.ClientId && l.LogDate >= todayStart && l.Notes != null && 
                        (l.Notes.Contains("meal", StringComparison.OrdinalIgnoreCase) || 
                         l.Notes.Contains("Breakfast", StringComparison.OrdinalIgnoreCase) || 
                         l.Notes.Contains("Dinner", StringComparison.OrdinalIgnoreCase) || 
                         l.Notes.Contains("Lunch", StringComparison.OrdinalIgnoreCase) || 
                         l.Notes.Contains("Snack", StringComparison.OrdinalIgnoreCase) || 
                         l.Notes.Contains("Nutrition", StringComparison.OrdinalIgnoreCase)));

                int adherence = mealsScheduled > 0 ? Math.Min(100, (int)Math.Round((double)mealsLoggedToday / mealsScheduled * 100)) : 0;

                clientRosters.Add(new ClientDietRosterItem
                {
                    ClientId = d.ClientId,
                    ClientName = cName,
                    ClientEmail = d.Client?.Email ?? "",
                    ClientInitials = inits,
                    PlanTitle = d.Title,
                    Category = "Balanced Nutrition",
                    TargetCalories = d.TargetCalories,
                    TargetProtein = targetProtein,
                    MealsLoggedToday = mealsLoggedToday,
                    TotalMealsScheduled = mealsScheduled,
                    AdherencePercentage = adherence,
                    Status = d.IsActive ? "Active" : "Archived",
                    LastMealLogged = d.Meals.LastOrDefault()?.Description ?? "Balanced meal logged"
                });
            }

            int weeklyMealLogs = recentDietHealthLogs.Count(l => l.Notes != null && 
                (l.Notes.Contains("meal", StringComparison.OrdinalIgnoreCase) || 
                 l.Notes.Contains("Nutrition", StringComparison.OrdinalIgnoreCase) || 
                 l.Notes.Contains("Breakfast", StringComparison.OrdinalIgnoreCase) || 
                 l.Notes.Contains("Lunch", StringComparison.OrdinalIgnoreCase) || 
                 l.Notes.Contains("Dinner", StringComparison.OrdinalIgnoreCase)));

            var unreadCount = await _context.Notifications
                .Where(n => n.UserId == trainer.Id && !n.IsRead)
                .CountAsync();

            var activeDietRosters = clientRosters.Where(r => r.Status == "Active").ToList();

            var vm = new TrainerDietViewModel
            {
                TrainerName = (!string.IsNullOrWhiteSpace(trainer.FullName)) ? trainer.FullName.Replace("Dr. ", "") : (trainer.UserName?.Split('@')[0] ?? "Trainer"),
                TrainerEmail = trainer.Email ?? string.Empty,
                TrainerInitials = GetUserInitials(trainer.FullName, "TR"),
                UnreadNotificationsCount = unreadCount,
                TotalActiveDietPlans = activeDietRosters.Count,
                TotalTemplatesCount = templates.Count,
                AvgMacroAdherence = activeDietRosters.Any() 
                    ? (int)Math.Round(activeDietRosters.Average(r => r.AdherencePercentage)) 
                    : (clientRosters.Any() ? (int)Math.Round(clientRosters.Average(r => r.AdherencePercentage)) : 0),
                WeeklyMealLogsCount = weeklyMealLogs,
                Templates = templates,
                ClientDietRosters = clientRosters,
                AvailableClients = availableClients
            };

            return View(vm);
        }

        // POST: /Trainer/CreateDietPlan
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateDietPlan(CreateDietPlanFormModel model)
        {
            var trainer = await GetCurrentTrainerUserAsync();
            if (trainer == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            if (string.IsNullOrWhiteSpace(model.Title))
            {
                TempData["ErrorMessage"] = "Diet plan title is required.";
                return RedirectToAction(nameof(Diet));
            }

            if (string.IsNullOrWhiteSpace(model.ClientId))
            {
                TempData["ErrorMessage"] = "Please select a client to assign this diet plan.";
                return RedirectToAction(nameof(Diet));
            }

            var client = await _userManager.FindByIdAsync(model.ClientId);
            if (client == null)
            {
                TempData["ErrorMessage"] = "Selected client was not found.";
                return RedirectToAction(nameof(Diet));
            }

            if (client != null)
            {
                if (string.IsNullOrEmpty(client.TrainerId))
                {
                    client.TrainerId = trainer.Id;
                }

                // Archive previous active diet plans for this client
                var previousDiets = await _context.DietPlans
                    .Where(d => d.ClientId == client.Id && d.IsActive)
                    .ToListAsync();
                foreach (var pd in previousDiets) pd.IsActive = false;

                var newPlan = new DietPlan
                {
                    Title = model.Title.Trim(),
                    TargetCalories = model.TargetCalories > 0 ? model.TargetCalories : 2000,
                    ClientId = client.Id,
                    IsActive = true,
                    CreatedAt = DateTime.UtcNow
                };

                newPlan.Meals.Add(new MealItem { MealType = "Breakfast", Description = "High-protein oatmeal with berries and whey isolate", Calories = (int)(newPlan.TargetCalories * 0.25) });
                newPlan.Meals.Add(new MealItem { MealType = "Lunch", Description = "Grilled chicken breast, quinoa bowl and steamed greens", Calories = (int)(newPlan.TargetCalories * 0.35) });
                newPlan.Meals.Add(new MealItem { MealType = "Snack", Description = "Greek yogurt with crushed almonds and blueberries", Calories = (int)(newPlan.TargetCalories * 0.15) });
                newPlan.Meals.Add(new MealItem { MealType = "Dinner", Description = "Baked salmon with roasted asparagus and sweet potato", Calories = (int)(newPlan.TargetCalories * 0.25) });

                _context.DietPlans.Add(newPlan);

                var notif = new Notification
                {
                    UserId = client.Id,
                    Message = $"Your trainer {trainer.FullName} assigned a new diet plan: '{model.Title}' ({model.TargetCalories} kcal).",
                    CreatedAt = DateTime.UtcNow,
                    IsRead = false
                };
                _context.Notifications.Add(notif);

                await _context.SaveChangesAsync();
            }

            TempData["SuccessMessage"] = $"Diet plan '{model.Title}' ({model.TargetCalories} kcal) assigned successfully!";
            return RedirectToAction(nameof(Diet));
        }

        // POST: /Trainer/CreateDietTemplate
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateDietTemplate(CreateDietTemplateFormModel model)
        {
            var trainer = await GetCurrentTrainerUserAsync();
            if (trainer == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            if (string.IsNullOrWhiteSpace(model.Title))
            {
                TempData["ErrorMessage"] = "Diet template title is required.";
                return RedirectToAction(nameof(Diet));
            }

            string badgeClass = "badge-teal";
            var cat = (model.Category ?? "").ToLower();
            if (cat.Contains("deficit") || cat.Contains("fat loss")) badgeClass = "badge-blue";
            else if (cat.Contains("hypertrophy") || cat.Contains("mass") || cat.Contains("building")) badgeClass = "badge-purple";
            else if (cat.Contains("plant") || cat.Contains("vegan")) badgeClass = "badge-amber";
            else if (cat.Contains("rehab") || cat.Contains("recovery")) badgeClass = "badge-rose";

            var tpl = new DietTemplate
            {
                Title = model.Title.Trim(),
                Category = string.IsNullOrWhiteSpace(model.Category) ? "Balanced Nutrition" : model.Category.Trim(),
                DailyCalories = model.TargetCalories > 0 ? model.TargetCalories : 2000,
                ProteinGrams = model.TargetProtein > 0 ? model.TargetProtein : 120,
                MealsPerDay = model.MealsPerDay > 0 ? model.MealsPerDay : 4,
                Description = !string.IsNullOrWhiteSpace(model.Description)
                    ? model.Description.Trim()
                    : $"Balanced nutritional blueprint targeting {model.TargetCalories} kcal and {model.TargetProtein}g protein daily across {model.MealsPerDay} meals.",
                BadgeClass = badgeClass,
                MealsText = model.MealsText,
                TrainerId = trainer.Id,
                CreatedAt = DateTime.UtcNow
            };

            _context.DietTemplates.Add(tpl);
            await _context.SaveChangesAsync();

            TempData["SuccessMessage"] = $"Diet template '{tpl.Title}' created successfully! It is now available in your Nutrition Program Templates.";
            return RedirectToAction(nameof(Diet));
        }

        // ====================================================================
        // APPOINTMENTS MANAGEMENT (Matching media_1792657148183_6278500c.png)
        // ====================================================================

        // GET: /Trainer/Appointments
        public async Task<IActionResult> Appointments(string? status = null, string? search = null)
        {
            var trainer = await GetCurrentTrainerUserAsync();
            if (trainer == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            // Fetch live database appointments
            var dbAppts = await _context.Appointments
                .Include(a => a.Client)
                .Where(a => a.TrainerId == trainer.Id)
                .OrderByDescending(a => a.AppointmentDate)
                .ToListAsync();

            if (!dbAppts.Any())
            {
                dbAppts = await _context.Appointments
                    .Include(a => a.Client)
                    .OrderByDescending(a => a.AppointmentDate)
                    .ToListAsync();
            }

            var items = new List<TrainerAppointmentItem>();
            foreach (var dba in dbAppts)
            {
                var cName = dba.Client?.FullName ?? dba.Client?.UserName ?? "Client";
                var cEmail = dba.Client?.Email ?? string.Empty;
                var inits = string.Join("", cName.Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(s => s[0])).ToUpper();
                if (inits.Length > 2) inits = inits.Substring(0, 2);
                if (string.IsNullOrEmpty(inits)) inits = "CL";

                items.Add(new TrainerAppointmentItem
                {
                    Id = dba.Id,
                    ClientId = dba.ClientId,
                    ClientName = cName,
                    ClientEmail = cEmail,
                    ClientInitials = inits,
                    ConsultationType = dba.Notes?.Split('·')[0].Trim().ToUpper() ?? "HEALTH CONSULTATION",
                    DayNumber = dba.AppointmentDate.ToString("dd"),
                    MonthText = dba.AppointmentDate.ToString("MMM").ToUpper(),
                    AppointmentDate = dba.AppointmentDate,
                    TimeSlot = dba.TimeSlot,
                    DurationMinutes = 45,
                    Status = (dba.Status == "Confirmed" || dba.Status == "Approved") ? "Approved" : dba.Status,
                    Notes = dba.Notes ?? "General consultation check-in"
                });
            }

            // Filtering
            var filtered = items.AsEnumerable();
            if (!string.IsNullOrWhiteSpace(search))
            {
                var q = search.Trim().ToLower();
                filtered = filtered.Where(a => a.ClientName.ToLower().Contains(q) || a.ConsultationType.ToLower().Contains(q));
            }

            if (!string.IsNullOrWhiteSpace(status) && !status.Equals("All", StringComparison.OrdinalIgnoreCase))
            {
                filtered = filtered.Where(a => a.Status.Equals(status, StringComparison.OrdinalIgnoreCase));
            }

            var filteredList = filtered.ToList();

            var unreadCount = await _context.Notifications
                .Where(n => n.UserId == trainer.Id && !n.IsRead)
                .CountAsync();

            var vm = new TrainerAppointmentsViewModel
            {
                TrainerName = (!string.IsNullOrWhiteSpace(trainer.FullName)) ? trainer.FullName.Replace("Dr. ", "") : (trainer.UserName?.Split('@')[0] ?? "Trainer"),
                TrainerEmail = trainer.Email ?? string.Empty,
                TrainerInitials = GetUserInitials(trainer.FullName, "TR"),
                UnreadNotificationsCount = unreadCount,
                PendingRequestsCount = items.Count(i => i.Status == "Pending"),
                ApprovedRequestsCount = items.Count(i => i.Status == "Approved"),
                TotalRequestsCount = items.Count,
                ActiveTab = "Requests",
                SelectedStatus = status ?? "All",
                Appointments = filteredList
            };

            return View(vm);
        }

        // POST: /Trainer/RescheduleAppointment
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> RescheduleAppointment(int id, DateTime newDate, string newTimeSlot)
        {
            var trainer = await GetCurrentTrainerUserAsync();
            var appt = await _context.Appointments.Include(a => a.Client).FirstOrDefaultAsync(a => a.Id == id);
            if (appt != null)
            {
                appt.AppointmentDate = newDate;
                appt.TimeSlot = newTimeSlot;
                appt.Status = "Approved";

                var notif = new Notification
                {
                    UserId = appt.ClientId,
                    Message = $"Your appointment was rescheduled by {trainer.FullName} to {newDate:dd MMM} at {newTimeSlot}.",
                    CreatedAt = DateTime.UtcNow,
                    IsRead = false
                };
                _context.Notifications.Add(notif);
                await _context.SaveChangesAsync();
            }

            TempData["SuccessMessage"] = "Appointment rescheduled successfully!";
            return RedirectToAction(nameof(Appointments));
        }

        // POST: /Trainer/ReviewAllAppointments
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ReviewAllAppointments()
        {
            var trainer = await GetCurrentTrainerUserAsync();
            var pendingAppts = await _context.Appointments.Include(a => a.Client).Where(a => a.TrainerId == trainer.Id && a.Status == "Pending").ToListAsync();
            foreach (var a in pendingAppts)
            {
                a.Status = "Approved";
                if (a.Client != null && string.IsNullOrEmpty(a.Client.TrainerId))
                {
                    a.Client.TrainerId = trainer.Id;
                }
                _context.Notifications.Add(new Notification
                {
                    UserId = a.ClientId,
                    Message = $"Your consultation with {trainer.FullName} on {a.AppointmentDate:dd MMM} has been approved.",
                    CreatedAt = DateTime.UtcNow,
                    IsRead = false
                });
            }
            if (pendingAppts.Any())
            {
                await _context.SaveChangesAsync();
            }

            TempData["SuccessMessage"] = "All pending appointment requests have been approved!";
            return RedirectToAction(nameof(Appointments));
        }

        // ====================================================================
        // CLIENT PROGRESS & REPORTS (Matching media_1792660312801_523fdadb.png and media_1792660315490_3d5a7f46.png)
        // ====================================================================

        // GET: /Trainer/Reports
        public async Task<IActionResult> Reports(string? clientId = null, string? metric = null, string? timeframe = null)
        {
            var trainer = await GetCurrentTrainerUserAsync();
            if (trainer == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            // 1. Available Clients assigned to this trainer from DB
            var dbClients = await _context.Users
                .Where(u => u.Role == "Client" && u.TrainerId == trainer.Id)
                .ToListAsync();

            var clientOptions = dbClients.Select(dbc =>
            {
                var names = (dbc.FullName ?? "Client User").Split(' ', StringSplitOptions.RemoveEmptyEntries);
                var inits = names.Length >= 2 ? $"{names[0][0]}{names[1][0]}".ToUpper() : (dbc.FullName ?? "CL")[..Math.Min(2, (dbc.FullName ?? "CL").Length)].ToUpper();
                return new TrainerClientFilterOption
                {
                    Id = dbc.Id,
                    Name = dbc.FullName ?? "Client User",
                    Email = dbc.Email ?? "",
                    Initials = inits
                };
            }).ToList();

            TrainerClientFilterOption? selectedClient = null;
            if (clientOptions.Any())
            {
                selectedClient = clientOptions.FirstOrDefault(c => c.Id == clientId || c.Name.Equals(clientId, StringComparison.OrdinalIgnoreCase)) ?? clientOptions.First();
            }

            var unreadCount = await _context.Notifications
                .Where(n => n.UserId == trainer.Id && !n.IsRead)
                .CountAsync();

            string selectedTimeframe = timeframe switch
            {
                "Last 7 Days" or "7" or "7days" or "Weekly" => "Last 7 Days",
                "All Time" or "All" or "Yearly" => "All Time",
                _ => "Last 30 Days"
            };

            var vm = new TrainerReportsViewModel
            {
                TrainerName = (!string.IsNullOrWhiteSpace(trainer.FullName)) ? trainer.FullName.Replace("Dr. ", "") : (trainer.UserName?.Split('@')[0] ?? "Trainer"),
                TrainerEmail = trainer.Email ?? string.Empty,
                TrainerInitials = GetUserInitials(trainer.FullName, "TR"),
                UnreadNotificationsCount = unreadCount,
                SelectedClientId = selectedClient?.Id ?? string.Empty,
                SelectedClientName = selectedClient?.Name ?? "No assigned clients",
                SelectedMetric = metric ?? "All metrics",
                SelectedTimeframe = selectedTimeframe,
                Clients = clientOptions,
                MeasurementHistory = new List<TrainerMeasurementHistoryItem>(),
                WeightLabels = new List<string>(),
                WeightValues = new List<double>(),
                ActivityDays = new List<string> { "M", "T", "W", "T", "F", "S", "S" },
                ActivityPercentages = new List<int> { 0, 0, 0, 0, 0, 0, 0 }
            };

            if (selectedClient != null && !string.IsNullOrEmpty(selectedClient.Id))
            {
                var dbClient = await _context.Users.FirstOrDefaultAsync(u => u.Id == selectedClient.Id && u.TrainerId == trainer.Id);
                if (dbClient != null)
                {
                    // 1. Workouts
                    var clientWorkouts = await _context.WorkoutPlans
                        .Include(w => w.Exercises)
                        .Where(w => w.ClientId == dbClient.Id)
                        .ToListAsync();

                    int totalExercises = clientWorkouts.SelectMany(w => w.Exercises).Count();
                    int completedExercises = clientWorkouts.SelectMany(w => w.Exercises).Count(e => e.IsCompleted);

                    if (totalExercises > 0)
                    {
                        int pct = (int)Math.Round((double)completedExercises / totalExercises * 100);
                        vm.WorkoutCompletionRate = $"{pct}%";
                        vm.WorkoutCompletionSubtext = $"{completedExercises}/{totalExercises} exercises completed";
                    }
                    else
                    {
                        vm.WorkoutCompletionRate = "0%";
                        vm.WorkoutCompletionSubtext = clientWorkouts.Any() ? "Plan created, no exercises yet" : "No workout plan assigned";
                    }

                    // Fetch client health logs for biometrics and activity
                    var allLogs = await _context.HealthLogs
                        .Where(h => h.ClientId == dbClient.Id)
                        .OrderBy(h => h.LogDate)
                        .ToListAsync();

                    // Filter logs for Weight trend based on selectedTimeframe
                    var chartLogs = allLogs;
                    if (selectedTimeframe == "Last 7 Days")
                    {
                        var cutoff = DateTime.UtcNow.AddDays(-7);
                        chartLogs = allLogs.Where(h => h.LogDate >= cutoff).ToList();
                    }
                    else if (selectedTimeframe == "Last 30 Days")
                    {
                        var cutoff = DateTime.UtcNow.AddDays(-30);
                        chartLogs = allLogs.Where(h => h.LogDate >= cutoff).ToList();
                    }

                    // 2. Active Minutes & Activity Percentages (dynamic from real exercise completions and logs)
                    int activeMinutes = completedExercises * 15;
                    vm.ActiveMinutes = activeMinutes;
                    vm.ActiveMinutesSubtext = activeMinutes > 0 ? "Last 30 days" : "No workout activity";

                    var startOfWeek = DateTime.UtcNow.Date.AddDays(-(int)(DateTime.UtcNow.DayOfWeek == DayOfWeek.Sunday ? 6 : (int)DateTime.UtcNow.DayOfWeek - 1));
                    var weekDays = Enumerable.Range(0, 7).Select(i => startOfWeek.AddDays(i)).ToList();
                    var dayPercentages = new List<int>();

                    foreach (var day in weekDays)
                    {
                        if (day > DateTime.UtcNow.Date)
                        {
                            dayPercentages.Add(0);
                        }
                        else
                        {
                            bool hadWorkout = clientWorkouts.Any(w => w.CreatedAt.Date <= day && w.Exercises.Any(e => e.IsCompleted));
                            bool hadLog = allLogs.Any(l => l.LogDate.Date == day);
                            int dayVal = (hadWorkout && hadLog) ? 100 : (hadWorkout || hadLog ? 75 : 0);
                            dayPercentages.Add(dayVal);
                        }
                    }
                    vm.ActivityPercentages = dayPercentages;

                    // 3. Diet & Calories
                    var clientDiet = await _context.DietPlans
                        .Where(d => d.ClientId == dbClient.Id)
                        .OrderByDescending(d => d.CreatedAt)
                        .FirstOrDefaultAsync();

                    if (clientDiet != null && clientDiet.TargetCalories > 0)
                    {
                        vm.AverageCalories = clientDiet.TargetCalories.ToString("N0");
                        vm.AverageCaloriesSubtext = "Target daily intake";
                    }
                    else
                    {
                        vm.AverageCalories = "0";
                        vm.AverageCaloriesSubtext = "No diet plan assigned";
                    }

                    // 4. Weight & Biometrics from HealthLogs
                    // In real life, users log weight at most once per day/week/month.
                    // Consolidate same-day logs so there is strictly 1 weight point per calendar date.
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
                        double firstW = dailyChartLogs.First().WeightKg;
                        double lastW = dailyChartLogs.Last().WeightKg;
                        double diff = Math.Round(lastW - firstW, 1);
                        vm.WeightChange = diff <= 0 ? $"{diff:F1} kg" : $"+{diff:F1} kg";
                        vm.WeightChangeSubtext = selectedTimeframe == "Last 7 Days"
                            ? $"Past 7 days (since {dailyChartLogs.First().LogDate:MMM dd})"
                            : (selectedTimeframe == "Last 30 Days" ? $"Past 30 days (since {dailyChartLogs.First().LogDate:MMM dd})" : $"All-time (since {dailyChartLogs.First().LogDate:MMM dd, yyyy})");
                        vm.CurrentWeightKg = lastW;
                        vm.WeightTrendStatus = diff <= 0 ? "On track" : "Calibrating";

                        // Strictly format as clean calendar dates (MMM dd) - NO TIME
                        vm.WeightLabels = dailyChartLogs.Select(l => l.LogDate.ToString("MMM dd")).ToList();
                        vm.WeightValues = dailyChartLogs.Select(l => l.WeightKg).ToList();
                    }
                    else if (allLogs.Any())
                    {
                        vm.CurrentWeightKg = allLogs.Last().WeightKg;
                        vm.WeightChange = "0.0 kg";
                        vm.WeightChangeSubtext = $"No logs in {selectedTimeframe.ToLower()}";
                        vm.WeightTrendStatus = "No recent data";
                        vm.WeightLabels = new List<string>();
                        vm.WeightValues = new List<double>();
                    }
                    else
                    {
                        vm.CurrentWeightKg = dbClient.CurrentWeight ?? 0.0;
                        vm.WeightChange = "0.0 kg";
                        vm.WeightChangeSubtext = dbClient.CurrentWeight.HasValue ? "Baseline from profile" : "No weigh-ins recorded";
                        vm.WeightTrendStatus = dbClient.CurrentWeight.HasValue ? "Baseline" : "No data";
                        vm.WeightLabels = new List<string>();
                        vm.WeightValues = new List<double>();
                    }

                    // Populate measurement history table (one entry per date, clean date format with NO TIME)
                    var dailyHistoryLogs = allLogs
                        .GroupBy(l => l.LogDate.Date)
                        .Select(g =>
                            g.OrderByDescending(l => !string.IsNullOrEmpty(l.Notes) && (l.Notes.Contains("waist:") || l.Notes.Contains("measurement") || l.Notes.Contains("biometric") || (!l.Notes.Contains("Meal Logged") && !l.Notes.Contains("Morning hydration"))))
                             .ThenBy(l => l.LogDate)
                             .Last()
                        )
                        .OrderByDescending(l => l.LogDate)
                        .ToList();

                    foreach (var log in dailyHistoryLogs)
                    {
                        int waist = 80;
                        if (!string.IsNullOrEmpty(log.Notes) && log.Notes.Contains("waist:"))
                        {
                            var parts = log.Notes.Split("waist:")[1].Trim().Split(' ');
                            if (int.TryParse(parts[0], out var pw)) waist = pw;
                        }

                        vm.MeasurementHistory.Add(new TrainerMeasurementHistoryItem
                        {
                            Id = log.Id,
                            Date = log.LogDate,
                            DateText = log.LogDate.ToString("MMM dd, yyyy"),
                            WeightKg = log.WeightKg,
                            HeightCm = (int)(dbClient.HeightCm ?? 175),
                            Bmi = log.CalculatedBmi,
                            WaistCm = waist,
                            Notes = (!string.IsNullOrEmpty(log.Notes) && !log.Notes.StartsWith("Meal Logged") && !log.Notes.StartsWith("Morning hydration"))
                                ? log.Notes
                                : "Routine biometric check"
                        });
                    }
                }
            }
            else
            {
                // No assigned clients for this trainer
                vm.WeightChange = "0.0 kg";
                vm.WeightChangeSubtext = "No assigned clients";
                vm.WorkoutCompletionRate = "0%";
                vm.WorkoutCompletionSubtext = "No assigned plans";
                vm.ActiveMinutes = 0;
                vm.ActiveMinutesSubtext = "No activity";
                vm.AverageCalories = "0";
                vm.AverageCaloriesSubtext = "No diet logged";
                vm.CurrentWeightKg = 0.0;
                vm.WeightTrendStatus = "No data";
                vm.WeightLabels = new List<string>();
                vm.WeightValues = new List<double>();
            }

            return View(vm);
        }

        // GET: /Trainer/ExportReportCsv
        public async Task<IActionResult> ExportReportCsv(string? clientId = null)
        {
            var trainer = await GetCurrentTrainerUserAsync();
            if (trainer == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            if (string.IsNullOrEmpty(clientId))
            {
                TempData["ErrorMessage"] = "No client selected for export.";
                return RedirectToAction(nameof(Reports));
            }

            // Look up client in DB ensuring they belong to this trainer
            var dbClient = await _context.Users.FirstOrDefaultAsync(u => (u.Id == clientId || u.FullName == clientId || u.Email == clientId) && u.TrainerId == trainer.Id);
            if (dbClient == null)
            {
                TempData["ErrorMessage"] = "Client not found or not assigned to your care list.";
                return RedirectToAction(nameof(Reports));
            }

            var sb = new System.Text.StringBuilder();
            sb.AppendLine("Date,Client,Weight(kg),Height(cm),BMI,Waist(cm),Notes");

            var dbLogs = await _context.HealthLogs
                .Where(h => h.ClientId == dbClient.Id)
                .OrderByDescending(h => h.LogDate)
                .ToListAsync();

            if (dbLogs.Any())
            {
                foreach (var log in dbLogs)
                {
                    int waist = 80;
                    if (!string.IsNullOrEmpty(log.Notes) && log.Notes.Contains("waist:"))
                    {
                        var parts = log.Notes.Split("waist:")[1].Trim().Split(' ');
                        if (int.TryParse(parts[0], out var parsedWaist)) waist = parsedWaist;
                    }
                    sb.AppendLine($"{log.LogDate:yyyy-MM-dd},{dbClient.FullName},{log.WeightKg:0.0},{(int)(dbClient.HeightCm ?? 175)},{log.CalculatedBmi:0.0},{waist},\"{(log.Notes ?? "").Replace("\"", "\"\"")}\"");
                }
            }
            else
            {
                sb.AppendLine($"{DateTime.UtcNow:yyyy-MM-dd},{dbClient.FullName},{dbClient.CurrentWeight ?? 70.0:0.0},{(int)(dbClient.HeightCm ?? 175)},22.5,80,\"Baseline measurement\"");
            }

            var bytes = System.Text.Encoding.UTF8.GetBytes(sb.ToString());
            return File(bytes, "text/csv", $"ClientProgress_{dbClient.FullName?.Replace(" ", "_") ?? "Client"}_{DateTime.UtcNow:yyyyMMdd}.csv");
        }

        // ====================================================================
        // TRAINER PROFILE & SPECIALIZATION MANAGEMENT (/Trainer/Profile)
        // ====================================================================

        // GET: /Trainer/Profile
        public async Task<IActionResult> Profile()
        {
            var trainer = await GetCurrentTrainerUserAsync();
            if (trainer == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            var clientCount = await _context.Users.CountAsync(u => u.TrainerId == trainer.Id);
            var activePlansCount = await _context.WorkoutPlans.CountAsync(w => w.TrainerId == trainer.Id);
            var upcomingApptsCount = await _context.Appointments.CountAsync(a => a.TrainerId == trainer.Id && a.AppointmentDate >= DateTime.UtcNow.Date && a.Status != "Declined");

            string inits = "TR";
            if (!string.IsNullOrWhiteSpace(trainer.FullName))
            {
                var parts = trainer.FullName.Trim().Split(' ');
                inits = string.Join("", parts.Select(w => w.Length > 0 ? w[0].ToString() : "")).ToUpper();
                if (inits.Length > 2) inits = inits.Substring(0, 2);
            }

            var vm = new TrainerProfileViewModel
            {
                Id = trainer.Id,
                FullName = trainer.FullName ?? trainer.UserName ?? "Coach",
                Email = trainer.Email ?? "",
                PhoneNumber = trainer.PhoneNumber,
                Specialty = string.IsNullOrWhiteSpace(trainer.FitnessGoal) ? "General Fitness" : trainer.FitnessGoal,
                Certifications = trainer.Certifications ?? "Certified Personal Trainer",
                Bio = trainer.Bio ?? "Dedicated to empowering clients through evidence-based progressive programming, structured accountability, and tailored nutritional balance.",
                JoinedDate = trainer.CreatedAt > DateTime.MinValue ? trainer.CreatedAt.ToString("MMM dd, yyyy") : DateTime.UtcNow.ToString("MMM dd, yyyy"),
                Initials = inits,
                AssignedClientsCount = clientCount,
                ActivePlansCount = activePlansCount,
                UpcomingAppointmentsCount = upcomingApptsCount,
                IsProfileCompleted = trainer.IsProfileCompleted
            };

            return View(vm);
        }

        // POST: /Trainer/Profile
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Profile(TrainerProfileViewModel model)
        {
            var trainer = await GetCurrentTrainerUserAsync();
            if (trainer == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            if (!ModelState.IsValid)
            {
                TempData["ErrorMessage"] = "Please check your inputs and try again.";
                return View(model);
            }

            trainer.FullName = model.FullName;
            if (!string.IsNullOrWhiteSpace(model.PhoneNumber))
            {
                trainer.PhoneNumber = model.PhoneNumber;
            }
            trainer.FitnessGoal = model.Specialty; // Used across platform as trainer specialty
            trainer.Certifications = model.Certifications;
            trainer.Bio = model.Bio;
            trainer.IsProfileCompleted = true;

            var result = await _userManager.UpdateAsync(trainer);
            if (result.Succeeded)
            {
                TempData["SuccessMessage"] = "Your coaching profile and specialty have been updated successfully!";
                return RedirectToAction(nameof(Profile));
            }

            TempData["ErrorMessage"] = string.Join("; ", result.Errors.Select(e => e.Description));
            return View(model);
        }

        // POST: /Trainer/CompleteFirstTimeSetup
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CompleteFirstTimeSetup(string specialty, string? certifications, string? bio)
        {
            var trainer = await GetCurrentTrainerUserAsync();
            if (trainer == null)
            {
                return RedirectToPage("/Account/Login", new { area = "Identity" });
            }

            if (!string.IsNullOrWhiteSpace(specialty))
            {
                trainer.FitnessGoal = specialty.Trim();
            }
            if (!string.IsNullOrWhiteSpace(certifications))
            {
                trainer.Certifications = certifications.Trim();
            }
            if (!string.IsNullOrWhiteSpace(bio))
            {
                trainer.Bio = bio.Trim();
            }
            trainer.IsProfileCompleted = true;

            await _userManager.UpdateAsync(trainer);
            TempData["SuccessMessage"] = $"Welcome to HealthTrack! Your specialty is now set to '{trainer.FitnessGoal}'.";

            return RedirectToAction(nameof(Index));
        }

        private string GetUserInitials(string? fullName, string fallback = "TR")
        {
            if (string.IsNullOrWhiteSpace(fullName)) return fallback;
            var parts = fullName.Trim().Split(' ', StringSplitOptions.RemoveEmptyEntries);
            var inits = string.Join("", parts.Select(w => w.Length > 0 ? w[0].ToString() : "")).ToUpper();
            if (inits.Length > 2) inits = inits.Substring(0, 2);
            return string.IsNullOrEmpty(inits) ? fallback : inits;
        }

        // Helper to retrieve current authenticated trainer user
        private async Task<ApplicationUser?> GetCurrentTrainerUserAsync()
        {
            var user = await _userManager.GetUserAsync(User);
            if (user != null)
            {
                var isTrainer = await _userManager.IsInRoleAsync(user, "Trainer") || await _userManager.IsInRoleAsync(user, "Admin") || user.Role == "Trainer" || user.Role == "Admin";
                if (isTrainer)
                {
                    if (user.Role == "Trainer" && !user.IsApproved) return null;
                    return user;
                }
            }

            return null;
        }
    }
}
