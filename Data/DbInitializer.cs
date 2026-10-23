using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
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

            // Ensure database is created and migrations are applied
            await context.Database.MigrateAsync();

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
                    FullName = "Jordan Lee",
                    Role = "Admin",
                    EmailConfirmed = true
                };
                await userManager.CreateAsync(adminUser, "Admin123!");
                await userManager.AddToRoleAsync(adminUser, "Admin");
            }

            // 3. Seed Trainers
            var trainerSeedData = new List<(string Email, string Name, string Specialty)>
            {
                ("maya.patel@healthtrack.com", "Dr. Maya Patel", "Health & Wellness Physician"),
                ("alex.henderson@healthtrack.com", "Alex Henderson", "Strength & Conditioning Coach"),
                ("trainer@healthtrack.com", "Alex Henderson", "Strength & Conditioning Coach"),
                ("chris.williams@healthtrack.com", "Chris Williams", "Senior Performance Coach"),
                ("nina.ford@healthtrack.com", "Dr. Nina Ford", "Clinical Nutritionist"),
                ("daniel.kim@healthtrack.com", "Daniel Kim", "Sports Rehab Specialist")
            };

            var trainers = new Dictionary<string, ApplicationUser>();

            foreach (var t in trainerSeedData)
            {
                var user = await userManager.FindByEmailAsync(t.Email);
                if (user == null)
                {
                    user = new ApplicationUser
                    {
                        UserName = t.Email,
                        Email = t.Email,
                        FullName = t.Name,
                        Role = "Trainer",
                        FitnessGoal = t.Specialty,
                        EmailConfirmed = true
                    };
                    await userManager.CreateAsync(user, "Trainer123!");
                    await userManager.AddToRoleAsync(user, "Trainer");
                }
                trainers[t.Email] = user;
            }

            var primaryTrainer = trainers["maya.patel@healthtrack.com"];
            var strengthCoach = trainers["alex.henderson@healthtrack.com"];
            var nutritionist = trainers["nina.ford@healthtrack.com"];
            var performanceCoach = trainers["chris.williams@healthtrack.com"];

            // 4. Seed Clients with Real Workouts, Diets, and Appointments
            var clientSeedData = new List<(string Email, string Name, string Goal, double H, double W, double TW, ApplicationUser Coach)>
            {
                ("client@healthtrack.com", "Alex Morgan", "Strength & Mobility", 178, 72.4, 70.0, primaryTrainer),
                ("alex.morgan@email.com", "Alex Morgan", "Strength & Mobility", 178, 72.4, 70.0, primaryTrainer),
                ("olivia.smith@email.com", "Olivia Smith", "Cardio Endurance", 168, 62.5, 60.0, primaryTrainer),
                ("liam.parker@email.com", "Liam Parker", "Weight Management", 182, 85.0, 78.0, primaryTrainer),
                ("sophia.chen@email.com", "Sophia Chen", "Posture & Core Stability", 165, 58.0, 56.0, strengthCoach),
                ("marcus.vance@email.com", "Marcus Vance", "Hypertrophy Phase", 180, 78.2, 75.0, performanceCoach),
                ("sarah.jenkins@email.com", "Sarah Jenkins", "Metabolic Health", 172, 69.0, 65.0, nutritionist),
                ("elena.vance@email.com", "Elena Vance", "Athletic Recovery", 170, 64.0, 62.0, primaryTrainer)
            };

            var seededClients = new List<ApplicationUser>();

            foreach (var c in clientSeedData)
            {
                var client = await userManager.FindByEmailAsync(c.Email);
                if (client == null)
                {
                    client = new ApplicationUser
                    {
                        UserName = c.Email,
                        Email = c.Email,
                        FullName = c.Name,
                        Role = "Client",
                        FitnessGoal = c.Goal,
                        HeightCm = c.H,
                        CurrentWeight = c.W,
                        TargetWeight = c.TW,
                        TrainerId = c.Coach.Id,
                        EmailConfirmed = true
                    };
                    await userManager.CreateAsync(client, "Client123!");
                    await userManager.AddToRoleAsync(client, "Client");
                }
                else
                {
                    client.TrainerId = c.Coach.Id;
                    await userManager.UpdateAsync(client);
                }
                seededClients.Add(client);
            }

            // 5. Seed Real Health Logs for Clients (Biometrics & Measurement History)
            var primaryClient = seededClients.First(c => c.Email == "client@healthtrack.com");
            if (!await context.HealthLogs.AnyAsync(h => h.ClientId == primaryClient.Id))
            {
                context.HealthLogs.AddRange(
                    new HealthLog { ClientId = primaryClient.Id, LogDate = DateTime.UtcNow.AddDays(-42), WeightKg = 74.0, CalculatedBmi = 23.4, CaloriesBurned = 450, WaterIntakeLiters = 2.5, Notes = "Baseline biometric scan - waist:84 cm" },
                    new HealthLog { ClientId = primaryClient.Id, LogDate = DateTime.UtcNow.AddDays(-28), WeightKg = 73.8, CalculatedBmi = 23.3, CaloriesBurned = 480, WaterIntakeLiters = 2.7, Notes = "Mid-cycle check-in - waist:84 cm" },
                    new HealthLog { ClientId = primaryClient.Id, LogDate = DateTime.UtcNow.AddDays(-14), WeightKg = 73.1, CalculatedBmi = 23.1, CaloriesBurned = 460, WaterIntakeLiters = 2.8, Notes = "End of month evaluation - waist:83 cm" },
                    new HealthLog { ClientId = primaryClient.Id, LogDate = DateTime.UtcNow.AddDays(-1), WeightKg = 72.4, CalculatedBmi = 22.8, CaloriesBurned = 510, WaterIntakeLiters = 3.0, Notes = "Post-workout weigh-in - waist:82 cm" }
                );
                await context.SaveChangesAsync();
            }

            // 6. Seed Real Workout Plans
            if (!await context.WorkoutPlans.AnyAsync())
            {
                var wp1 = new WorkoutPlan
                {
                    Title = "Strength & Mobility Program",
                    ClientId = primaryClient.Id,
                    TrainerId = primaryTrainer.Id,
                    CreatedAt = DateTime.UtcNow.AddDays(-10)
                };
                wp1.Exercises.Add(new WorkoutExercise { Name = "Barbell Bench Press", Sets = "4 sets", Reps = "10 reps (60 kg)", IsCompleted = true });
                wp1.Exercises.Add(new WorkoutExercise { Name = "Incline Dumbbell Rows", Sets = "3 sets", Reps = "12 reps (18 kg)", IsCompleted = true });
                wp1.Exercises.Add(new WorkoutExercise { Name = "Overhead Dumbbell Press", Sets = "3 sets", Reps = "10 reps (35 kg)", IsCompleted = false });
                wp1.Exercises.Add(new WorkoutExercise { Name = "Tricep Rope Pushdowns", Sets = "3 sets", Reps = "15 reps (25 kg)", IsCompleted = false });
                context.WorkoutPlans.Add(wp1);

                var olivia = seededClients.FirstOrDefault(c => c.Email == "olivia.smith@email.com");
                if (olivia != null)
                {
                    var wp2 = new WorkoutPlan
                    {
                        Title = "Cardio & Athletic Endurance",
                        ClientId = olivia.Id,
                        TrainerId = primaryTrainer.Id,
                        CreatedAt = DateTime.UtcNow.AddDays(-8)
                    };
                    wp2.Exercises.Add(new WorkoutExercise { Name = "Interval Sprint Drills", Sets = "6 sets", Reps = "400m intervals", IsCompleted = true });
                    wp2.Exercises.Add(new WorkoutExercise { Name = "Kettlebell Swings", Sets = "4 sets", Reps = "20 reps (16 kg)", IsCompleted = true });
                    wp2.Exercises.Add(new WorkoutExercise { Name = "Core Hollow Holds", Sets = "3 sets", Reps = "45 sec hold", IsCompleted = true });
                    context.WorkoutPlans.Add(wp2);
                }

                var liam = seededClients.FirstOrDefault(c => c.Email == "liam.parker@email.com");
                if (liam != null)
                {
                    var wp3 = new WorkoutPlan
                    {
                        Title = "Full Body Hypertrophy Split",
                        ClientId = liam.Id,
                        TrainerId = primaryTrainer.Id,
                        CreatedAt = DateTime.UtcNow.AddDays(-5)
                    };
                    wp3.Exercises.Add(new WorkoutExercise { Name = "Barbell Back Squats", Sets = "4 sets", Reps = "8 reps (90 kg)", IsCompleted = true });
                    wp3.Exercises.Add(new WorkoutExercise { Name = "Romanian Deadlifts", Sets = "4 sets", Reps = "10 reps (80 kg)", IsCompleted = true });
                    wp3.Exercises.Add(new WorkoutExercise { Name = "Bulgarian Split Squats", Sets = "3 sets", Reps = "10 reps/leg", IsCompleted = false });
                    context.WorkoutPlans.Add(wp3);
                }

                await context.SaveChangesAsync();
            }

            // 7. Seed Real Diet Plans
            if (!await context.DietPlans.AnyAsync())
            {
                var dp1 = new DietPlan
                {
                    Title = "Balanced Athletic Performance",
                    TargetCalories = 2120,
                    ClientId = primaryClient.Id,
                    CreatedAt = DateTime.UtcNow.AddDays(-10)
                };
                dp1.Meals.Add(new MealItem { MealType = "Breakfast", Description = "Greek yogurt, chia seeds & almond granola", Calories = 450 });
                dp1.Meals.Add(new MealItem { MealType = "Lunch", Description = "Grilled chicken quinoa bowl with avocado", Calories = 650 });
                dp1.Meals.Add(new MealItem { MealType = "Snack", Description = "Green protein smoothie with almond butter", Calories = 320 });
                dp1.Meals.Add(new MealItem { MealType = "Dinner", Description = "Wild salmon with roasted asparagus & sweet potato", Calories = 700 });
                context.DietPlans.Add(dp1);

                var olivia = seededClients.FirstOrDefault(c => c.Email == "olivia.smith@email.com");
                if (olivia != null)
                {
                    var dp2 = new DietPlan
                    {
                        Title = "Lean Energy & Endurance Protocol",
                        TargetCalories = 1850,
                        ClientId = olivia.Id,
                        CreatedAt = DateTime.UtcNow.AddDays(-7)
                    };
                    dp2.Meals.Add(new MealItem { MealType = "Breakfast", Description = "Poached eggs on sourdough with spinach", Calories = 400 });
                    dp2.Meals.Add(new MealItem { MealType = "Lunch", Description = "Tuna poke bowl with brown rice", Calories = 550 });
                    dp2.Meals.Add(new MealItem { MealType = "Dinner", Description = "Turkey breast meatballs with zucchini noodles", Calories = 600 });
                    dp2.Meals.Add(new MealItem { MealType = "Snack", Description = "Mixed raw walnuts and blueberries", Calories = 300 });
                    context.DietPlans.Add(dp2);
                }

                await context.SaveChangesAsync();
            }

            // 8. Seed Real Appointments across Coaches
            if (!await context.Appointments.AnyAsync())
            {
                var olivia = seededClients.FirstOrDefault(c => c.Email == "olivia.smith@email.com");
                var liam = seededClients.FirstOrDefault(c => c.Email == "liam.parker@email.com");
                var sophia = seededClients.FirstOrDefault(c => c.Email == "sophia.chen@email.com");
                var marcus = seededClients.FirstOrDefault(c => c.Email == "marcus.vance@email.com");
                var sarah = seededClients.FirstOrDefault(c => c.Email == "sarah.jenkins@email.com");

                context.Appointments.AddRange(
                    new Appointment
                    {
                        ClientId = primaryClient.Id,
                        TrainerId = primaryTrainer.Id,
                        AppointmentDate = DateTime.UtcNow.AddDays(1),
                        TimeSlot = "10:30 AM",
                        Status = "Confirmed",
                        Notes = "HEALTH CONSULTATION · 45 min - Quarterly biometric review & nutritional timing strategy."
                    },
                    new Appointment
                    {
                        ClientId = olivia?.Id ?? primaryClient.Id,
                        TrainerId = primaryTrainer.Id,
                        AppointmentDate = DateTime.UtcNow.AddDays(2),
                        TimeSlot = "02:00 PM",
                        Status = "Pending",
                        Notes = "PERSONAL TRAINING · 60 min - VO2 Max & aerobic threshold testing."
                    },
                    new Appointment
                    {
                        ClientId = liam?.Id ?? primaryClient.Id,
                        TrainerId = primaryTrainer.Id,
                        AppointmentDate = DateTime.UtcNow.AddDays(3),
                        TimeSlot = "11:00 AM",
                        Status = "Confirmed",
                        Notes = "NUTRITION REVIEW · 45 min - Macronutrient adjustment for progressive fat loss."
                    },
                    new Appointment
                    {
                        ClientId = sophia?.Id ?? primaryClient.Id,
                        TrainerId = strengthCoach.Id,
                        AppointmentDate = DateTime.UtcNow.AddDays(4),
                        TimeSlot = "09:30 AM",
                        Status = "Confirmed",
                        Notes = "STRENGTH EVALUATION · 60 min - Barbell technique & kinetic chain calibration."
                    },
                    new Appointment
                    {
                        ClientId = marcus?.Id ?? primaryClient.Id,
                        TrainerId = performanceCoach.Id,
                        AppointmentDate = DateTime.UtcNow.AddDays(-2),
                        TimeSlot = "03:00 PM",
                        Status = "Completed",
                        Notes = "HYPERTROPHY CHECK · 45 min - Program review & volume overload adjustment."
                    },
                    new Appointment
                    {
                        ClientId = sarah?.Id ?? primaryClient.Id,
                        TrainerId = nutritionist.Id,
                        AppointmentDate = DateTime.UtcNow.AddDays(-5),
                        TimeSlot = "01:15 PM",
                        Status = "Completed",
                        Notes = "METABOLIC LAB REVIEW · 45 min - Micronutrient panel evaluation."
                    },
                    new Appointment
                    {
                        ClientId = primaryClient.Id,
                        TrainerId = primaryTrainer.Id,
                        AppointmentDate = DateTime.UtcNow.AddDays(-8),
                        TimeSlot = "10:00 AM",
                        Status = "Completed",
                        Notes = "HEALTH CONSULTATION · 45 min - Baseline physical intake consultation."
                    }
                );

                await context.SaveChangesAsync();
            }

            // 9. Seed Platform Settings in DB
            if (!await context.PlatformSettings.AnyAsync())
            {
                context.PlatformSettings.AddRange(
                    new PlatformSetting { SettingKey = "SystemName", SettingValue = "HealthTrack" },
                    new PlatformSetting { SettingKey = "SupportEmail", SettingValue = "support@healthtrack.com" },
                    new PlatformSetting { SettingKey = "DefaultTimeZone", SettingValue = "UTC -05:00 Eastern Time" },
                    new PlatformSetting { SettingKey = "DateFormat", SettingValue = "MMM DD, YYYY" },
                    new PlatformSetting { SettingKey = "WorkoutReminderTiming", SettingValue = "2 hours before" },
                    new PlatformSetting { SettingKey = "WorkoutReminderEnabled", SettingValue = "true" },
                    new PlatformSetting { SettingKey = "MealReminderTiming", SettingValue = "30 minutes before" },
                    new PlatformSetting { SettingKey = "MealReminderEnabled", SettingValue = "true" },
                    new PlatformSetting { SettingKey = "AppointmentReminderTiming", SettingValue = "24 hours before" },
                    new PlatformSetting { SettingKey = "AppointmentReminderEnabled", SettingValue = "true" }
                );
                await context.SaveChangesAsync();
            }
        }
    }
}
