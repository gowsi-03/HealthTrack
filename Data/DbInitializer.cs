using Microsoft.AspNetCore.Identity;
using HealthTrack.Models;

namespace HealthTrack.Data
{
    public static class DbInitializer
    {
        public static async Task SeedRolesAndUsersAsync(IServiceProvider serviceProvider)
        {
            var roleManager = serviceProvider.GetRequiredService<RoleManager<IdentityRole>>();
            var userManager = serviceProvider.GetRequiredService<UserManager<ApplicationUser>>();
            var context = serviceProvider.GetRequiredService<ApplicationDbContext>();

            // 1. Seed Roles
            string[] roles = { "Admin", "Trainer", "Client" };
            foreach (var role in roles)
            {
                if (!await roleManager.RoleExistsAsync(role))
                {
                    await roleManager.CreateAsync(new IdentityRole(role));
                }
            }

            // 2. Seed Admin User
            var adminEmail = "admin@healthtrack.com";
            var adminUser = await userManager.FindByEmailAsync(adminEmail);
            if (adminUser == null)
            {
                adminUser = new ApplicationUser
                {
                    UserName = adminEmail,
                    Email = adminEmail,
                    FullName = "Super Administrator",
                    Role = "Admin",
                    EmailConfirmed = true
                };
                await userManager.CreateAsync(adminUser, "Admin123!");
                await userManager.AddToRoleAsync(adminUser, "Admin");
            }

            // 3. Seed Trainer User & Specialists
            var trainerEmail = "trainer@healthtrack.com";
            var trainerUser = await userManager.FindByEmailAsync(trainerEmail);
            if (trainerUser == null)
            {
                trainerUser = new ApplicationUser
                {
                    UserName = trainerEmail,
                    Email = trainerEmail,
                    FullName = "Alex Henderson",
                    Role = "Trainer",
                    FitnessGoal = "Certified Strength & Conditioning Coach",
                    EmailConfirmed = true
                };
                await userManager.CreateAsync(trainerUser, "Trainer123!");
                await userManager.AddToRoleAsync(trainerUser, "Trainer");
            }

            // Seed Dr. Maya Patel
            var mayaEmail = "maya.patel@healthtrack.com";
            var mayaUser = await userManager.FindByEmailAsync(mayaEmail);
            if (mayaUser == null)
            {
                mayaUser = new ApplicationUser
                {
                    UserName = mayaEmail,
                    Email = mayaEmail,
                    FullName = "Dr. Maya Patel",
                    Role = "Trainer",
                    FitnessGoal = "Health & Wellness Physician",
                    EmailConfirmed = true
                };
                await userManager.CreateAsync(mayaUser, "Specialist123!");
                await userManager.AddToRoleAsync(mayaUser, "Trainer");
            }

            // Seed Chris Williams
            var chrisEmail = "chris.williams@healthtrack.com";
            var chrisUser = await userManager.FindByEmailAsync(chrisEmail);
            if (chrisUser == null)
            {
                chrisUser = new ApplicationUser
                {
                    UserName = chrisEmail,
                    Email = chrisEmail,
                    FullName = "Chris Williams",
                    Role = "Trainer",
                    FitnessGoal = "Senior Performance & Strength Coach",
                    EmailConfirmed = true
                };
                await userManager.CreateAsync(chrisUser, "Specialist123!");
                await userManager.AddToRoleAsync(chrisUser, "Trainer");
            }

            // Seed Dr. Nina Ford
            var ninaEmail = "nina.ford@healthtrack.com";
            var ninaUser = await userManager.FindByEmailAsync(ninaEmail);
            if (ninaUser == null)
            {
                ninaUser = new ApplicationUser
                {
                    UserName = ninaEmail,
                    Email = ninaEmail,
                    FullName = "Dr. Nina Ford",
                    Role = "Trainer",
                    FitnessGoal = "Registered Clinical Nutritionist",
                    EmailConfirmed = true
                };
                await userManager.CreateAsync(ninaUser, "Specialist123!");
                await userManager.AddToRoleAsync(ninaUser, "Trainer");
            }

            // 4. Seed Client User
            var clientEmail = "client@healthtrack.com";
            var clientUser = await userManager.FindByEmailAsync(clientEmail);
            if (clientUser == null)
            {
                clientUser = new ApplicationUser
                {
                    UserName = clientEmail,
                    Email = clientEmail,
                    FullName = "John Doe",
                    Role = "Client",
                    HeightCm = 180,
                    CurrentWeight = 74.2,
                    TargetWeight = 70.0,
                    FitnessGoal = "Weight Loss & Muscle Tone",
                    TrainerId = trainerUser.Id,
                    EmailConfirmed = true
                };
                await userManager.CreateAsync(clientUser, "Client123!");
                await userManager.AddToRoleAsync(clientUser, "Client");

                // Seed Initial Health Logs for Chart.js
                context.HealthLogs.AddRange(
                    new HealthLog { ClientId = clientUser.Id, LogDate = DateTime.UtcNow.AddMonths(-5), WeightKg = 78.5, CalculatedBmi = 24.2, CaloriesBurned = 400, WaterIntakeLiters = 2.0 },
                    new HealthLog { ClientId = clientUser.Id, LogDate = DateTime.UtcNow.AddMonths(-4), WeightKg = 77.2, CalculatedBmi = 23.8, CaloriesBurned = 420, WaterIntakeLiters = 2.2 },
                    new HealthLog { ClientId = clientUser.Id, LogDate = DateTime.UtcNow.AddMonths(-3), WeightKg = 76.0, CalculatedBmi = 23.5, CaloriesBurned = 450, WaterIntakeLiters = 2.5 },
                    new HealthLog { ClientId = clientUser.Id, LogDate = DateTime.UtcNow.AddMonths(-2), WeightKg = 75.1, CalculatedBmi = 23.2, CaloriesBurned = 460, WaterIntakeLiters = 2.5 },
                    new HealthLog { ClientId = clientUser.Id, LogDate = DateTime.UtcNow.AddMonths(-1), WeightKg = 74.8, CalculatedBmi = 23.1, CaloriesBurned = 440, WaterIntakeLiters = 2.7 },
                    new HealthLog { ClientId = clientUser.Id, LogDate = DateTime.UtcNow, WeightKg = 74.2, CalculatedBmi = 22.8, CaloriesBurned = 480, WaterIntakeLiters = 3.0 }
                );

                // Seed Initial Workout Plan
                var workout = new WorkoutPlan
                {
                    Title = "Upper Body Hypertrophy",
                    ClientId = clientUser.Id,
                    TrainerId = trainerUser.Id,
                    CreatedAt = DateTime.UtcNow
                };
                workout.Exercises.Add(new WorkoutExercise { Name = "Barbell Bench Press", Sets = "4 sets", Reps = "10 reps (60 kg)", IsCompleted = true });
                workout.Exercises.Add(new WorkoutExercise { Name = "Incline Dumbbell Rows", Sets = "3 sets", Reps = "12 reps (18 kg)", IsCompleted = true });
                workout.Exercises.Add(new WorkoutExercise { Name = "Overhead Dumbbell Press", Sets = "3 sets", Reps = "10 reps (35 kg)", IsCompleted = false });
                workout.Exercises.Add(new WorkoutExercise { Name = "Tricep Rope Pushdowns", Sets = "3 sets", Reps = "15 reps (25 kg)", IsCompleted = false });

                context.WorkoutPlans.Add(workout);

                // Seed Initial Diet Plan (Matching user reference layout)
                var diet = new DietPlan
                {
                    Title = "Balanced Performance Plan",
                    TargetCalories = 2150,
                    ClientId = clientUser.Id,
                    CreatedAt = DateTime.UtcNow
                };
                diet.Meals.Add(new MealItem { MealType = "Breakfast", Description = "Greek yogurt, berries & almond granola", Calories = 420 });
                diet.Meals.Add(new MealItem { MealType = "Lunch", Description = "Grilled chicken quinoa power bowl", Calories = 610 });
                diet.Meals.Add(new MealItem { MealType = "Afternoon snack", Description = "Apple with almond butter", Calories = 240 });
                diet.Meals.Add(new MealItem { MealType = "Dinner", Description = "Baked salmon, greens & brown rice", Calories = 580 });

                context.DietPlans.Add(diet);

                // Seed Initial Appointments (Matching user reference layout media_1792558583092_fb065d35.png)
                context.Appointments.AddRange(
                    new Appointment
                    {
                        ClientId = clientUser.Id,
                        TrainerId = mayaUser.Id,
                        AppointmentDate = new DateTime(DateTime.UtcNow.Year, 4, 18),
                        TimeSlot = "10:30 AM",
                        Status = "Approved",
                        Notes = "HEALTH CONSULTATION · 45 min - Routine cardiovascular screening and general wellness assessment."
                    },
                    new Appointment
                    {
                        ClientId = clientUser.Id,
                        TrainerId = chrisUser.Id,
                        AppointmentDate = new DateTime(DateTime.UtcNow.Year, 4, 24),
                        TimeSlot = "4:00 PM",
                        Status = "Pending",
                        Notes = "PERSONAL TRAINING · 60 min - Progressive overload review & squat technique optimization."
                    },
                    new Appointment
                    {
                        ClientId = clientUser.Id,
                        TrainerId = ninaUser.Id,
                        AppointmentDate = new DateTime(DateTime.UtcNow.Year, 5, 2),
                        TimeSlot = "9:15 AM",
                        Status = "Approved",
                        Notes = "NUTRITION REVIEW · 60 min - Macronutrient adjustment for endurance & lean retention."
                    },
                    new Appointment
                    {
                        ClientId = clientUser.Id,
                        TrainerId = mayaUser.Id,
                        AppointmentDate = DateTime.UtcNow.AddDays(-14),
                        TimeSlot = "10:00 AM",
                        Status = "Completed",
                        Notes = "HEALTH CONSULTATION · 45 min - Baseline biometric evaluation and intake consultation."
                    },
                    new Appointment
                    {
                        ClientId = clientUser.Id,
                        TrainerId = chrisUser.Id,
                        AppointmentDate = DateTime.UtcNow.AddDays(-7),
                        TimeSlot = "3:30 PM",
                        Status = "Completed",
                        Notes = "PERSONAL TRAINING · 60 min - Movement assessment & functional mobility calibration."
                    }
                );

                // Seed Initial Notification
                context.Notifications.Add(new Notification
                {
                    UserId = clientUser.Id,
                    Message = "Trainer Alex approved your consultation appointment for Thursday at 10:00 AM.",
                    IsRead = false,
                    CreatedAt = DateTime.UtcNow
                });

                await context.SaveChangesAsync();
            }
        }
    }
}
