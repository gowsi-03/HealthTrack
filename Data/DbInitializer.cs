using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using HealthTrack.Models;

namespace HealthTrack.Data
{
    public static class DbInitializer
    {
        public static async Task SeedRolesAndUsersAsync(IServiceProvider serviceProvider)
        {
            var roleManager = serviceProvider.GetRequiredService<RoleManager<IdentityRole>>();
            var context = serviceProvider.GetRequiredService<ApplicationDbContext>();

            // Ensure database is created and migrations are applied
            await context.Database.MigrateAsync();

            // 1. Seed Roles (Admin, Trainer, Client) - required for user registration and role assignment
            string[] roles = { "Admin", "Trainer", "Client" };
            foreach (var role in roles)
            {
                if (!await roleManager.RoleExistsAsync(role))
                {
                    await roleManager.CreateAsync(new IdentityRole(role));
                }
            }

            // 2. Seed Platform Settings in DB (essential for admin settings portal)
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

            // 3. Seed Reusable Workout Templates in DB (Program Templates Library)
            if (!await context.WorkoutTemplates.AnyAsync())
            {
                context.WorkoutTemplates.AddRange(
                    new WorkoutTemplate
                    {
                        Title = "Foundation Strength",
                        Category = "Strength & Mobility",
                        DurationWeeks = 8,
                        DaysPerWeek = 4,
                        MinutesPerSession = 45,
                        Description = "A progressive full-body program designed to improve multi-joint strength, mobility and athletic endurance.",
                        BadgeClass = "badge-teal",
                        ExercisesText = @"Barbell Back Squats - 3 sets x 10 reps
Dumbbell Flat Bench Press - 3 sets x 12 reps
Romanian Deadlifts - 3 sets x 10 reps
Plank Hold - 3 sets x 45s",
                        CreatedAt = DateTime.UtcNow
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
                        ExercisesText = @"Interval Sprinting - 8 rounds x 30s on/60s off
Rowing Machine Steady Pace - 15 mins
Kettlebell Swings - 4 sets x 20 reps
Box Jumps - 3 sets x 12 reps",
                        CreatedAt = DateTime.UtcNow
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
                        ExercisesText = @"Incline Dumbbell Press - 4 sets x 10 reps
Lat Pulldown - 4 sets x 12 reps
Overhead Military Press - 3 sets x 8 reps
Barbell Bicep Curls - 3 sets x 12 reps",
                        CreatedAt = DateTime.UtcNow
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
                        ExercisesText = @"Bird Dog - 3 sets x 10 reps each
Cat-Cow Spine Stretches - 2 sets x 60s
Deadbug Core Stability - 3 sets x 12 reps
Thoracic Foam Rolling - 5 mins",
                        CreatedAt = DateTime.UtcNow
                    }
                );
                await context.SaveChangesAsync();
            }

            // 4. Seed Reusable Diet Templates in DB (Nutrition Templates Library)
            if (!await context.DietTemplates.AnyAsync())
            {
                context.DietTemplates.AddRange(
                    new DietTemplate
                    {
                        Title = "Balanced Performance Plan",
                        Category = "Balanced Nutrition",
                        DailyCalories = 2150,
                        ProteinGrams = 120,
                        MealsPerDay = 4,
                        Description = "Nutrient-dense whole food meals designed to support energy equilibrium, active training, and lean body mass.",
                        BadgeClass = "badge-teal",
                        MealsText = @"Breakfast: Oatmeal with chia seeds & protein powder (450 kcal)
Lunch: Grilled chicken salad with quinoa & avocado (650 kcal)
Snack: Greek yogurt with berries & almonds (300 kcal)
Dinner: Pan-seared salmon with sweet potato & asparagus (750 kcal)",
                        CreatedAt = DateTime.UtcNow
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
                        MealsText = @"Breakfast: Egg white scramble with turkey bacon & spinach (380 kcal)
Lunch: Tuna salad wrap with olive oil drizzle (520 kcal)
Snack: Whey protein shake with peanut butter (300 kcal)
Dinner: Lean sirloin steak with steamed broccoli (650 kcal)",
                        CreatedAt = DateTime.UtcNow
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
                        MealsText = @"Breakfast: 4 whole eggs on multigrain toast & avocado (600 kcal)
Mid-Morning: Mass shake with oats, banana & whey (500 kcal)
Lunch: Grilled chicken rice bowl with black beans (650 kcal)
Snack: Rice cakes with natural almond butter (350 kcal)
Dinner: Roasted salmon with jasmine rice & green beans (500 kcal)",
                        CreatedAt = DateTime.UtcNow
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
                        MealsText = @"Breakfast: Tofu scramble with nutritional yeast & mushrooms (420 kcal)
Lunch: Lentil quinoa bowl with tahini dressing (620 kcal)
Snack: Edamame beans with mixed seeds (320 kcal)
Dinner: Chickpea coconut curry with brown rice (640 kcal)",
                        CreatedAt = DateTime.UtcNow
                    }
                );
                await context.SaveChangesAsync();
            }

            // 5. Seed Dedicated Administrator Account (Configured in appsettings.json or fallback defaults)
            // Note: Client and Trainer roles have ZERO seeded accounts; they register dynamically or are created by users.
            var configuration = serviceProvider.GetService<IConfiguration>();
            var adminEmail = configuration?["AdminAccount:Email"] ?? "admin@healthtrack.com";
            var adminName = configuration?["AdminAccount:FullName"] ?? "System Administrator";
            var adminPassword = configuration?["AdminAccount:Password"] ?? "Admin123!";

            var userManager = serviceProvider.GetRequiredService<UserManager<ApplicationUser>>();
            var existingAdmin = await userManager.FindByEmailAsync(adminEmail);
            if (existingAdmin == null)
            {
                var adminUser = new ApplicationUser
                {
                    UserName = adminEmail,
                    Email = adminEmail,
                    FullName = adminName,
                    Role = "Admin",
                    EmailConfirmed = true
                };
                var createResult = await userManager.CreateAsync(adminUser, adminPassword);
                if (createResult.Succeeded)
                {
                    await userManager.AddToRoleAsync(adminUser, "Admin");
                }
            }
        }
    }
}
