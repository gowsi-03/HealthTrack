-- ===========================================================================
-- HealthTrack Automatic Database Seed Backup Script
-- Auto-injected on application startup by DbInitializer.cs
-- ===========================================================================
SET NOCOUNT ON;

-- ---------------------------------------------------------------------------
-- Table: [AspNetRoles]
-- ---------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM [AspNetRoles] WHERE [Id] = N'4d9e142c-0132-4414-9df1-89c9a4feca45')
    INSERT INTO [AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'4d9e142c-0132-4414-9df1-89c9a4feca45', N'Trainer', N'TRAINER', N'2b056a3d-b93f-4ba8-8795-d440c6ee45e9');
IF NOT EXISTS (SELECT 1 FROM [AspNetRoles] WHERE [Id] = N'50fc5f91-2ce5-46f6-9553-f3ed5a37ac32')
    INSERT INTO [AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'50fc5f91-2ce5-46f6-9553-f3ed5a37ac32', N'Admin', N'ADMIN', N'd9cdc605-b274-4534-b6d0-7c1743f36445');
IF NOT EXISTS (SELECT 1 FROM [AspNetRoles] WHERE [Id] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c', N'Client', N'CLIENT', N'ea956a3d-a72d-46df-bd01-d62caaf10638');

-- ---------------------------------------------------------------------------
-- Table: [AspNetUsers] (Trainers & Admins first, then Clients)
-- ---------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'10000000-0000-0000-0000-000000000001' OR [Email] = N'marcus.vance@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'10000000-0000-0000-0000-000000000001', N'marcus.vance@healthtrack.com', N'MARCUS.VANCE@HEALTHTRACK.COM', N'marcus.vance@healthtrack.com', N'MARCUS.VANCE@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'0AF07242-BFA4-4BE1-864C-2CF0953BE728', N'ca7d6789-1111-4040-945f-b7714d478eb3', NULL, 0, 0, NULL, 1, 0, NULL, NULL, N'Marcus Vance', NULL, N'Trainer', NULL, NULL, 1, '2026-09-13T13:59:09.536', N'Head strength and conditioning specialist with 9+ years coaching progressive hypertrophy, athletic power, and sustainable body recomposition.', N'CSCS, NASM-CPT, Strength & Hypertrophy Specialist', 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'10000000-0000-0000-0000-000000000002' OR [Email] = N'elena.rostova@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'10000000-0000-0000-0000-000000000002', N'elena.rostova@healthtrack.com', N'ELENA.ROSTOVA@HEALTHTRACK.COM', N'elena.rostova@healthtrack.com', N'ELENA.ROSTOVA@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'ECFB37F2-2C86-45D4-AA28-CA2CF5BF6F2F', N'b579907e-a31a-487a-802b-a9d08dd3978c', NULL, 0, 0, NULL, 1, 0, NULL, NULL, N'Elena Rostova', NULL, N'Trainer', NULL, NULL, 1, '2026-09-18T13:59:09.580', N'High-intensity metabolic conditioning and fat-loss specialist focused on cardiovascular stamina, agility, and functional endurance.', N'ACE-CPT, HIIT & Metabolic Conditioning Coach', 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'10000000-0000-0000-0000-000000000003' OR [Email] = N'david.chen@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'10000000-0000-0000-0000-000000000003', N'david.chen@healthtrack.com', N'DAVID.CHEN@HEALTHTRACK.COM', N'david.chen@healthtrack.com', N'DAVID.CHEN@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'9DC6948E-027F-47A0-BDCA-80C72A260455', N'fa34e327-d065-4feb-a28d-78e95aafb55d', NULL, 0, 0, NULL, 1, 0, NULL, NULL, N'David Chen', NULL, N'Trainer', NULL, NULL, 1, '2026-09-23T13:59:09.590', N'Corrective exercise and bodyweight strength coach dedicated to joint longevity, spinal alignment, and functional core control.', N'NASM-CES, Mobility, Calisthenics & Rehab Specialist', 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'10000000-0000-0000-0000-000000000004' OR [Email] = N'sarah.jenkins@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'10000000-0000-0000-0000-000000000004', N'sarah.jenkins@healthtrack.com', N'SARAH.JENKINS@HEALTHTRACK.COM', N'sarah.jenkins@healthtrack.com', N'SARAH.JENKINS@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'A14E6827-D536-4442-8969-B8735DAD04F5', N'28161b7a-37d5-4161-8a7c-e10bc31b9eb9', NULL, 0, 0, NULL, 1, 0, NULL, NULL, N'Dr. Sarah Jenkins', NULL, N'Trainer', NULL, NULL, 1, '2026-09-28T13:59:09.600', N'Clinical sports dietitian and holistic wellness coach specializing in macronutrient periodization, metabolic health, and endurance fueling.', N'RD, CSSD, Clinical Nutrition & Wellness Coach', 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'10000000-0000-0000-0000-000000000005' OR [Email] = N'aarav.patel@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'10000000-0000-0000-0000-000000000005', N'aarav.patel@healthtrack.com', N'AARAV.PATEL@HEALTHTRACK.COM', N'aarav.patel@healthtrack.com', N'AARAV.PATEL@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'7746FD91-F760-4CF9-ABC0-93B4A96E7AA9', N'1c31254b-e8d5-46d4-b17b-9cd2ae29930d', NULL, 0, 0, NULL, 1, 0, NULL, NULL, N'Aarav Patel', NULL, N'Trainer', NULL, NULL, 1, '2026-10-03T13:59:09.610', N'Competitive powerlifting and athletic performance coach helping clients master compound biomechanics and peak strength output.', N'USAPL Coach, ISSN Sports Power & Performance', 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'accf4c77-c4cc-4bd6-b8a9-ed530a352345' OR [Email] = N'admin@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'accf4c77-c4cc-4bd6-b8a9-ed530a352345', N'admin@healthtrack.com', N'ADMIN@HEALTHTRACK.COM', N'admin@healthtrack.com', N'ADMIN@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHPBSmsTYTG8YQWKIrXaaBCcITyLaGB1cN/RvTotvFBAG17Tt8mWFvabDCAeDmqQAw==', N'G3VHHDRG4MZHTVMZRKQ62E56WK235VFL', N'74464bc5-08f4-4b31-b590-3fac2f3825c4', NULL, 0, 0, NULL, 1, 0, NULL, NULL, N'System Administrator', NULL, N'Admin', NULL, NULL, 1, '2026-10-24T14:31:43.712', NULL, NULL, 0);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000001' OR [Email] = N'ethan.brooks@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000001', N'ethan.brooks@healthtrack.com', N'ETHAN.BROOKS@HEALTHTRACK.COM', N'ethan.brooks@healthtrack.com', N'ETHAN.BROOKS@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'5B4E051F-0081-4DDC-B21F-FB3D83DC61CE', N'87efe5c3-7197-49c5-b9df-3f44f2d4ef47', NULL, 0, 0, NULL, 1, 0, 83.5, N'Lean Muscle & Recomposition', N'Ethan Brooks', 181, N'Client', 78, N'10000000-0000-0000-0000-000000000001', 1, '2026-10-09T13:59:09.633', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000002' OR [Email] = N'chloe.bennett@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000002', N'chloe.bennett@healthtrack.com', N'CHLOE.BENNETT@HEALTHTRACK.COM', N'chloe.bennett@healthtrack.com', N'CHLOE.BENNETT@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'12314C6E-8B6A-45D1-A18F-DB131EE14277', N'aafd6971-f44f-4b12-b413-162d97563858', NULL, 0, 0, NULL, 1, 0, 64, N'Glute & Core Sculpting', N'Chloe Bennett', 166, N'Client', 59, N'10000000-0000-0000-0000-000000000001', 1, '2026-10-10T13:59:09.940', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000003' OR [Email] = N'caleb.foster@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000003', N'caleb.foster@healthtrack.com', N'CALEB.FOSTER@HEALTHTRACK.COM', N'caleb.foster@healthtrack.com', N'CALEB.FOSTER@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'0E1CFB31-6A93-45B2-8DFD-9A906238A052', N'd708113d-e4e0-4f61-9d42-7fe1602c834c', NULL, 0, 0, NULL, 1, 0, 74.5, N'Hypertrophy & Mass Gain', N'Caleb Foster', 178, N'Client', 80, N'10000000-0000-0000-0000-000000000001', 1, '2026-10-11T13:59:10.113', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000004' OR [Email] = N'zoe.coleman@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000004', N'zoe.coleman@healthtrack.com', N'ZOE.COLEMAN@HEALTHTRACK.COM', N'zoe.coleman@healthtrack.com', N'ZOE.COLEMAN@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'69AB4B2A-D961-4F40-9A4A-A73BC63CEA50', N'f0558047-affe-4eae-acad-180aac371570', NULL, 0, 0, NULL, 1, 0, 61.5, N'Strength & Metabolic Tone', N'Zoe Coleman', 164, N'Client', 57, N'10000000-0000-0000-0000-000000000001', 1, '2026-10-12T13:59:10.276', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000005' OR [Email] = N'nathan.perry@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000005', N'nathan.perry@healthtrack.com', N'NATHAN.PERRY@HEALTHTRACK.COM', N'nathan.perry@healthtrack.com', N'NATHAN.PERRY@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'4DDD310A-7533-4C9B-8883-2ED18D7DE0BE', N'83921d07-330a-48c0-a103-0a9ec3972418', NULL, 0, 0, NULL, 1, 0, 91, N'Fat Loss & Upper Body Power', N'Nathan Perry', 184, N'Client', 84, N'10000000-0000-0000-0000-000000000001', 1, '2026-10-13T13:59:10.410', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000006' OR [Email] = N'hannah.reed@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000006', N'hannah.reed@healthtrack.com', N'HANNAH.REED@HEALTHTRACK.COM', N'hannah.reed@healthtrack.com', N'HANNAH.REED@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'22C67D4E-435D-460F-8A2C-A7425C4418ED', N'8609e4cd-206f-4073-81aa-50283f138a6c', NULL, 0, 0, NULL, 1, 0, 66.5, N'Athletic Strength & Definition', N'Hannah Reed', 169, N'Client', 62, N'10000000-0000-0000-0000-000000000001', 1, '2026-10-14T13:59:10.550', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000007' OR [Email] = N'ryan.hughes@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000007', N'ryan.hughes@healthtrack.com', N'RYAN.HUGHES@HEALTHTRACK.COM', N'ryan.hughes@healthtrack.com', N'RYAN.HUGHES@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'F7A26C62-9032-4A2A-9C1F-74ABA6AADF95', N'a5bfd22f-b713-4ce8-9dfd-e7cbf22d105c', NULL, 0, 0, NULL, 1, 0, 79, N'Compound Lift Progression', N'Ryan Hughes', 176, N'Client', 75, N'10000000-0000-0000-0000-000000000001', 1, '2026-10-15T13:59:10.700', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000008' OR [Email] = N'audrey.price@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000008', N'audrey.price@healthtrack.com', N'AUDREY.PRICE@HEALTHTRACK.COM', N'audrey.price@healthtrack.com', N'AUDREY.PRICE@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'46B95FD7-1884-4B0A-9AEA-B83C8ED7048E', N'a72dea32-1e4e-468f-a280-19e0523a4277', NULL, 0, 0, NULL, 1, 0, 58.5, N'Total Body Toning', N'Audrey Price', 162, N'Client', 55, N'10000000-0000-0000-0000-000000000001', 1, '2026-10-16T13:59:10.833', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000009' OR [Email] = N'dylan.sanders@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000009', N'dylan.sanders@healthtrack.com', N'DYLAN.SANDERS@HEALTHTRACK.COM', N'dylan.sanders@healthtrack.com', N'DYLAN.SANDERS@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'6C14C2BB-B05C-4A0A-8AC4-4A01874A951E', N'e84fddea-2480-4813-afa5-1f48f28659d1', NULL, 0, 0, NULL, 1, 0, 86, N'Lean Hypertrophy Split', N'Dylan Sanders', 182, N'Client', 81, N'10000000-0000-0000-0000-000000000001', 1, '2026-10-17T13:59:11.023', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000010' OR [Email] = N'claire.morris@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000010', N'claire.morris@healthtrack.com', N'CLAIRE.MORRIS@HEALTHTRACK.COM', N'claire.morris@healthtrack.com', N'CLAIRE.MORRIS@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'296F0C8E-465B-42B7-8B4E-737B84103D09', N'25243e34-53d7-42b6-8a26-b0794edb7268', NULL, 0, 0, NULL, 1, 0, 63, N'Resistance Conditioning', N'Claire Morris', 167, N'Client', 58.5, N'10000000-0000-0000-0000-000000000001', 1, '2026-10-18T13:59:11.193', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000011' OR [Email] = N'julian.ross@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000011', N'julian.ross@healthtrack.com', N'JULIAN.ROSS@HEALTHTRACK.COM', N'julian.ross@healthtrack.com', N'JULIAN.ROSS@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'92B2809D-EA24-40BC-8F79-F321F346CBF4', N'79299e9a-5af0-4f85-b17b-1a712bccc429', NULL, 0, 0, NULL, 1, 0, 85, N'HIIT Fat Loss & Agility', N'Julian Ross', 179, N'Client', 77, N'10000000-0000-0000-0000-000000000002', 1, '2026-10-19T13:59:11.366', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000012' OR [Email] = N'stella.morales@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000012', N'stella.morales@healthtrack.com', N'STELLA.MORALES@HEALTHTRACK.COM', N'stella.morales@healthtrack.com', N'STELLA.MORALES@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'AAD4B35C-734D-4542-AE8C-698ABC71FC50', N'83f48df0-3a8a-4820-9c4f-90a6dd6d6fc5', NULL, 0, 0, NULL, 1, 0, 65.5, N'Metabolic Conditioning', N'Stella Morales', 163, N'Client', 58, N'10000000-0000-0000-0000-000000000002', 1, '2026-10-20T13:59:11.556', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000013' OR [Email] = N'aaron.ortiz@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000013', N'aaron.ortiz@healthtrack.com', N'AARON.ORTIZ@HEALTHTRACK.COM', N'aaron.ortiz@healthtrack.com', N'AARON.ORTIZ@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'7BDF1E0A-4F3E-4C1B-AF4C-DA4C1DDC776A', N'be75bbb4-32bf-44fa-949f-84db55d3d057', NULL, 0, 0, NULL, 1, 0, 81, N'Sprint & Cardio Stamina', N'Aaron Ortiz', 175, N'Client', 74, N'10000000-0000-0000-0000-000000000002', 1, '2026-10-21T13:59:11.743', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000014' OR [Email] = N'nora.jenkins@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000014', N'nora.jenkins@healthtrack.com', N'NORA.JENKINS@HEALTHTRACK.COM', N'nora.jenkins@healthtrack.com', N'NORA.JENKINS@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'6EAFD6AC-FB9C-4CC8-904F-F6C20363B535', N'8b243a77-4b80-43fe-8f3b-0f1b98353714', NULL, 0, 0, NULL, 1, 0, 67, N'Calorie Burn & Core Endurance', N'Nora Jenkins', 168, N'Client', 61, N'10000000-0000-0000-0000-000000000002', 1, '2026-10-22T13:59:11.860', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000015' OR [Email] = N'adrian.flores@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000015', N'adrian.flores@healthtrack.com', N'ADRIAN.FLORES@HEALTHTRACK.COM', N'adrian.flores@healthtrack.com', N'ADRIAN.FLORES@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'948D5D30-828A-4AF0-BC76-E50B81B23960', N'a684286d-e162-41c3-984c-cd00d474ff48', NULL, 0, 0, NULL, 1, 0, 88.5, N'Kettlebell & Interval Shred', N'Adrian Flores', 180, N'Client', 80, N'10000000-0000-0000-0000-000000000002', 1, '2026-10-23T13:59:12.053', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000016' OR [Email] = N'leo.barnes@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000016', N'leo.barnes@healthtrack.com', N'LEO.BARNES@HEALTHTRACK.COM', N'leo.barnes@healthtrack.com', N'LEO.BARNES@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'D3B3B69A-191B-474C-9349-36B8BC6979B2', N'af622e63-07e4-4b2f-9aca-c186d76abb1e', NULL, 0, 0, NULL, 1, 0, 71, N'Calisthenics & Upper Control', N'Leo Barnes', 174, N'Client', 73, N'10000000-0000-0000-0000-000000000003', 1, '2026-10-24T13:59:12.216', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000017' OR [Email] = N'maya.fisher@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000017', N'maya.fisher@healthtrack.com', N'MAYA.FISHER@HEALTHTRACK.COM', N'maya.fisher@healthtrack.com', N'MAYA.FISHER@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'3E9FB94D-CF72-460F-B403-ACA86D51EA1C', N'7dded832-8bb3-450b-994a-cbd0c419f0e6', NULL, 0, 0, NULL, 1, 0, 56, N'Posture & Spinal Mobility', N'Maya Fisher', 161, N'Client', 55, N'10000000-0000-0000-0000-000000000003', 1, '2026-10-25T13:59:12.353', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000018' OR [Email] = N'eli.henderson@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000018', N'eli.henderson@healthtrack.com', N'ELI.HENDERSON@HEALTHTRACK.COM', N'eli.henderson@healthtrack.com', N'ELI.HENDERSON@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'8B83ACAD-C8BD-4A4A-9E96-405ABF68BFB5', N'f78fdf48-faf2-4605-a2df-2dad7e5ee54e', NULL, 0, 0, NULL, 1, 0, 76.5, N'Joint Longevity & Core Stability', N'Eli Henderson', 177, N'Client', 74, N'10000000-0000-0000-0000-000000000003', 1, '2026-10-26T13:59:12.460', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000019' OR [Email] = N'lucy.cole@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000019', N'lucy.cole@healthtrack.com', N'LUCY.COLE@HEALTHTRACK.COM', N'lucy.cole@healthtrack.com', N'LUCY.COLE@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'83CF8ACF-EC9B-4F88-B713-A513E7F9F3C9', N'76593428-d884-4138-ac15-b4cfbca5286c', NULL, 0, 0, NULL, 1, 0, 60.5, N'Flexibility & Bodyweight Strength', N'Lucy Cole', 165, N'Client', 58, N'10000000-0000-0000-0000-000000000003', 1, '2026-10-27T13:59:12.616', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000020' OR [Email] = N'connor.powell@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000020', N'connor.powell@healthtrack.com', N'CONNOR.POWELL@HEALTHTRACK.COM', N'connor.powell@healthtrack.com', N'CONNOR.POWELL@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'06816A94-A21C-41FD-B6E4-9D2BA51814A2', N'95f76a62-5314-449e-b002-5e49fa3ad036', NULL, 0, 0, NULL, 1, 0, 79.5, N'Shoulder Rehab & Functional Flow', N'Connor Powell', 181, N'Client', 76, N'10000000-0000-0000-0000-000000000003', 1, '2026-10-28T13:59:12.753', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000021' OR [Email] = N'landon.butler@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000021', N'landon.butler@healthtrack.com', N'LANDON.BUTLER@HEALTHTRACK.COM', N'landon.butler@healthtrack.com', N'LANDON.BUTLER@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'488D7923-9BDE-4B58-83DE-EAEC36F6F721', N'c00e20e0-31c5-4c9f-b149-9af118be57c8', NULL, 0, 0, NULL, 1, 0, 87, N'Sustainable Nutrition & Weight Loss', N'Landon Butler', 180, N'Client', 79, N'10000000-0000-0000-0000-000000000004', 1, '2026-10-29T13:59:12.996', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000022' OR [Email] = N'violet.simmons@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000022', N'violet.simmons@healthtrack.com', N'VIOLET.SIMMONS@HEALTHTRACK.COM', N'violet.simmons@healthtrack.com', N'VIOLET.SIMMONS@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'81FF3AF7-BC1D-4892-928D-8235C5AC22EA', N'2cf3b8c9-d85f-45c8-b7df-85238176a376', NULL, 0, 0, NULL, 1, 0, 62.5, N'Macro Balance & Energy Optimization', N'Violet Simmons', 164, N'Client', 57.5, N'10000000-0000-0000-0000-000000000004', 1, '2026-10-30T13:59:13.130', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000023' OR [Email] = N'gavin.russell@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000023', N'gavin.russell@healthtrack.com', N'GAVIN.RUSSELL@HEALTHTRACK.COM', N'gavin.russell@healthtrack.com', N'GAVIN.RUSSELL@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'8AE6C3F7-4BB5-4992-B684-FE68CD2A0912', N'1787805b-b046-422b-aa68-8b451b90fffa', NULL, 0, 0, NULL, 1, 0, 82, N'Cardiovascular Longevity & Diet', N'Gavin Russell', 176, N'Client', 76, N'10000000-0000-0000-0000-000000000004', 1, '2026-10-31T13:59:13.240', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000024' OR [Email] = N'hazel.griffin@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000024', N'hazel.griffin@healthtrack.com', N'HAZEL.GRIFFIN@HEALTHTRACK.COM', N'hazel.griffin@healthtrack.com', N'HAZEL.GRIFFIN@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'5BFA17EE-D7B0-450A-B8BC-118DEB216B6E', N'b1d4c96b-54da-44f6-98e4-b6996e854a67', NULL, 0, 0, NULL, 1, 0, 64.5, N'Clean Eating & Aerobic Fitness', N'Hazel Griffin', 167, N'Client', 60, N'10000000-0000-0000-0000-000000000004', 1, '2026-11-01T13:59:13.363', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000025' OR [Email] = N'wyatt.diaz@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000025', N'wyatt.diaz@healthtrack.com', N'WYATT.DIAZ@HEALTHTRACK.COM', N'wyatt.diaz@healthtrack.com', N'WYATT.DIAZ@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'2B4CEE57-B8F6-4EAE-ADC3-8237D553ACE9', N'e481dd64-b07f-41bb-88e9-cc8ce041bb9f', NULL, 0, 0, NULL, 1, 0, 89, N'Glycemic Control & Active Recovery', N'Wyatt Diaz', 183, N'Client', 82, N'10000000-0000-0000-0000-000000000004', 1, '2026-10-08T13:59:13.496', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000026' OR [Email] = N'dominic.hayes@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000026', N'dominic.hayes@healthtrack.com', N'DOMINIC.HAYES@HEALTHTRACK.COM', N'dominic.hayes@healthtrack.com', N'DOMINIC.HAYES@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'DD05D420-3741-453A-9D1D-C15EF0CBD774', N'e5cfe0a8-ca3e-403a-8eec-996b4a48f832', NULL, 0, 0, NULL, 1, 0, 92.5, N'Powerlifting & Maximal Strength', N'Dominic Hayes', 185, N'Client', 96, N'10000000-0000-0000-0000-000000000005', 1, '2026-10-09T13:59:13.640', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000027' OR [Email] = N'ruby.myers@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000027', N'ruby.myers@healthtrack.com', N'RUBY.MYERS@HEALTHTRACK.COM', N'ruby.myers@healthtrack.com', N'RUBY.MYERS@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'77C86E2F-3D05-4EF7-B4CD-BA0EEE745B1B', N'739a6a84-d6e7-4651-ae2b-e2f72618d141', NULL, 0, 0, NULL, 1, 0, 63.5, N'Barbell Strength & Lower Body Power', N'Ruby Myers', 166, N'Client', 61, N'10000000-0000-0000-0000-000000000005', 1, '2026-10-10T13:59:13.793', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000028' OR [Email] = N'xavier.ford@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000028', N'xavier.ford@healthtrack.com', N'XAVIER.FORD@HEALTHTRACK.COM', N'xavier.ford@healthtrack.com', N'XAVIER.FORD@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'43FF75F7-7891-4969-89F9-7B1FBBDE9AC8', N'b39a19ad-63f0-4150-8af6-c795af514422', NULL, 0, 0, NULL, 1, 0, 84, N'Compound Squat & Deadlift PR', N'Xavier Ford', 179, N'Client', 88, N'10000000-0000-0000-0000-000000000005', 1, '2026-10-11T13:59:13.956', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000029' OR [Email] = N'alice.hamilton@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000029', N'alice.hamilton@healthtrack.com', N'ALICE.HAMILTON@HEALTHTRACK.COM', N'alice.hamilton@healthtrack.com', N'ALICE.HAMILTON@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'CD210F0A-B469-4726-B0B6-186BC3D466EF', N'f20538d8-922d-4792-bb06-8aa23c305e5b', NULL, 0, 0, NULL, 1, 0, 59.5, N'Strength-to-Weight Ratio', N'Alice Hamilton', 163, N'Client', 58, N'10000000-0000-0000-0000-000000000005', 1, '2026-10-12T13:59:14.150', NULL, NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [AspNetUsers] WHERE [Id] = N'20000000-0000-0000-0000-000000000030' OR [Email] = N'miles.graham@healthtrack.com')
    INSERT INTO [AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [CurrentWeight], [FitnessGoal], [FullName], [HeightCm], [Role], [TargetWeight], [TrainerId], [IsApproved], [CreatedAt], [Bio], [Certifications], [IsProfileCompleted]) VALUES (N'20000000-0000-0000-0000-000000000030', N'miles.graham@healthtrack.com', N'MILES.GRAHAM@HEALTHTRACK.COM', N'miles.graham@healthtrack.com', N'MILES.GRAHAM@HEALTHTRACK.COM', 1, N'AQAAAAIAAYagAAAAEHL5DVVNbC7/RLnGh9qQkWo52X5kcagtzd091GjT5WiLx5lwrZd+txUVWxH5jH8AHw==', N'6D5CC27D-36E8-475A-87EC-CC163A08B518', N'39903b7d-2c93-4660-af63-73238b75a624', NULL, 0, 0, NULL, 1, 0, 87.5, N'Explosive Power & Conditioning', N'Miles Graham', 182, N'Client', 83, N'10000000-0000-0000-0000-000000000005', 1, '2026-10-13T13:59:14.320', NULL, NULL, 1);

-- ---------------------------------------------------------------------------
-- Table: [AspNetUserRoles]
-- ---------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'10000000-0000-0000-0000-000000000001' AND [RoleId] = N'4d9e142c-0132-4414-9df1-89c9a4feca45')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'10000000-0000-0000-0000-000000000001', N'4d9e142c-0132-4414-9df1-89c9a4feca45');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'10000000-0000-0000-0000-000000000002' AND [RoleId] = N'4d9e142c-0132-4414-9df1-89c9a4feca45')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'10000000-0000-0000-0000-000000000002', N'4d9e142c-0132-4414-9df1-89c9a4feca45');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'10000000-0000-0000-0000-000000000003' AND [RoleId] = N'4d9e142c-0132-4414-9df1-89c9a4feca45')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'10000000-0000-0000-0000-000000000003', N'4d9e142c-0132-4414-9df1-89c9a4feca45');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'10000000-0000-0000-0000-000000000004' AND [RoleId] = N'4d9e142c-0132-4414-9df1-89c9a4feca45')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'10000000-0000-0000-0000-000000000004', N'4d9e142c-0132-4414-9df1-89c9a4feca45');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'10000000-0000-0000-0000-000000000005' AND [RoleId] = N'4d9e142c-0132-4414-9df1-89c9a4feca45')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'10000000-0000-0000-0000-000000000005', N'4d9e142c-0132-4414-9df1-89c9a4feca45');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000001' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000001', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000002' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000002', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000003' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000003', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000004' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000004', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000005' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000005', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000006' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000006', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000007' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000007', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000008' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000008', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000009' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000009', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000010' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000010', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000011' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000011', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000012' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000012', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000013' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000013', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000014' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000014', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000015' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000015', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000016' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000016', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000017' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000017', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000018' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000018', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000019' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000019', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000020' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000020', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000021' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000021', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000022' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000022', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000023' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000023', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000024' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000024', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000025' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000025', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000026' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000026', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000027' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000027', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000028' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000028', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000029' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000029', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'20000000-0000-0000-0000-000000000030' AND [RoleId] = N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20000000-0000-0000-0000-000000000030', N'dfbfb6cb-f61f-4d2b-b33f-a61aa961871c');
IF NOT EXISTS (SELECT 1 FROM [AspNetUserRoles] WHERE [UserId] = N'accf4c77-c4cc-4bd6-b8a9-ed530a352345' AND [RoleId] = N'50fc5f91-2ce5-46f6-9553-f3ed5a37ac32')
    INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'accf4c77-c4cc-4bd6-b8a9-ed530a352345', N'50fc5f91-2ce5-46f6-9553-f3ed5a37ac32');

-- ---------------------------------------------------------------------------
-- Table: [PlatformSettings]
-- ---------------------------------------------------------------------------
SET IDENTITY_INSERT [PlatformSettings] ON;
IF NOT EXISTS (SELECT 1 FROM [PlatformSettings] WHERE [Id] = 1)
    INSERT INTO [PlatformSettings] ([Id], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (1, N'SystemName', N'HealthTrack', '2026-11-12T13:59:09.356');
IF NOT EXISTS (SELECT 1 FROM [PlatformSettings] WHERE [Id] = 2)
    INSERT INTO [PlatformSettings] ([Id], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (2, N'SupportEmail', N'support@healthtrack.com', '2026-11-12T13:59:09.363');
IF NOT EXISTS (SELECT 1 FROM [PlatformSettings] WHERE [Id] = 3)
    INSERT INTO [PlatformSettings] ([Id], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (3, N'DefaultTimeZone', N'UTC -05:00 Eastern Time', '2026-11-12T13:59:09.370');
IF NOT EXISTS (SELECT 1 FROM [PlatformSettings] WHERE [Id] = 4)
    INSERT INTO [PlatformSettings] ([Id], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (4, N'DateFormat', N'MMM DD, YYYY', '2026-11-12T13:59:09.376');
IF NOT EXISTS (SELECT 1 FROM [PlatformSettings] WHERE [Id] = 5)
    INSERT INTO [PlatformSettings] ([Id], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (5, N'WorkoutReminderTiming', N'1 hour before', '2026-11-12T13:59:09.380');
IF NOT EXISTS (SELECT 1 FROM [PlatformSettings] WHERE [Id] = 6)
    INSERT INTO [PlatformSettings] ([Id], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (6, N'WorkoutReminderEnabled', N'true', '2026-11-12T13:59:09.386');
IF NOT EXISTS (SELECT 1 FROM [PlatformSettings] WHERE [Id] = 7)
    INSERT INTO [PlatformSettings] ([Id], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (7, N'MealReminderTiming', N'30 minutes before', '2026-11-12T13:59:09.390');
IF NOT EXISTS (SELECT 1 FROM [PlatformSettings] WHERE [Id] = 8)
    INSERT INTO [PlatformSettings] ([Id], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (8, N'MealReminderEnabled', N'true', '2026-11-12T13:59:09.396');
IF NOT EXISTS (SELECT 1 FROM [PlatformSettings] WHERE [Id] = 9)
    INSERT INTO [PlatformSettings] ([Id], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (9, N'AppointmentReminderTiming', N'24 hours before', '2026-11-12T13:59:09.406');
IF NOT EXISTS (SELECT 1 FROM [PlatformSettings] WHERE [Id] = 10)
    INSERT INTO [PlatformSettings] ([Id], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (10, N'AppointmentReminderEnabled', N'true', '2026-11-12T13:59:09.413');
SET IDENTITY_INSERT [PlatformSettings] OFF;

-- ---------------------------------------------------------------------------
-- Table: [WorkoutTemplates]
-- ---------------------------------------------------------------------------
SET IDENTITY_INSERT [WorkoutTemplates] ON;
IF NOT EXISTS (SELECT 1 FROM [WorkoutTemplates] WHERE [Id] = 1)
    INSERT INTO [WorkoutTemplates] ([Id], [Title], [Category], [DurationWeeks], [DaysPerWeek], [MinutesPerSession], [Description], [BadgeClass], [ExercisesText], [TrainerId], [CreatedAt]) VALUES (1, N'Hypertrophy & Progressive Strength', N'Strength & Hypertrophy', 8, 4, 50, N'Progressive compound barbell and dumbbell split targeting lean muscle growth and multi-joint strength.', N'badge-teal', N'Barbell Back Squat - 4 sets x 8 reps
Incline Dumbbell Press - 4 sets x 10 reps
Romanian Deadlift - 3 sets x 10 reps
Weighted Plank Hold - 3 sets x 60s', NULL, '2026-10-13T13:59:09.433');
IF NOT EXISTS (SELECT 1 FROM [WorkoutTemplates] WHERE [Id] = 2)
    INSERT INTO [WorkoutTemplates] ([Id], [Title], [Category], [DurationWeeks], [DaysPerWeek], [MinutesPerSession], [Description], [BadgeClass], [ExercisesText], [TrainerId], [CreatedAt]) VALUES (2, N'HIIT Metabolic Conditioning', N'Cardio & HIIT', 6, 4, 40, N'High-intensity interval circuits engineered to maximize caloric expenditure and VO2 max endurance.', N'badge-blue', N'Kettlebell Swings - 4 sets x 20 reps
Battle Rope Sprints - 6 rounds x 30s
Box Jumps - 4 sets x 12 reps
Rowing Ergometer Intervals - 12 mins', NULL, '2026-10-13T13:59:09.453');
IF NOT EXISTS (SELECT 1 FROM [WorkoutTemplates] WHERE [Id] = 3)
    INSERT INTO [WorkoutTemplates] ([Id], [Title], [Category], [DurationWeeks], [DaysPerWeek], [MinutesPerSession], [Description], [BadgeClass], [ExercisesText], [TrainerId], [CreatedAt]) VALUES (3, N'Calisthenics & Joint Mobility Flow', N'Mobility & Rehab', 6, 3, 45, N'Bodyweight strength mastery combined with thoracic, hip, and scapular decompression.', N'badge-amber', N'Strict Pull-Ups - 4 sets x 8 reps
Ring Push-Ups - 3 sets x 12 reps
Cossack Squat Mobility - 3 sets x 10 reps
Hollow Body Core Hold - 4 sets x 45s', NULL, '2026-10-13T13:59:09.460');
IF NOT EXISTS (SELECT 1 FROM [WorkoutTemplates] WHERE [Id] = 4)
    INSERT INTO [WorkoutTemplates] ([Id], [Title], [Category], [DurationWeeks], [DaysPerWeek], [MinutesPerSession], [Description], [BadgeClass], [ExercisesText], [TrainerId], [CreatedAt]) VALUES (4, N'Powerbuilding & Athletic Peak', N'Power & Performance', 10, 5, 60, N'Heavy compound powerlifting movements paired with explosive athletic accessory work.', N'badge-purple', N'Competition Bench Press - 5 sets x 5 reps
Conventional Barbell Deadlift - 4 sets x 5 reps
Overhead Barbell Press - 4 sets x 8 reps
Pendlay Barbell Row - 4 sets x 8 reps', NULL, '2026-10-13T13:59:09.466');
SET IDENTITY_INSERT [WorkoutTemplates] OFF;

-- ---------------------------------------------------------------------------
-- Table: [DietTemplates]
-- ---------------------------------------------------------------------------
SET IDENTITY_INSERT [DietTemplates] ON;
IF NOT EXISTS (SELECT 1 FROM [DietTemplates] WHERE [Id] = 1)
    INSERT INTO [DietTemplates] ([Id], [Title], [Category], [DailyCalories], [ProteinGrams], [MealsPerDay], [Description], [BadgeClass], [MealsText], [TrainerId], [CreatedAt]) VALUES (1, N'Lean Recomposition Macro Protocol', N'Body Recomposition', 2200, 165, 4, N'High-protein balanced carbohydrate nutrition plan supporting lean muscle retention and steady fat loss.', N'badge-teal', N'Breakfast: Rolled oats with whey isolate, blueberries & chia seeds (520 kcal)
Lunch: Herb-grilled chicken breast, jasmine rice & roasted broccoli (640 kcal)
Snack: Greek yogurt parfait with walnuts & honey (340 kcal)
Dinner: Pan-seared Atlantic salmon, sweet potato mash & asparagus (700 kcal)', NULL, '2026-10-13T13:59:09.483');
IF NOT EXISTS (SELECT 1 FROM [DietTemplates] WHERE [Id] = 2)
    INSERT INTO [DietTemplates] ([Id], [Title], [Category], [DailyCalories], [ProteinGrams], [MealsPerDay], [Description], [BadgeClass], [MealsText], [TrainerId], [CreatedAt]) VALUES (2, N'Metabolic Shred Caloric Deficit', N'Fat Loss', 1850, 150, 4, N'Nutrient-dense, high-satiety deficit protocol optimized for rapid fat oxidation without energy crashes.', N'badge-blue', N'Breakfast: Egg white & whole egg spinach omelet with Ezekiel toast (410 kcal)
Lunch: Albacore tuna quinoa power bowl with olive oil lemon dressing (510 kcal)
Snack: Isolate protein shake with raw almonds (290 kcal)
Dinner: Lean turkey tenderloin with zucchini noodles & marinara (640 kcal)', NULL, '2026-10-13T13:59:09.486');
IF NOT EXISTS (SELECT 1 FROM [DietTemplates] WHERE [Id] = 3)
    INSERT INTO [DietTemplates] ([Id], [Title], [Category], [DailyCalories], [ProteinGrams], [MealsPerDay], [Description], [BadgeClass], [MealsText], [TrainerId], [CreatedAt]) VALUES (3, N'Anti-Inflammatory Mobility & Recovery Fuel', N'Wellness & Recovery', 2050, 135, 4, N'Omega-3 and micronutrient-rich whole-food plan supporting joint health, collagen synthesis, and recovery.', N'badge-amber', N'Breakfast: Chia pudding with collagen peptides, kiwi & pumpkin seeds (460 kcal)
Lunch: Mediterranean lentil & grilled halloumi salad with extra virgin olive oil (590 kcal)
Snack: Cottage cheese with pineapple & flaxseeds (310 kcal)
Dinner: Baked cod fillet with wild rice pilaf & sauteed kale (690 kcal)', NULL, '2026-10-13T13:59:09.500');
IF NOT EXISTS (SELECT 1 FROM [DietTemplates] WHERE [Id] = 4)
    INSERT INTO [DietTemplates] ([Id], [Title], [Category], [DailyCalories], [ProteinGrams], [MealsPerDay], [Description], [BadgeClass], [MealsText], [TrainerId], [CreatedAt]) VALUES (4, N'Athletic Power & Hypertrophy Surplus', N'Strength & Mass', 2750, 185, 4, N'High-glycogen performance nutrition fueling heavy compound training and maximal muscular recovery.', N'badge-purple', N'Breakfast: 4 whole pasture-raised eggs, sourdough toast, avocado & turkey bacon (680 kcal)
Lunch: Grass-fed sirloin steak bowl with cilantro lime rice & black beans (820 kcal)
Snack: Oats, banana, peanut butter & whey isolate recovery smoothie (480 kcal)
Dinner: Roasted chicken thighs, baked russet potatoes & green beans (770 kcal)', NULL, '2026-10-13T13:59:09.506');
SET IDENTITY_INSERT [DietTemplates] OFF;

-- ---------------------------------------------------------------------------
-- Table: [WorkoutPlans]
-- ---------------------------------------------------------------------------
SET IDENTITY_INSERT [WorkoutPlans] ON;
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 1)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (1, N'Upper / Lower Hypertrophy Split', N'Personalized training block tailored for Ethan Brooks focusing on Lean Muscle & Recomposition.', '2026-10-26T13:59:09.680', N'20000000-0000-0000-0000-000000000001', N'10000000-0000-0000-0000-000000000001', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 2)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (2, N'Lower Body & Core Sculpt Routine', N'Personalized training block tailored for Chloe Bennett focusing on Glute & Core Sculpting.', '2026-10-27T13:59:09.956', N'20000000-0000-0000-0000-000000000002', N'10000000-0000-0000-0000-000000000001', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 3)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (3, N'Progressive Push / Pull / Legs', N'Personalized training block tailored for Caleb Foster focusing on Hypertrophy & Mass Gain.', '2026-10-28T13:59:10.136', N'20000000-0000-0000-0000-000000000003', N'10000000-0000-0000-0000-000000000001', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 4)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (4, N'Full-Body Resistance & Tone', N'Personalized training block tailored for Zoe Coleman focusing on Strength & Metabolic Tone.', '2026-10-29T13:59:10.293', N'20000000-0000-0000-0000-000000000004', N'10000000-0000-0000-0000-000000000001', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 5)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (5, N'Heavy Compound & Fat-Loss Split', N'Personalized training block tailored for Nathan Perry focusing on Fat Loss & Upper Body Power.', '2026-10-30T13:59:10.423', N'20000000-0000-0000-0000-000000000005', N'10000000-0000-0000-0000-000000000001', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 6)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (6, N'Athletic Hypertrophy & Core', N'Personalized training block tailored for Hannah Reed focusing on Athletic Strength & Definition.', '2026-10-31T13:59:10.566', N'20000000-0000-0000-0000-000000000006', N'10000000-0000-0000-0000-000000000001', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 7)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (7, N'Barbell Strength & Hypertrophy', N'Personalized training block tailored for Ryan Hughes focusing on Compound Lift Progression.', '2026-11-01T13:59:10.720', N'20000000-0000-0000-0000-000000000007', N'10000000-0000-0000-0000-000000000001', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 8)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (8, N'Dumbbell & Cable Toning Split', N'Personalized training block tailored for Audrey Price focusing on Total Body Toning.', '2026-11-02T13:59:10.850', N'20000000-0000-0000-0000-000000000008', N'10000000-0000-0000-0000-000000000001', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 9)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (9, N'5-Day Hypertrophy Volume Block', N'Personalized training block tailored for Dylan Sanders focusing on Lean Hypertrophy Split.', '2026-11-03T13:59:11.050', N'20000000-0000-0000-0000-000000000009', N'10000000-0000-0000-0000-000000000001', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 10)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (10, N'Metabolic Resistance Circuit', N'Personalized training block tailored for Claire Morris focusing on Resistance Conditioning.', '2026-10-25T13:59:11.210', N'20000000-0000-0000-0000-000000000010', N'10000000-0000-0000-0000-000000000001', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 11)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (11, N'HIIT Sprint & Kettlebell Shred', N'Personalized training block tailored for Julian Ross focusing on HIIT Fat Loss & Agility.', '2026-10-26T13:59:11.383', N'20000000-0000-0000-0000-000000000011', N'10000000-0000-0000-0000-000000000002', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 12)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (12, N'Tabata & Core Burn Protocol', N'Personalized training block tailored for Stella Morales focusing on Metabolic Conditioning.', '2026-10-27T13:59:11.580', N'20000000-0000-0000-0000-000000000012', N'10000000-0000-0000-0000-000000000002', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 13)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (13, N'VO2 Max Interval & Plyometrics', N'Personalized training block tailored for Aaron Ortiz focusing on Sprint & Cardio Stamina.', '2026-10-28T13:59:11.760', N'20000000-0000-0000-0000-000000000013', N'10000000-0000-0000-0000-000000000002', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 14)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (14, N'Functional Cardio & Ab Circuit', N'Personalized training block tailored for Nora Jenkins focusing on Calorie Burn & Core Endurance.', '2026-10-29T13:59:11.876', N'20000000-0000-0000-0000-000000000014', N'10000000-0000-0000-0000-000000000002', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 15)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (15, N'EMOM Kettlebell & Battle Ropes', N'Personalized training block tailored for Adrian Flores focusing on Kettlebell & Interval Shred.', '2026-10-30T13:59:12.080', N'20000000-0000-0000-0000-000000000015', N'10000000-0000-0000-0000-000000000002', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 16)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (16, N'Calisthenics Pull & Ring Mastery', N'Personalized training block tailored for Leo Barnes focusing on Calisthenics & Upper Control.', '2026-10-31T13:59:12.233', N'20000000-0000-0000-0000-000000000016', N'10000000-0000-0000-0000-000000000003', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 17)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (17, N'Thoracic & Scapular Alignment Flow', N'Personalized training block tailored for Maya Fisher focusing on Posture & Spinal Mobility.', '2026-11-01T13:59:12.370', N'20000000-0000-0000-0000-000000000017', N'10000000-0000-0000-0000-000000000003', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 18)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (18, N'Core Stabilization & Hip Mobility', N'Personalized training block tailored for Eli Henderson focusing on Joint Longevity & Core Stability.', '2026-11-02T13:59:12.476', N'20000000-0000-0000-0000-000000000018', N'10000000-0000-0000-0000-000000000003', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 19)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (19, N'Bodyweight Flow & Deep Stretch', N'Personalized training block tailored for Lucy Cole focusing on Flexibility & Bodyweight Strength.', '2026-11-03T13:59:12.633', N'20000000-0000-0000-0000-000000000019', N'10000000-0000-0000-0000-000000000003', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 20)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (20, N'Rotator Cuff & Functional Strength', N'Personalized training block tailored for Connor Powell focusing on Shoulder Rehab & Functional Flow.', '2026-10-25T13:59:12.773', N'20000000-0000-0000-0000-000000000020', N'10000000-0000-0000-0000-000000000003', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 21)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (21, N'Low-Impact Metabolic Walk & Lift', N'Personalized training block tailored for Landon Butler focusing on Sustainable Nutrition & Weight Loss.', '2026-10-26T13:59:13.013', N'20000000-0000-0000-0000-000000000021', N'10000000-0000-0000-0000-000000000004', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 22)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (22, N'Full-Body Longevity & Zone-2 Cardio', N'Personalized training block tailored for Violet Simmons focusing on Macro Balance & Energy Optimization.', '2026-10-27T13:59:13.146', N'20000000-0000-0000-0000-000000000022', N'10000000-0000-0000-0000-000000000004', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 23)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (23, N'Heart-Health Aerobic & Resistance', N'Personalized training block tailored for Gavin Russell focusing on Cardiovascular Longevity & Diet.', '2026-10-28T13:59:13.253', N'20000000-0000-0000-0000-000000000023', N'10000000-0000-0000-0000-000000000004', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 24)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (24, N'Endurance Pace & Core Toning', N'Personalized training block tailored for Hazel Griffin focusing on Clean Eating & Aerobic Fitness.', '2026-10-29T13:59:13.390', N'20000000-0000-0000-0000-000000000024', N'10000000-0000-0000-0000-000000000004', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 25)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (25, N'Steady-State Conditioning & Strength', N'Personalized training block tailored for Wyatt Diaz focusing on Glycemic Control & Active Recovery.', '2026-10-30T13:59:13.513', N'20000000-0000-0000-0000-000000000025', N'10000000-0000-0000-0000-000000000004', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 26)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (26, N'Competition Squat / Bench / Deadlift', N'Personalized training block tailored for Dominic Hayes focusing on Powerlifting & Maximal Strength.', '2026-10-31T13:59:13.656', N'20000000-0000-0000-0000-000000000026', N'10000000-0000-0000-0000-000000000005', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 27)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (27, N'Barbell Hip-Thrust & Squat Block', N'Personalized training block tailored for Ruby Myers focusing on Barbell Strength & Lower Body Power.', '2026-11-01T13:59:13.810', N'20000000-0000-0000-0000-000000000027', N'10000000-0000-0000-0000-000000000005', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 28)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (28, N'Heavy Pull & Posterior Chain Peak', N'Personalized training block tailored for Xavier Ford focusing on Compound Squat & Deadlift PR.', '2026-11-02T13:59:13.976', N'20000000-0000-0000-0000-000000000028', N'10000000-0000-0000-0000-000000000005', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 29)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (29, N'Relative Strength & Explosive Lift', N'Personalized training block tailored for Alice Hamilton focusing on Strength-to-Weight Ratio.', '2026-11-03T13:59:14.166', N'20000000-0000-0000-0000-000000000029', N'10000000-0000-0000-0000-000000000005', NULL, 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutPlans] WHERE [Id] = 30)
    INSERT INTO [WorkoutPlans] ([Id], [Title], [Description], [CreatedAt], [ClientId], [TrainerId], [CompletedAt], [IsActive]) VALUES (30, N'Powerbuilding & Sled Conditioning', N'Personalized training block tailored for Miles Graham focusing on Explosive Power & Conditioning.', '2026-10-25T13:59:14.340', N'20000000-0000-0000-0000-000000000030', N'10000000-0000-0000-0000-000000000005', NULL, 1);
SET IDENTITY_INSERT [WorkoutPlans] OFF;

-- ---------------------------------------------------------------------------
-- Table: [WorkoutExercises]
-- ---------------------------------------------------------------------------
SET IDENTITY_INSERT [WorkoutExercises] ON;
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 1)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (1, 1, N'Barbell Back Squat', N'4 sets', N'8-10 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 2)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (2, 1, N'Incline Dumbbell Bench Press', N'4 sets', N'10-12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 3)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (3, 1, N'Romanian Barbell Deadlift', N'3 sets', N'10 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 4)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (4, 1, N'Seated Cable Row', N'3 sets', N'12 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 5)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (5, 2, N'Barbell Back Squat', N'4 sets', N'8-10 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 6)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (6, 2, N'Incline Dumbbell Bench Press', N'4 sets', N'10-12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 7)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (7, 2, N'Romanian Barbell Deadlift', N'3 sets', N'10 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 8)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (8, 2, N'Seated Cable Row', N'3 sets', N'12 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 9)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (9, 3, N'Barbell Back Squat', N'4 sets', N'8-10 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 10)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (10, 3, N'Incline Dumbbell Bench Press', N'4 sets', N'10-12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 11)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (11, 3, N'Romanian Barbell Deadlift', N'3 sets', N'10 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 12)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (12, 3, N'Seated Cable Row', N'3 sets', N'12 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 13)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (13, 4, N'Barbell Back Squat', N'4 sets', N'8-10 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 14)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (14, 4, N'Incline Dumbbell Bench Press', N'4 sets', N'10-12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 15)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (15, 4, N'Romanian Barbell Deadlift', N'3 sets', N'10 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 16)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (16, 4, N'Seated Cable Row', N'3 sets', N'12 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 17)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (17, 5, N'Barbell Back Squat', N'4 sets', N'8-10 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 18)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (18, 5, N'Incline Dumbbell Bench Press', N'4 sets', N'10-12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 19)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (19, 5, N'Romanian Barbell Deadlift', N'3 sets', N'10 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 20)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (20, 5, N'Seated Cable Row', N'3 sets', N'12 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 21)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (21, 6, N'Barbell Back Squat', N'4 sets', N'8-10 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 22)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (22, 6, N'Incline Dumbbell Bench Press', N'4 sets', N'10-12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 23)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (23, 6, N'Romanian Barbell Deadlift', N'3 sets', N'10 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 24)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (24, 6, N'Seated Cable Row', N'3 sets', N'12 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 25)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (25, 7, N'Barbell Back Squat', N'4 sets', N'8-10 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 26)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (26, 7, N'Incline Dumbbell Bench Press', N'4 sets', N'10-12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 27)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (27, 7, N'Romanian Barbell Deadlift', N'3 sets', N'10 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 28)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (28, 7, N'Seated Cable Row', N'3 sets', N'12 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 29)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (29, 8, N'Barbell Back Squat', N'4 sets', N'8-10 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 30)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (30, 8, N'Incline Dumbbell Bench Press', N'4 sets', N'10-12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 31)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (31, 8, N'Romanian Barbell Deadlift', N'3 sets', N'10 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 32)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (32, 8, N'Seated Cable Row', N'3 sets', N'12 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 33)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (33, 9, N'Barbell Back Squat', N'4 sets', N'8-10 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 34)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (34, 9, N'Incline Dumbbell Bench Press', N'4 sets', N'10-12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 35)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (35, 9, N'Romanian Barbell Deadlift', N'3 sets', N'10 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 36)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (36, 9, N'Seated Cable Row', N'3 sets', N'12 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 37)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (37, 10, N'Barbell Back Squat', N'4 sets', N'8-10 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 38)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (38, 10, N'Incline Dumbbell Bench Press', N'4 sets', N'10-12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 39)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (39, 10, N'Romanian Barbell Deadlift', N'3 sets', N'10 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 40)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (40, 10, N'Seated Cable Row', N'3 sets', N'12 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 41)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (41, 11, N'Russian Kettlebell Swings', N'4 sets', N'20 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 42)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (42, 11, N'Plyometric Box Jumps', N'4 sets', N'12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 43)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (43, 11, N'Battle Rope Alternating Waves', N'5 sets', N'40 secs', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 44)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (44, 11, N'Burpee Broad Jumps', N'3 sets', N'15 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 45)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (45, 12, N'Russian Kettlebell Swings', N'4 sets', N'20 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 46)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (46, 12, N'Plyometric Box Jumps', N'4 sets', N'12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 47)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (47, 12, N'Battle Rope Alternating Waves', N'5 sets', N'40 secs', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 48)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (48, 12, N'Burpee Broad Jumps', N'3 sets', N'15 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 49)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (49, 13, N'Russian Kettlebell Swings', N'4 sets', N'20 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 50)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (50, 13, N'Plyometric Box Jumps', N'4 sets', N'12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 51)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (51, 13, N'Battle Rope Alternating Waves', N'5 sets', N'40 secs', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 52)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (52, 13, N'Burpee Broad Jumps', N'3 sets', N'15 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 53)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (53, 14, N'Russian Kettlebell Swings', N'4 sets', N'20 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 54)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (54, 14, N'Plyometric Box Jumps', N'4 sets', N'12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 55)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (55, 14, N'Battle Rope Alternating Waves', N'5 sets', N'40 secs', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 56)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (56, 14, N'Burpee Broad Jumps', N'3 sets', N'15 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 57)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (57, 15, N'Russian Kettlebell Swings', N'4 sets', N'20 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 58)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (58, 15, N'Plyometric Box Jumps', N'4 sets', N'12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 59)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (59, 15, N'Battle Rope Alternating Waves', N'5 sets', N'40 secs', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 60)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (60, 15, N'Burpee Broad Jumps', N'3 sets', N'15 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 61)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (61, 16, N'Strict Pronated Pull-Ups', N'4 sets', N'8-10 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 62)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (62, 16, N'Gymnastic Ring Push-Ups', N'3 sets', N'12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 63)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (63, 16, N'Deep Cossack Mobility Squats', N'3 sets', N'10 reps/side', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 64)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (64, 16, N'Hollow Body Core Compression', N'4 sets', N'45 secs', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 65)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (65, 17, N'Strict Pronated Pull-Ups', N'4 sets', N'8-10 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 66)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (66, 17, N'Gymnastic Ring Push-Ups', N'3 sets', N'12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 67)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (67, 17, N'Deep Cossack Mobility Squats', N'3 sets', N'10 reps/side', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 68)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (68, 17, N'Hollow Body Core Compression', N'4 sets', N'45 secs', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 69)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (69, 18, N'Strict Pronated Pull-Ups', N'4 sets', N'8-10 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 70)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (70, 18, N'Gymnastic Ring Push-Ups', N'3 sets', N'12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 71)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (71, 18, N'Deep Cossack Mobility Squats', N'3 sets', N'10 reps/side', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 72)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (72, 18, N'Hollow Body Core Compression', N'4 sets', N'45 secs', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 73)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (73, 19, N'Strict Pronated Pull-Ups', N'4 sets', N'8-10 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 74)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (74, 19, N'Gymnastic Ring Push-Ups', N'3 sets', N'12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 75)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (75, 19, N'Deep Cossack Mobility Squats', N'3 sets', N'10 reps/side', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 76)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (76, 19, N'Hollow Body Core Compression', N'4 sets', N'45 secs', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 77)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (77, 20, N'Strict Pronated Pull-Ups', N'4 sets', N'8-10 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 78)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (78, 20, N'Gymnastic Ring Push-Ups', N'3 sets', N'12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 79)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (79, 20, N'Deep Cossack Mobility Squats', N'3 sets', N'10 reps/side', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 80)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (80, 20, N'Hollow Body Core Compression', N'4 sets', N'45 secs', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 81)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (81, 21, N'Goblet Kettlebell Squat', N'3 sets', N'12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 82)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (82, 21, N'Zone-2 Incline Treadmill Pace', N'1 set', N'25 mins', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 83)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (83, 21, N'Dumbbell Single-Arm Row', N'3 sets', N'12 reps/side', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 84)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (84, 21, N'Stability Ball Bird-Dog', N'3 sets', N'12 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 85)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (85, 22, N'Goblet Kettlebell Squat', N'3 sets', N'12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 86)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (86, 22, N'Zone-2 Incline Treadmill Pace', N'1 set', N'25 mins', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 87)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (87, 22, N'Dumbbell Single-Arm Row', N'3 sets', N'12 reps/side', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 88)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (88, 22, N'Stability Ball Bird-Dog', N'3 sets', N'12 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 89)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (89, 23, N'Goblet Kettlebell Squat', N'3 sets', N'12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 90)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (90, 23, N'Zone-2 Incline Treadmill Pace', N'1 set', N'25 mins', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 91)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (91, 23, N'Dumbbell Single-Arm Row', N'3 sets', N'12 reps/side', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 92)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (92, 23, N'Stability Ball Bird-Dog', N'3 sets', N'12 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 93)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (93, 24, N'Goblet Kettlebell Squat', N'3 sets', N'12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 94)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (94, 24, N'Zone-2 Incline Treadmill Pace', N'1 set', N'25 mins', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 95)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (95, 24, N'Dumbbell Single-Arm Row', N'3 sets', N'12 reps/side', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 96)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (96, 24, N'Stability Ball Bird-Dog', N'3 sets', N'12 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 97)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (97, 25, N'Goblet Kettlebell Squat', N'3 sets', N'12 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 98)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (98, 25, N'Zone-2 Incline Treadmill Pace', N'1 set', N'25 mins', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 99)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (99, 25, N'Dumbbell Single-Arm Row', N'3 sets', N'12 reps/side', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 100)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (100, 25, N'Stability Ball Bird-Dog', N'3 sets', N'12 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 101)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (101, 26, N'Competition Low-Bar Squat', N'5 sets', N'5 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 102)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (102, 26, N'Paused Barbell Bench Press', N'5 sets', N'5 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 103)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (103, 26, N'Conventional Barbell Deadlift', N'4 sets', N'5 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 104)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (104, 26, N'Overhead Strict Military Press', N'4 sets', N'6-8 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 105)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (105, 27, N'Competition Low-Bar Squat', N'5 sets', N'5 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 106)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (106, 27, N'Paused Barbell Bench Press', N'5 sets', N'5 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 107)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (107, 27, N'Conventional Barbell Deadlift', N'4 sets', N'5 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 108)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (108, 27, N'Overhead Strict Military Press', N'4 sets', N'6-8 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 109)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (109, 28, N'Competition Low-Bar Squat', N'5 sets', N'5 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 110)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (110, 28, N'Paused Barbell Bench Press', N'5 sets', N'5 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 111)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (111, 28, N'Conventional Barbell Deadlift', N'4 sets', N'5 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 112)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (112, 28, N'Overhead Strict Military Press', N'4 sets', N'6-8 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 113)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (113, 29, N'Competition Low-Bar Squat', N'5 sets', N'5 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 114)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (114, 29, N'Paused Barbell Bench Press', N'5 sets', N'5 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 115)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (115, 29, N'Conventional Barbell Deadlift', N'4 sets', N'5 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 116)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (116, 29, N'Overhead Strict Military Press', N'4 sets', N'6-8 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 117)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (117, 30, N'Competition Low-Bar Squat', N'5 sets', N'5 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 118)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (118, 30, N'Paused Barbell Bench Press', N'5 sets', N'5 reps', 1);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 119)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (119, 30, N'Conventional Barbell Deadlift', N'4 sets', N'5 reps', 0);
IF NOT EXISTS (SELECT 1 FROM [WorkoutExercises] WHERE [Id] = 120)
    INSERT INTO [WorkoutExercises] ([Id], [WorkoutPlanId], [Name], [Sets], [Reps], [IsCompleted]) VALUES (120, 30, N'Overhead Strict Military Press', N'4 sets', N'6-8 reps', 0);
SET IDENTITY_INSERT [WorkoutExercises] OFF;

-- ---------------------------------------------------------------------------
-- Table: [DietPlans]
-- ---------------------------------------------------------------------------
SET IDENTITY_INSERT [DietPlans] ON;
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 1)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (1, N'High-Protein Recomposition Plan', 2250, '2026-10-26T13:59:09.680', N'20000000-0000-0000-0000-000000000001', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 2)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (2, N'Lean Sculpt Macro Protocol', 1850, '2026-10-27T13:59:09.956', N'20000000-0000-0000-0000-000000000002', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 3)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (3, N'Clean Lean Mass Surplus Plan', 2650, '2026-10-28T13:59:10.136', N'20000000-0000-0000-0000-000000000003', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 4)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (4, N'Metabolic Balance Nutrition Plan', 1800, '2026-10-29T13:59:10.293', N'20000000-0000-0000-0000-000000000004', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 5)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (5, N'High-Satiety Cutting Protocol', 2150, '2026-10-30T13:59:10.423', N'20000000-0000-0000-0000-000000000005', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 6)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (6, N'Performance Lean Fuel Plan', 1950, '2026-10-31T13:59:10.566', N'20000000-0000-0000-0000-000000000006', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 7)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (7, N'Balanced Strength Macro Plan', 2300, '2026-11-01T13:59:10.720', N'20000000-0000-0000-0000-000000000007', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 8)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (8, N'Clean Micronutrient Deficit Plan', 1750, '2026-11-02T13:59:10.850', N'20000000-0000-0000-0000-000000000008', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 9)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (9, N'Lean Muscle Maintenance Diet', 2350, '2026-11-03T13:59:11.050', N'20000000-0000-0000-0000-000000000009', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 10)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (10, N'High-Protein Toning Nutrition', 1850, '2026-10-25T13:59:11.210', N'20000000-0000-0000-0000-000000000010', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 11)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (11, N'Rapid Fat-Oxidation Deficit Plan', 2050, '2026-10-26T13:59:11.383', N'20000000-0000-0000-0000-000000000011', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 12)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (12, N'Low-Glycemic Metabolic Fuel', 1780, '2026-10-27T13:59:11.580', N'20000000-0000-0000-0000-000000000012', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 13)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (13, N'Endurance Shred Nutrition Plan', 2100, '2026-10-28T13:59:11.760', N'20000000-0000-0000-0000-000000000013', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 14)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (14, N'Caloric Deficit Whole-Food Plan', 1820, '2026-10-29T13:59:11.876', N'20000000-0000-0000-0000-000000000014', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 15)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (15, N'High-Protein Shred Protocol', 2150, '2026-10-30T13:59:12.080', N'20000000-0000-0000-0000-000000000015', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 16)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (16, N'Joint-Support Lean Fuel Plan', 2200, '2026-10-31T13:59:12.233', N'20000000-0000-0000-0000-000000000016', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 17)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (17, N'Anti-Inflammatory Whole-Food Diet', 1850, '2026-11-01T13:59:12.370', N'20000000-0000-0000-0000-000000000017', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 18)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (18, N'Collagen & Micronutrient Balance', 2100, '2026-11-02T13:59:12.476', N'20000000-0000-0000-0000-000000000018', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 19)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (19, N'Clean Plant-Rich Recovery Diet', 1900, '2026-11-03T13:59:12.633', N'20000000-0000-0000-0000-000000000019', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 20)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (20, N'Omega-3 Mobility Nutrition Plan', 2150, '2026-10-25T13:59:12.773', N'20000000-0000-0000-0000-000000000020', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 21)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (21, N'Clinical Glycemic Balance Plan', 2050, '2026-10-26T13:59:13.013', N'20000000-0000-0000-0000-000000000021', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 22)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (22, N'Precision Macro Equilibrium Diet', 1850, '2026-10-27T13:59:13.146', N'20000000-0000-0000-0000-000000000022', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 23)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (23, N'Mediterranean Clinical Heart Diet', 2000, '2026-10-28T13:59:13.253', N'20000000-0000-0000-0000-000000000023', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 24)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (24, N'Whole-Food Micronutrient Protocol', 1880, '2026-10-29T13:59:13.390', N'20000000-0000-0000-0000-000000000024', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 25)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (25, N'Metabolic Insulin-Sensitivity Plan', 2150, '2026-10-30T13:59:13.513', N'20000000-0000-0000-0000-000000000025', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 26)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (26, N'Powerlifting Hyper-Recovery Surplus', 2850, '2026-10-31T13:59:13.656', N'20000000-0000-0000-0000-000000000026', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 27)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (27, N'Strength Athlete Macro Protocol', 2050, '2026-11-01T13:59:13.810', N'20000000-0000-0000-0000-000000000027', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 28)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (28, N'High-Glycogen Strength Surplus', 2750, '2026-11-02T13:59:13.976', N'20000000-0000-0000-0000-000000000028', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 29)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (29, N'Lean Power Performance Nutrition', 1950, '2026-11-03T13:59:14.166', N'20000000-0000-0000-0000-000000000029', 1);
IF NOT EXISTS (SELECT 1 FROM [DietPlans] WHERE [Id] = 30)
    INSERT INTO [DietPlans] ([Id], [Title], [TargetCalories], [CreatedAt], [ClientId], [IsActive]) VALUES (30, N'Athletic Power Recomposition Diet', 2450, '2026-10-25T13:59:14.340', N'20000000-0000-0000-0000-000000000030', 1);
SET IDENTITY_INSERT [DietPlans] OFF;

-- ---------------------------------------------------------------------------
-- Table: [MealItems]
-- ---------------------------------------------------------------------------
SET IDENTITY_INSERT [MealItems] ON;
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 1)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (1, 1, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Ethan Brooks)', 560);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 2)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (2, 1, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 790);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 3)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (3, 1, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 340);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 4)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (4, 1, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 560);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 5)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (5, 2, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Chloe Bennett)', 460);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 6)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (6, 2, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 650);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 7)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (7, 2, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 280);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 8)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (8, 2, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 460);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 9)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (9, 3, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Caleb Foster)', 660);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 10)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (10, 3, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 930);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 11)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (11, 3, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 400);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 12)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (12, 3, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 660);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 13)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (13, 4, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Zoe Coleman)', 450);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 14)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (14, 4, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 630);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 15)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (15, 4, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 270);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 16)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (16, 4, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 450);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 17)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (17, 5, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Nathan Perry)', 540);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 18)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (18, 5, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 750);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 19)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (19, 5, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 320);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 20)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (20, 5, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 540);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 21)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (21, 6, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Hannah Reed)', 490);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 22)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (22, 6, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 680);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 23)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (23, 6, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 290);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 24)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (24, 6, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 490);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 25)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (25, 7, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Ryan Hughes)', 580);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 26)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (26, 7, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 800);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 27)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (27, 7, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 340);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 28)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (28, 7, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 580);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 29)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (29, 8, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Audrey Price)', 440);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 30)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (30, 8, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 610);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 31)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (31, 8, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 260);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 32)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (32, 8, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 440);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 33)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (33, 9, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Dylan Sanders)', 590);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 34)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (34, 9, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 820);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 35)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (35, 9, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 350);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 36)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (36, 9, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 590);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 37)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (37, 10, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Claire Morris)', 460);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 38)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (38, 10, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 650);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 39)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (39, 10, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 280);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 40)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (40, 10, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 460);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 41)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (41, 11, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Julian Ross)', 510);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 42)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (42, 11, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 720);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 43)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (43, 11, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 310);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 44)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (44, 11, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 510);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 45)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (45, 12, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Stella Morales)', 440);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 46)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (46, 12, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 620);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 47)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (47, 12, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 270);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 48)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (48, 12, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 450);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 49)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (49, 13, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Aaron Ortiz)', 520);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 50)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (50, 13, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 740);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 51)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (51, 13, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 320);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 52)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (52, 13, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 520);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 53)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (53, 14, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Nora Jenkins)', 460);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 54)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (54, 14, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 640);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 55)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (55, 14, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 270);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 56)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (56, 14, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 450);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 57)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (57, 15, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Adrian Flores)', 540);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 58)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (58, 15, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 750);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 59)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (59, 15, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 320);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 60)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (60, 15, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 540);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 61)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (61, 16, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Leo Barnes)', 550);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 62)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (62, 16, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 770);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 63)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (63, 16, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 330);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 64)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (64, 16, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 550);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 65)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (65, 17, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Maya Fisher)', 460);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 66)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (66, 17, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 650);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 67)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (67, 17, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 280);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 68)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (68, 17, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 460);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 69)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (69, 18, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Eli Henderson)', 520);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 70)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (70, 18, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 740);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 71)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (71, 18, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 320);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 72)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (72, 18, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 520);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 73)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (73, 19, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Lucy Cole)', 480);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 74)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (74, 19, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 660);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 75)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (75, 19, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 280);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 76)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (76, 19, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 480);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 77)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (77, 20, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Connor Powell)', 540);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 78)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (78, 20, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 750);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 79)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (79, 20, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 320);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 80)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (80, 20, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 540);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 81)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (81, 21, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Landon Butler)', 510);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 82)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (82, 21, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 720);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 83)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (83, 21, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 310);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 84)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (84, 21, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 510);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 85)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (85, 22, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Violet Simmons)', 460);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 86)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (86, 22, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 650);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 87)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (87, 22, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 280);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 88)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (88, 22, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 460);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 89)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (89, 23, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Gavin Russell)', 500);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 90)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (90, 23, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 700);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 91)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (91, 23, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 300);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 92)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (92, 23, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 500);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 93)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (93, 24, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Hazel Griffin)', 470);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 94)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (94, 24, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 660);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 95)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (95, 24, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 280);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 96)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (96, 24, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 470);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 97)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (97, 25, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Wyatt Diaz)', 540);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 98)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (98, 25, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 750);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 99)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (99, 25, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 320);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 100)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (100, 25, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 540);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 101)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (101, 26, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Dominic Hayes)', 710);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 102)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (102, 26, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 1000);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 103)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (103, 26, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 430);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 104)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (104, 26, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 710);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 105)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (105, 27, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Ruby Myers)', 510);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 106)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (106, 27, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 720);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 107)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (107, 27, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 310);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 108)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (108, 27, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 510);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 109)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (109, 28, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Xavier Ford)', 690);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 110)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (110, 28, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 960);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 111)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (111, 28, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 410);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 112)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (112, 28, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 690);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 113)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (113, 29, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Alice Hamilton)', 490);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 114)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (114, 29, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 680);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 115)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (115, 29, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 290);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 116)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (116, 29, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 490);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 117)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (117, 30, N'Breakfast', N'Rolled oats with whey isolate, chia seeds & fresh berries (Miles Graham)', 610);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 118)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (118, 30, N'Lunch', N'Grilled herb chicken breast, quinoa pilaf & roasted greens', 860);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 119)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (119, 30, N'Snack', N'Greek yogurt bowl with roasted almonds & raw honey drizzle', 370);
IF NOT EXISTS (SELECT 1 FROM [MealItems] WHERE [Id] = 120)
    INSERT INTO [MealItems] ([Id], [DietPlanId], [MealType], [Description], [Calories]) VALUES (120, 30, N'Dinner', N'Pan-seared wild salmon fillet, sweet potato mash & steamed asparagus', 610);
SET IDENTITY_INSERT [MealItems] OFF;

-- ---------------------------------------------------------------------------
-- Table: [Appointments]
-- ---------------------------------------------------------------------------
SET IDENTITY_INSERT [Appointments] ON;
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 1)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (1, N'20000000-0000-0000-0000-000000000001', N'10000000-0000-0000-0000-000000000001', '2026-11-01T00:00:00.000', N'10:30 AM', N'Completed', N'Initial Assessment & Lean Muscle & Recomposition Baseline Screening', '2026-10-23T13:59:09.810');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 2)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (2, N'20000000-0000-0000-0000-000000000001', N'10000000-0000-0000-0000-000000000001', '2026-11-15T00:00:00.000', N'03:00 PM', N'Confirmed', N'Bi-Weekly Progress Check-In: Upper / Lower Hypertrophy Split', '2026-11-09T13:59:09.826');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 3)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (3, N'20000000-0000-0000-0000-000000000001', N'10000000-0000-0000-0000-000000000001', '2026-11-23T00:00:00.000', N'10:30 AM', N'Pending', N'Macro & Form Adjustment Review: High-Protein Recomposition Plan', '2026-11-11T13:59:09.833');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 4)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (4, N'20000000-0000-0000-0000-000000000002', N'10000000-0000-0000-0000-000000000001', '2026-10-31T00:00:00.000', N'01:30 PM', N'Completed', N'Initial Assessment & Glute & Core Sculpting Baseline Screening', '2026-10-23T13:59:10.030');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 5)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (5, N'20000000-0000-0000-0000-000000000002', N'10000000-0000-0000-0000-000000000001', '2026-11-16T00:00:00.000', N'04:30 PM', N'Confirmed', N'Bi-Weekly Progress Check-In: Lower Body & Core Sculpt Routine', '2026-11-09T13:59:10.070');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 6)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (6, N'20000000-0000-0000-0000-000000000002', N'10000000-0000-0000-0000-000000000001', '2026-11-24T00:00:00.000', N'01:30 PM', N'Pending', N'Macro & Form Adjustment Review: Lean Sculpt Macro Protocol', '2026-11-11T13:59:10.080');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 7)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (7, N'20000000-0000-0000-0000-000000000003', N'10000000-0000-0000-0000-000000000001', '2026-10-30T00:00:00.000', N'03:00 PM', N'Completed', N'Initial Assessment & Hypertrophy & Mass Gain Baseline Screening', '2026-10-23T13:59:10.220');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 8)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (8, N'20000000-0000-0000-0000-000000000003', N'10000000-0000-0000-0000-000000000001', '2026-11-17T00:00:00.000', N'09:00 AM', N'Confirmed', N'Bi-Weekly Progress Check-In: Progressive Push / Pull / Legs', '2026-11-09T13:59:10.226');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 9)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (9, N'20000000-0000-0000-0000-000000000003', N'10000000-0000-0000-0000-000000000001', '2026-11-25T00:00:00.000', N'03:00 PM', N'Pending', N'Macro & Form Adjustment Review: Clean Lean Mass Surplus Plan', '2026-11-11T13:59:10.236');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 10)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (10, N'20000000-0000-0000-0000-000000000004', N'10000000-0000-0000-0000-000000000001', '2026-10-29T00:00:00.000', N'04:30 PM', N'Completed', N'Initial Assessment & Strength & Metabolic Tone Baseline Screening', '2026-10-23T13:59:10.350');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 11)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (11, N'20000000-0000-0000-0000-000000000004', N'10000000-0000-0000-0000-000000000001', '2026-11-18T00:00:00.000', N'10:30 AM', N'Confirmed', N'Bi-Weekly Progress Check-In: Full-Body Resistance & Tone', '2026-11-09T13:59:10.360');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 12)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (12, N'20000000-0000-0000-0000-000000000004', N'10000000-0000-0000-0000-000000000001', '2026-11-26T00:00:00.000', N'04:30 PM', N'Pending', N'Macro & Form Adjustment Review: Metabolic Balance Nutrition Plan', '2026-11-11T13:59:10.370');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 13)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (13, N'20000000-0000-0000-0000-000000000005', N'10000000-0000-0000-0000-000000000001', '2026-10-28T00:00:00.000', N'09:00 AM', N'Completed', N'Initial Assessment & Fat Loss & Upper Body Power Baseline Screening', '2026-10-23T13:59:10.490');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 14)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (14, N'20000000-0000-0000-0000-000000000005', N'10000000-0000-0000-0000-000000000001', '2026-11-19T00:00:00.000', N'01:30 PM', N'Confirmed', N'Bi-Weekly Progress Check-In: Heavy Compound & Fat-Loss Split', '2026-11-09T13:59:10.500');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 15)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (15, N'20000000-0000-0000-0000-000000000005', N'10000000-0000-0000-0000-000000000001', '2026-11-27T00:00:00.000', N'09:00 AM', N'Pending', N'Macro & Form Adjustment Review: High-Satiety Cutting Protocol', '2026-11-11T13:59:10.510');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 16)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (16, N'20000000-0000-0000-0000-000000000006', N'10000000-0000-0000-0000-000000000001', '2026-10-27T00:00:00.000', N'10:30 AM', N'Completed', N'Initial Assessment & Athletic Strength & Definition Baseline Screening', '2026-10-23T13:59:10.640');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 17)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (17, N'20000000-0000-0000-0000-000000000006', N'10000000-0000-0000-0000-000000000001', '2026-11-20T00:00:00.000', N'03:00 PM', N'Confirmed', N'Bi-Weekly Progress Check-In: Athletic Hypertrophy & Core', '2026-11-09T13:59:10.653');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 18)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (18, N'20000000-0000-0000-0000-000000000006', N'10000000-0000-0000-0000-000000000001', '2026-11-22T00:00:00.000', N'10:30 AM', N'Pending', N'Macro & Form Adjustment Review: Performance Lean Fuel Plan', '2026-11-11T13:59:10.663');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 19)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (19, N'20000000-0000-0000-0000-000000000007', N'10000000-0000-0000-0000-000000000001', '2026-11-02T00:00:00.000', N'01:30 PM', N'Completed', N'Initial Assessment & Compound Lift Progression Baseline Screening', '2026-10-23T13:59:10.776');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 20)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (20, N'20000000-0000-0000-0000-000000000007', N'10000000-0000-0000-0000-000000000001', '2026-11-21T00:00:00.000', N'04:30 PM', N'Confirmed', N'Bi-Weekly Progress Check-In: Barbell Strength & Hypertrophy', '2026-11-09T13:59:10.793');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 21)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (21, N'20000000-0000-0000-0000-000000000007', N'10000000-0000-0000-0000-000000000001', '2026-11-23T00:00:00.000', N'01:30 PM', N'Pending', N'Macro & Form Adjustment Review: Balanced Strength Macro Plan', '2026-11-11T13:59:10.800');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 22)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (22, N'20000000-0000-0000-0000-000000000008', N'10000000-0000-0000-0000-000000000001', '2026-11-01T00:00:00.000', N'03:00 PM', N'Completed', N'Initial Assessment & Total Body Toning Baseline Screening', '2026-10-23T13:59:10.933');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 23)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (23, N'20000000-0000-0000-0000-000000000008', N'10000000-0000-0000-0000-000000000001', '2026-11-22T00:00:00.000', N'09:00 AM', N'Confirmed', N'Bi-Weekly Progress Check-In: Dumbbell & Cable Toning Split', '2026-11-09T13:59:10.950');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 24)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (24, N'20000000-0000-0000-0000-000000000008', N'10000000-0000-0000-0000-000000000001', '2026-11-24T00:00:00.000', N'03:00 PM', N'Pending', N'Macro & Form Adjustment Review: Clean Micronutrient Deficit Plan', '2026-11-11T13:59:10.963');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 25)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (25, N'20000000-0000-0000-0000-000000000009', N'10000000-0000-0000-0000-000000000001', '2026-10-31T00:00:00.000', N'04:30 PM', N'Completed', N'Initial Assessment & Lean Hypertrophy Split Baseline Screening', '2026-10-23T13:59:11.126');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 26)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (26, N'20000000-0000-0000-0000-000000000009', N'10000000-0000-0000-0000-000000000001', '2026-11-14T00:00:00.000', N'10:30 AM', N'Confirmed', N'Bi-Weekly Progress Check-In: 5-Day Hypertrophy Volume Block', '2026-11-09T13:59:11.136');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 27)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (27, N'20000000-0000-0000-0000-000000000009', N'10000000-0000-0000-0000-000000000001', '2026-11-25T00:00:00.000', N'04:30 PM', N'Confirmed', N'Macro & Form Adjustment Review: Lean Muscle Maintenance Diet', '2026-11-11T13:59:11.143');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 28)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (28, N'20000000-0000-0000-0000-000000000010', N'10000000-0000-0000-0000-000000000001', '2026-10-30T00:00:00.000', N'09:00 AM', N'Completed', N'Initial Assessment & Resistance Conditioning Baseline Screening', '2026-10-23T13:59:11.286');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 29)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (29, N'20000000-0000-0000-0000-000000000010', N'10000000-0000-0000-0000-000000000001', '2026-11-15T00:00:00.000', N'01:30 PM', N'Confirmed', N'Bi-Weekly Progress Check-In: Metabolic Resistance Circuit', '2026-11-09T13:59:11.300');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 30)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (30, N'20000000-0000-0000-0000-000000000010', N'10000000-0000-0000-0000-000000000001', '2026-11-26T00:00:00.000', N'09:00 AM', N'Confirmed', N'Macro & Form Adjustment Review: High-Protein Toning Nutrition', '2026-11-11T13:59:11.310');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 31)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (31, N'20000000-0000-0000-0000-000000000011', N'10000000-0000-0000-0000-000000000002', '2026-10-29T00:00:00.000', N'10:30 AM', N'Completed', N'Initial Assessment & HIIT Fat Loss & Agility Baseline Screening', '2026-10-23T13:59:11.476');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 32)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (32, N'20000000-0000-0000-0000-000000000011', N'10000000-0000-0000-0000-000000000002', '2026-11-16T00:00:00.000', N'03:00 PM', N'Confirmed', N'Bi-Weekly Progress Check-In: HIIT Sprint & Kettlebell Shred', '2026-11-09T13:59:11.490');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 33)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (33, N'20000000-0000-0000-0000-000000000011', N'10000000-0000-0000-0000-000000000002', '2026-11-27T00:00:00.000', N'10:30 AM', N'Confirmed', N'Macro & Form Adjustment Review: Rapid Fat-Oxidation Deficit Plan', '2026-11-11T13:59:11.503');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 34)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (34, N'20000000-0000-0000-0000-000000000012', N'10000000-0000-0000-0000-000000000002', '2026-10-28T00:00:00.000', N'01:30 PM', N'Completed', N'Initial Assessment & Metabolic Conditioning Baseline Screening', '2026-10-23T13:59:11.670');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 35)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (35, N'20000000-0000-0000-0000-000000000012', N'10000000-0000-0000-0000-000000000002', '2026-11-17T00:00:00.000', N'04:30 PM', N'Confirmed', N'Bi-Weekly Progress Check-In: Tabata & Core Burn Protocol', '2026-11-09T13:59:11.683');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 36)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (36, N'20000000-0000-0000-0000-000000000012', N'10000000-0000-0000-0000-000000000002', '2026-11-22T00:00:00.000', N'01:30 PM', N'Confirmed', N'Macro & Form Adjustment Review: Low-Glycemic Metabolic Fuel', '2026-11-11T13:59:11.693');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 37)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (37, N'20000000-0000-0000-0000-000000000013', N'10000000-0000-0000-0000-000000000002', '2026-10-27T00:00:00.000', N'03:00 PM', N'Completed', N'Initial Assessment & Sprint & Cardio Stamina Baseline Screening', '2026-10-23T13:59:11.816');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 38)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (38, N'20000000-0000-0000-0000-000000000013', N'10000000-0000-0000-0000-000000000002', '2026-11-18T00:00:00.000', N'09:00 AM', N'Confirmed', N'Bi-Weekly Progress Check-In: VO2 Max Interval & Plyometrics', '2026-11-09T13:59:11.826');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 39)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (39, N'20000000-0000-0000-0000-000000000013', N'10000000-0000-0000-0000-000000000002', '2026-11-23T00:00:00.000', N'03:00 PM', N'Confirmed', N'Macro & Form Adjustment Review: Endurance Shred Nutrition Plan', '2026-11-11T13:59:11.833');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 40)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (40, N'20000000-0000-0000-0000-000000000014', N'10000000-0000-0000-0000-000000000002', '2026-11-02T00:00:00.000', N'04:30 PM', N'Completed', N'Initial Assessment & Calorie Burn & Core Endurance Baseline Screening', '2026-10-23T13:59:11.973');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 41)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (41, N'20000000-0000-0000-0000-000000000014', N'10000000-0000-0000-0000-000000000002', '2026-11-19T00:00:00.000', N'10:30 AM', N'Confirmed', N'Bi-Weekly Progress Check-In: Functional Cardio & Ab Circuit', '2026-11-09T13:59:11.986');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 42)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (42, N'20000000-0000-0000-0000-000000000014', N'10000000-0000-0000-0000-000000000002', '2026-11-24T00:00:00.000', N'04:30 PM', N'Confirmed', N'Macro & Form Adjustment Review: Caloric Deficit Whole-Food Plan', '2026-11-11T13:59:11.993');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 43)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (43, N'20000000-0000-0000-0000-000000000015', N'10000000-0000-0000-0000-000000000002', '2026-11-01T00:00:00.000', N'09:00 AM', N'Completed', N'Initial Assessment & Kettlebell & Interval Shred Baseline Screening', '2026-10-23T13:59:12.153');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 44)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (44, N'20000000-0000-0000-0000-000000000015', N'10000000-0000-0000-0000-000000000002', '2026-11-20T00:00:00.000', N'01:30 PM', N'Confirmed', N'Bi-Weekly Progress Check-In: EMOM Kettlebell & Battle Ropes', '2026-11-09T13:59:12.163');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 45)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (45, N'20000000-0000-0000-0000-000000000015', N'10000000-0000-0000-0000-000000000002', '2026-11-25T00:00:00.000', N'09:00 AM', N'Confirmed', N'Macro & Form Adjustment Review: High-Protein Shred Protocol', '2026-11-11T13:59:12.170');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 46)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (46, N'20000000-0000-0000-0000-000000000016', N'10000000-0000-0000-0000-000000000003', '2026-10-31T00:00:00.000', N'10:30 AM', N'Completed', N'Initial Assessment & Calisthenics & Upper Control Baseline Screening', '2026-10-23T13:59:12.310');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 47)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (47, N'20000000-0000-0000-0000-000000000016', N'10000000-0000-0000-0000-000000000003', '2026-11-21T00:00:00.000', N'03:00 PM', N'Confirmed', N'Bi-Weekly Progress Check-In: Calisthenics Pull & Ring Mastery', '2026-11-09T13:59:12.316');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 48)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (48, N'20000000-0000-0000-0000-000000000017', N'10000000-0000-0000-0000-000000000003', '2026-10-30T00:00:00.000', N'01:30 PM', N'Completed', N'Initial Assessment & Posture & Spinal Mobility Baseline Screening', '2026-10-23T13:59:12.420');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 49)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (49, N'20000000-0000-0000-0000-000000000017', N'10000000-0000-0000-0000-000000000003', '2026-11-22T00:00:00.000', N'04:30 PM', N'Confirmed', N'Bi-Weekly Progress Check-In: Thoracic & Scapular Alignment Flow', '2026-11-09T13:59:12.433');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 50)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (50, N'20000000-0000-0000-0000-000000000018', N'10000000-0000-0000-0000-000000000003', '2026-10-29T00:00:00.000', N'03:00 PM', N'Completed', N'Initial Assessment & Joint Longevity & Core Stability Baseline Screening', '2026-10-23T13:59:12.560');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 51)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (51, N'20000000-0000-0000-0000-000000000018', N'10000000-0000-0000-0000-000000000003', '2026-11-14T00:00:00.000', N'09:00 AM', N'Confirmed', N'Bi-Weekly Progress Check-In: Core Stabilization & Hip Mobility', '2026-11-09T13:59:12.566');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 52)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (52, N'20000000-0000-0000-0000-000000000019', N'10000000-0000-0000-0000-000000000003', '2026-10-28T00:00:00.000', N'04:30 PM', N'Completed', N'Initial Assessment & Flexibility & Bodyweight Strength Baseline Screening', '2026-10-23T13:59:12.696');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 53)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (53, N'20000000-0000-0000-0000-000000000019', N'10000000-0000-0000-0000-000000000003', '2026-11-15T00:00:00.000', N'10:30 AM', N'Confirmed', N'Bi-Weekly Progress Check-In: Bodyweight Flow & Deep Stretch', '2026-11-09T13:59:12.706');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 54)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (54, N'20000000-0000-0000-0000-000000000020', N'10000000-0000-0000-0000-000000000003', '2026-10-27T00:00:00.000', N'09:00 AM', N'Completed', N'Initial Assessment & Shoulder Rehab & Functional Flow Baseline Screening', '2026-10-23T13:59:12.930');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 55)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (55, N'20000000-0000-0000-0000-000000000020', N'10000000-0000-0000-0000-000000000003', '2026-11-16T00:00:00.000', N'01:30 PM', N'Confirmed', N'Bi-Weekly Progress Check-In: Rotator Cuff & Functional Strength', '2026-11-09T13:59:12.943');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 56)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (56, N'20000000-0000-0000-0000-000000000021', N'10000000-0000-0000-0000-000000000004', '2026-11-02T00:00:00.000', N'10:30 AM', N'Completed', N'Initial Assessment & Sustainable Nutrition & Weight Loss Baseline Screening', '2026-10-23T13:59:13.090');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 57)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (57, N'20000000-0000-0000-0000-000000000021', N'10000000-0000-0000-0000-000000000004', '2026-11-17T00:00:00.000', N'03:00 PM', N'Confirmed', N'Bi-Weekly Progress Check-In: Low-Impact Metabolic Walk & Lift', '2026-11-09T13:59:13.100');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 58)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (58, N'20000000-0000-0000-0000-000000000022', N'10000000-0000-0000-0000-000000000004', '2026-11-01T00:00:00.000', N'01:30 PM', N'Completed', N'Initial Assessment & Macro Balance & Energy Optimization Baseline Screening', '2026-10-23T13:59:13.196');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 59)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (59, N'20000000-0000-0000-0000-000000000022', N'10000000-0000-0000-0000-000000000004', '2026-11-18T00:00:00.000', N'04:30 PM', N'Confirmed', N'Bi-Weekly Progress Check-In: Full-Body Longevity & Zone-2 Cardio', '2026-11-09T13:59:13.196');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 60)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (60, N'20000000-0000-0000-0000-000000000023', N'10000000-0000-0000-0000-000000000004', '2026-10-31T00:00:00.000', N'03:00 PM', N'Completed', N'Initial Assessment & Cardiovascular Longevity & Diet Baseline Screening', '2026-10-23T13:59:13.320');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 61)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (61, N'20000000-0000-0000-0000-000000000023', N'10000000-0000-0000-0000-000000000004', '2026-11-19T00:00:00.000', N'09:00 AM', N'Confirmed', N'Bi-Weekly Progress Check-In: Heart-Health Aerobic & Resistance', '2026-11-09T13:59:13.333');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 62)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (62, N'20000000-0000-0000-0000-000000000024', N'10000000-0000-0000-0000-000000000004', '2026-10-30T00:00:00.000', N'04:30 PM', N'Completed', N'Initial Assessment & Clean Eating & Aerobic Fitness Baseline Screening', '2026-10-23T13:59:13.446');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 63)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (63, N'20000000-0000-0000-0000-000000000024', N'10000000-0000-0000-0000-000000000004', '2026-11-20T00:00:00.000', N'10:30 AM', N'Confirmed', N'Bi-Weekly Progress Check-In: Endurance Pace & Core Toning', '2026-11-09T13:59:13.463');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 64)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (64, N'20000000-0000-0000-0000-000000000025', N'10000000-0000-0000-0000-000000000004', '2026-10-29T00:00:00.000', N'09:00 AM', N'Completed', N'Initial Assessment & Glycemic Control & Active Recovery Baseline Screening', '2026-10-23T13:59:13.590');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 65)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (65, N'20000000-0000-0000-0000-000000000025', N'10000000-0000-0000-0000-000000000004', '2026-11-21T00:00:00.000', N'01:30 PM', N'Confirmed', N'Bi-Weekly Progress Check-In: Steady-State Conditioning & Strength', '2026-11-09T13:59:13.600');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 66)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (66, N'20000000-0000-0000-0000-000000000026', N'10000000-0000-0000-0000-000000000005', '2026-10-28T00:00:00.000', N'10:30 AM', N'Completed', N'Initial Assessment & Powerlifting & Maximal Strength Baseline Screening', '2026-10-23T13:59:13.740');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 67)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (67, N'20000000-0000-0000-0000-000000000026', N'10000000-0000-0000-0000-000000000005', '2026-11-22T00:00:00.000', N'03:00 PM', N'Confirmed', N'Bi-Weekly Progress Check-In: Competition Squat / Bench / Deadlift', '2026-11-09T13:59:13.753');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 68)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (68, N'20000000-0000-0000-0000-000000000027', N'10000000-0000-0000-0000-000000000005', '2026-10-27T00:00:00.000', N'01:30 PM', N'Completed', N'Initial Assessment & Barbell Strength & Lower Body Power Baseline Screening', '2026-10-23T13:59:13.900');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 69)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (69, N'20000000-0000-0000-0000-000000000027', N'10000000-0000-0000-0000-000000000005', '2026-11-14T00:00:00.000', N'04:30 PM', N'Confirmed', N'Bi-Weekly Progress Check-In: Barbell Hip-Thrust & Squat Block', '2026-11-09T13:59:13.916');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 70)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (70, N'20000000-0000-0000-0000-000000000028', N'10000000-0000-0000-0000-000000000005', '2026-11-02T00:00:00.000', N'03:00 PM', N'Completed', N'Initial Assessment & Compound Squat & Deadlift PR Baseline Screening', '2026-10-23T13:59:14.086');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 71)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (71, N'20000000-0000-0000-0000-000000000028', N'10000000-0000-0000-0000-000000000005', '2026-11-15T00:00:00.000', N'09:00 AM', N'Confirmed', N'Bi-Weekly Progress Check-In: Heavy Pull & Posterior Chain Peak', '2026-11-09T13:59:14.100');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 72)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (72, N'20000000-0000-0000-0000-000000000029', N'10000000-0000-0000-0000-000000000005', '2026-11-01T00:00:00.000', N'04:30 PM', N'Completed', N'Initial Assessment & Strength-to-Weight Ratio Baseline Screening', '2026-10-23T13:59:14.256');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 73)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (73, N'20000000-0000-0000-0000-000000000029', N'10000000-0000-0000-0000-000000000005', '2026-11-16T00:00:00.000', N'10:30 AM', N'Confirmed', N'Bi-Weekly Progress Check-In: Relative Strength & Explosive Lift', '2026-11-09T13:59:14.270');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 74)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (74, N'20000000-0000-0000-0000-000000000030', N'10000000-0000-0000-0000-000000000005', '2026-10-31T00:00:00.000', N'09:00 AM', N'Completed', N'Initial Assessment & Explosive Power & Conditioning Baseline Screening', '2026-10-23T13:59:14.453');
IF NOT EXISTS (SELECT 1 FROM [Appointments] WHERE [Id] = 75)
    INSERT INTO [Appointments] ([Id], [ClientId], [TrainerId], [AppointmentDate], [TimeSlot], [Status], [Notes], [CreatedAt]) VALUES (75, N'20000000-0000-0000-0000-000000000030', N'10000000-0000-0000-0000-000000000005', '2026-11-17T00:00:00.000', N'01:30 PM', N'Confirmed', N'Bi-Weekly Progress Check-In: Powerbuilding & Sled Conditioning', '2026-11-09T13:59:14.460');
SET IDENTITY_INSERT [Appointments] OFF;

-- ---------------------------------------------------------------------------
-- Table: [HealthLogs]
-- ---------------------------------------------------------------------------
SET IDENTITY_INSERT [HealthLogs] ON;
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 1)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (1, N'20000000-0000-0000-0000-000000000001', '2026-10-22T00:00:00.000', 85.3, 26, 425, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 2)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (2, N'20000000-0000-0000-0000-000000000001', '2026-10-29T00:00:00.000', 84.7, 25.9, 460, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 3)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (3, N'20000000-0000-0000-0000-000000000001', '2026-11-05T00:00:00.000', 84.1, 25.7, 495, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 4)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (4, N'20000000-0000-0000-0000-000000000001', '2026-11-12T00:00:00.000', 83.5, 25.5, 530, 3, N'Current check-in logged on target for Lean Muscle & Recomposition.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 5)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (5, N'20000000-0000-0000-0000-000000000002', '2026-10-22T00:00:00.000', 65.8, 23.9, 430, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 6)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (6, N'20000000-0000-0000-0000-000000000002', '2026-10-29T00:00:00.000', 65.2, 23.7, 465, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 7)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (7, N'20000000-0000-0000-0000-000000000002', '2026-11-05T00:00:00.000', 64.6, 23.4, 500, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 8)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (8, N'20000000-0000-0000-0000-000000000002', '2026-11-12T00:00:00.000', 64, 23.2, 535, 3, N'Current check-in logged on target for Glute & Core Sculpting.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 9)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (9, N'20000000-0000-0000-0000-000000000003', '2026-10-22T00:00:00.000', 73.3, 23.1, 435, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 10)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (10, N'20000000-0000-0000-0000-000000000003', '2026-10-29T00:00:00.000', 73.7, 23.3, 470, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 11)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (11, N'20000000-0000-0000-0000-000000000003', '2026-11-05T00:00:00.000', 74.1, 23.4, 505, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 12)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (12, N'20000000-0000-0000-0000-000000000003', '2026-11-12T00:00:00.000', 74.5, 23.5, 540, 3, N'Current check-in logged on target for Hypertrophy & Mass Gain.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 13)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (13, N'20000000-0000-0000-0000-000000000004', '2026-10-22T00:00:00.000', 63.3, 23.5, 440, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 14)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (14, N'20000000-0000-0000-0000-000000000004', '2026-10-29T00:00:00.000', 62.7, 23.3, 475, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 15)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (15, N'20000000-0000-0000-0000-000000000004', '2026-11-05T00:00:00.000', 62.1, 23.1, 510, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 16)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (16, N'20000000-0000-0000-0000-000000000004', '2026-11-12T00:00:00.000', 61.5, 22.9, 545, 3, N'Current check-in logged on target for Strength & Metabolic Tone.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 17)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (17, N'20000000-0000-0000-0000-000000000005', '2026-10-22T00:00:00.000', 92.8, 27.4, 445, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 18)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (18, N'20000000-0000-0000-0000-000000000005', '2026-10-29T00:00:00.000', 92.2, 27.2, 480, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 19)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (19, N'20000000-0000-0000-0000-000000000005', '2026-11-05T00:00:00.000', 91.6, 27.1, 515, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 20)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (20, N'20000000-0000-0000-0000-000000000005', '2026-11-12T00:00:00.000', 91, 26.9, 550, 3, N'Current check-in logged on target for Fat Loss & Upper Body Power.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 21)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (21, N'20000000-0000-0000-0000-000000000006', '2026-10-22T00:00:00.000', 68.3, 23.9, 450, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 22)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (22, N'20000000-0000-0000-0000-000000000006', '2026-10-29T00:00:00.000', 67.7, 23.7, 485, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 23)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (23, N'20000000-0000-0000-0000-000000000006', '2026-11-05T00:00:00.000', 67.1, 23.5, 520, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 24)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (24, N'20000000-0000-0000-0000-000000000006', '2026-11-12T00:00:00.000', 66.5, 23.3, 555, 3, N'Current check-in logged on target for Athletic Strength & Definition.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 25)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (25, N'20000000-0000-0000-0000-000000000007', '2026-10-22T00:00:00.000', 80.8, 26.1, 455, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 26)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (26, N'20000000-0000-0000-0000-000000000007', '2026-10-29T00:00:00.000', 80.2, 25.9, 490, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 27)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (27, N'20000000-0000-0000-0000-000000000007', '2026-11-05T00:00:00.000', 79.6, 25.7, 525, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 28)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (28, N'20000000-0000-0000-0000-000000000007', '2026-11-12T00:00:00.000', 79, 25.5, 560, 3, N'Current check-in logged on target for Compound Lift Progression.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 29)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (29, N'20000000-0000-0000-0000-000000000008', '2026-10-22T00:00:00.000', 60.3, 23, 460, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 30)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (30, N'20000000-0000-0000-0000-000000000008', '2026-10-29T00:00:00.000', 59.7, 22.7, 495, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 31)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (31, N'20000000-0000-0000-0000-000000000008', '2026-11-05T00:00:00.000', 59.1, 22.5, 530, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 32)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (32, N'20000000-0000-0000-0000-000000000008', '2026-11-12T00:00:00.000', 58.5, 22.3, 565, 3, N'Current check-in logged on target for Total Body Toning.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 33)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (33, N'20000000-0000-0000-0000-000000000009', '2026-10-22T00:00:00.000', 87.8, 26.5, 465, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 34)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (34, N'20000000-0000-0000-0000-000000000009', '2026-10-29T00:00:00.000', 87.2, 26.3, 500, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 35)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (35, N'20000000-0000-0000-0000-000000000009', '2026-11-05T00:00:00.000', 86.6, 26.1, 535, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 36)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (36, N'20000000-0000-0000-0000-000000000009', '2026-11-12T00:00:00.000', 86, 26, 570, 3, N'Current check-in logged on target for Lean Hypertrophy Split.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 37)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (37, N'20000000-0000-0000-0000-000000000010', '2026-10-22T00:00:00.000', 64.8, 23.2, 470, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 38)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (38, N'20000000-0000-0000-0000-000000000010', '2026-10-29T00:00:00.000', 64.2, 23, 505, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 39)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (39, N'20000000-0000-0000-0000-000000000010', '2026-11-05T00:00:00.000', 63.6, 22.8, 540, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 40)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (40, N'20000000-0000-0000-0000-000000000010', '2026-11-12T00:00:00.000', 63, 22.6, 575, 3, N'Current check-in logged on target for Resistance Conditioning.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 41)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (41, N'20000000-0000-0000-0000-000000000011', '2026-10-22T00:00:00.000', 86.8, 27.1, 475, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 42)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (42, N'20000000-0000-0000-0000-000000000011', '2026-10-29T00:00:00.000', 86.2, 26.9, 510, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 43)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (43, N'20000000-0000-0000-0000-000000000011', '2026-11-05T00:00:00.000', 85.6, 26.7, 545, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 44)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (44, N'20000000-0000-0000-0000-000000000011', '2026-11-12T00:00:00.000', 85, 26.5, 580, 3, N'Current check-in logged on target for HIIT Fat Loss & Agility.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 45)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (45, N'20000000-0000-0000-0000-000000000012', '2026-10-22T00:00:00.000', 67.3, 25.3, 480, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 46)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (46, N'20000000-0000-0000-0000-000000000012', '2026-10-29T00:00:00.000', 66.7, 25.1, 515, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 47)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (47, N'20000000-0000-0000-0000-000000000012', '2026-11-05T00:00:00.000', 66.1, 24.9, 550, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 48)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (48, N'20000000-0000-0000-0000-000000000012', '2026-11-12T00:00:00.000', 65.5, 24.7, 585, 3, N'Current check-in logged on target for Metabolic Conditioning.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 49)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (49, N'20000000-0000-0000-0000-000000000013', '2026-10-22T00:00:00.000', 82.8, 27, 485, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 50)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (50, N'20000000-0000-0000-0000-000000000013', '2026-10-29T00:00:00.000', 82.2, 26.8, 520, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 51)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (51, N'20000000-0000-0000-0000-000000000013', '2026-11-05T00:00:00.000', 81.6, 26.6, 555, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 52)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (52, N'20000000-0000-0000-0000-000000000013', '2026-11-12T00:00:00.000', 81, 26.4, 590, 3, N'Current check-in logged on target for Sprint & Cardio Stamina.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 53)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (53, N'20000000-0000-0000-0000-000000000014', '2026-10-22T00:00:00.000', 68.8, 24.4, 490, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 54)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (54, N'20000000-0000-0000-0000-000000000014', '2026-10-29T00:00:00.000', 68.2, 24.2, 525, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 55)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (55, N'20000000-0000-0000-0000-000000000014', '2026-11-05T00:00:00.000', 67.6, 24, 560, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 56)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (56, N'20000000-0000-0000-0000-000000000014', '2026-11-12T00:00:00.000', 67, 23.7, 595, 3, N'Current check-in logged on target for Calorie Burn & Core Endurance.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 57)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (57, N'20000000-0000-0000-0000-000000000015', '2026-10-22T00:00:00.000', 90.3, 27.9, 495, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 58)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (58, N'20000000-0000-0000-0000-000000000015', '2026-10-29T00:00:00.000', 89.7, 27.7, 530, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 59)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (59, N'20000000-0000-0000-0000-000000000015', '2026-11-05T00:00:00.000', 89.1, 27.5, 565, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 60)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (60, N'20000000-0000-0000-0000-000000000015', '2026-11-12T00:00:00.000', 88.5, 27.3, 600, 3, N'Current check-in logged on target for Kettlebell & Interval Shred.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 61)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (61, N'20000000-0000-0000-0000-000000000016', '2026-10-22T00:00:00.000', 69.8, 23.1, 500, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 62)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (62, N'20000000-0000-0000-0000-000000000016', '2026-10-29T00:00:00.000', 70.2, 23.2, 535, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 63)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (63, N'20000000-0000-0000-0000-000000000016', '2026-11-05T00:00:00.000', 70.6, 23.3, 570, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 64)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (64, N'20000000-0000-0000-0000-000000000016', '2026-11-12T00:00:00.000', 71, 23.5, 605, 3, N'Current check-in logged on target for Calisthenics & Upper Control.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 65)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (65, N'20000000-0000-0000-0000-000000000017', '2026-10-22T00:00:00.000', 57.8, 22.3, 505, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 66)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (66, N'20000000-0000-0000-0000-000000000017', '2026-10-29T00:00:00.000', 57.2, 22.1, 540, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 67)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (67, N'20000000-0000-0000-0000-000000000017', '2026-11-05T00:00:00.000', 56.6, 21.8, 575, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 68)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (68, N'20000000-0000-0000-0000-000000000017', '2026-11-12T00:00:00.000', 56, 21.6, 610, 3, N'Current check-in logged on target for Posture & Spinal Mobility.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 69)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (69, N'20000000-0000-0000-0000-000000000018', '2026-10-22T00:00:00.000', 78.3, 25, 510, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 70)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (70, N'20000000-0000-0000-0000-000000000018', '2026-10-29T00:00:00.000', 77.7, 24.8, 545, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 71)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (71, N'20000000-0000-0000-0000-000000000018', '2026-11-05T00:00:00.000', 77.1, 24.6, 580, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 72)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (72, N'20000000-0000-0000-0000-000000000018', '2026-11-12T00:00:00.000', 76.5, 24.4, 615, 3, N'Current check-in logged on target for Joint Longevity & Core Stability.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 73)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (73, N'20000000-0000-0000-0000-000000000019', '2026-10-22T00:00:00.000', 62.3, 22.9, 515, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 74)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (74, N'20000000-0000-0000-0000-000000000019', '2026-10-29T00:00:00.000', 61.7, 22.7, 550, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 75)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (75, N'20000000-0000-0000-0000-000000000019', '2026-11-05T00:00:00.000', 61.1, 22.4, 585, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 76)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (76, N'20000000-0000-0000-0000-000000000019', '2026-11-12T00:00:00.000', 60.5, 22.2, 620, 3, N'Current check-in logged on target for Flexibility & Bodyweight Strength.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 77)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (77, N'20000000-0000-0000-0000-000000000020', '2026-10-22T00:00:00.000', 81.3, 24.8, 520, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 78)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (78, N'20000000-0000-0000-0000-000000000020', '2026-10-29T00:00:00.000', 80.7, 24.6, 555, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 79)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (79, N'20000000-0000-0000-0000-000000000020', '2026-11-05T00:00:00.000', 80.1, 24.4, 590, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 80)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (80, N'20000000-0000-0000-0000-000000000020', '2026-11-12T00:00:00.000', 79.5, 24.3, 625, 3, N'Current check-in logged on target for Shoulder Rehab & Functional Flow.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 81)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (81, N'20000000-0000-0000-0000-000000000021', '2026-10-22T00:00:00.000', 88.8, 27.4, 525, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 82)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (82, N'20000000-0000-0000-0000-000000000021', '2026-10-29T00:00:00.000', 88.2, 27.2, 560, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 83)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (83, N'20000000-0000-0000-0000-000000000021', '2026-11-05T00:00:00.000', 87.6, 27, 595, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 84)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (84, N'20000000-0000-0000-0000-000000000021', '2026-11-12T00:00:00.000', 87, 26.9, 630, 3, N'Current check-in logged on target for Sustainable Nutrition & Weight Loss.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 85)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (85, N'20000000-0000-0000-0000-000000000022', '2026-10-22T00:00:00.000', 64.3, 23.9, 530, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 86)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (86, N'20000000-0000-0000-0000-000000000022', '2026-10-29T00:00:00.000', 63.7, 23.7, 565, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 87)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (87, N'20000000-0000-0000-0000-000000000022', '2026-11-05T00:00:00.000', 63.1, 23.5, 600, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 88)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (88, N'20000000-0000-0000-0000-000000000022', '2026-11-12T00:00:00.000', 62.5, 23.2, 635, 3, N'Current check-in logged on target for Macro Balance & Energy Optimization.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 89)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (89, N'20000000-0000-0000-0000-000000000023', '2026-10-22T00:00:00.000', 83.8, 27.1, 535, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 90)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (90, N'20000000-0000-0000-0000-000000000023', '2026-10-29T00:00:00.000', 83.2, 26.9, 570, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 91)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (91, N'20000000-0000-0000-0000-000000000023', '2026-11-05T00:00:00.000', 82.6, 26.7, 605, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 92)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (92, N'20000000-0000-0000-0000-000000000023', '2026-11-12T00:00:00.000', 82, 26.5, 640, 3, N'Current check-in logged on target for Cardiovascular Longevity & Diet.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 93)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (93, N'20000000-0000-0000-0000-000000000024', '2026-10-22T00:00:00.000', 66.3, 23.8, 540, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 94)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (94, N'20000000-0000-0000-0000-000000000024', '2026-10-29T00:00:00.000', 65.7, 23.6, 575, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 95)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (95, N'20000000-0000-0000-0000-000000000024', '2026-11-05T00:00:00.000', 65.1, 23.3, 610, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 96)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (96, N'20000000-0000-0000-0000-000000000024', '2026-11-12T00:00:00.000', 64.5, 23.1, 645, 3, N'Current check-in logged on target for Clean Eating & Aerobic Fitness.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 97)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (97, N'20000000-0000-0000-0000-000000000025', '2026-10-22T00:00:00.000', 90.8, 27.1, 545, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 98)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (98, N'20000000-0000-0000-0000-000000000025', '2026-10-29T00:00:00.000', 90.2, 26.9, 580, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 99)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (99, N'20000000-0000-0000-0000-000000000025', '2026-11-05T00:00:00.000', 89.6, 26.8, 615, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 100)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (100, N'20000000-0000-0000-0000-000000000025', '2026-11-12T00:00:00.000', 89, 26.6, 650, 3, N'Current check-in logged on target for Glycemic Control & Active Recovery.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 101)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (101, N'20000000-0000-0000-0000-000000000026', '2026-10-22T00:00:00.000', 91.3, 26.7, 550, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 102)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (102, N'20000000-0000-0000-0000-000000000026', '2026-10-29T00:00:00.000', 91.7, 26.8, 585, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 103)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (103, N'20000000-0000-0000-0000-000000000026', '2026-11-05T00:00:00.000', 92.1, 26.9, 620, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 104)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (104, N'20000000-0000-0000-0000-000000000026', '2026-11-12T00:00:00.000', 92.5, 27, 655, 3, N'Current check-in logged on target for Powerlifting & Maximal Strength.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 105)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (105, N'20000000-0000-0000-0000-000000000027', '2026-10-22T00:00:00.000', 65.3, 23.7, 555, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 106)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (106, N'20000000-0000-0000-0000-000000000027', '2026-10-29T00:00:00.000', 64.7, 23.5, 590, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 107)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (107, N'20000000-0000-0000-0000-000000000027', '2026-11-05T00:00:00.000', 64.1, 23.3, 625, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 108)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (108, N'20000000-0000-0000-0000-000000000027', '2026-11-12T00:00:00.000', 63.5, 23, 660, 3, N'Current check-in logged on target for Barbell Strength & Lower Body Power.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 109)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (109, N'20000000-0000-0000-0000-000000000028', '2026-10-22T00:00:00.000', 82.8, 25.8, 560, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 110)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (110, N'20000000-0000-0000-0000-000000000028', '2026-10-29T00:00:00.000', 83.2, 26, 595, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 111)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (111, N'20000000-0000-0000-0000-000000000028', '2026-11-05T00:00:00.000', 83.6, 26.1, 630, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 112)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (112, N'20000000-0000-0000-0000-000000000028', '2026-11-12T00:00:00.000', 84, 26.2, 665, 3, N'Current check-in logged on target for Compound Squat & Deadlift PR.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 113)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (113, N'20000000-0000-0000-0000-000000000029', '2026-10-22T00:00:00.000', 61.3, 23.1, 565, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 114)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (114, N'20000000-0000-0000-0000-000000000029', '2026-10-29T00:00:00.000', 60.7, 22.8, 600, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 115)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (115, N'20000000-0000-0000-0000-000000000029', '2026-11-05T00:00:00.000', 60.1, 22.6, 635, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 116)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (116, N'20000000-0000-0000-0000-000000000029', '2026-11-12T00:00:00.000', 59.5, 22.4, 670, 3, N'Current check-in logged on target for Strength-to-Weight Ratio.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 117)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (117, N'20000000-0000-0000-0000-000000000030', '2026-10-22T00:00:00.000', 89.3, 27, 570, 2.4, N'Week 1 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 118)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (118, N'20000000-0000-0000-0000-000000000030', '2026-10-29T00:00:00.000', 88.7, 26.8, 605, 2.6, N'Week 2 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 119)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (119, N'20000000-0000-0000-0000-000000000030', '2026-11-05T00:00:00.000', 88.1, 26.6, 640, 2.8, N'Week 3 biometric check-in recorded.');
IF NOT EXISTS (SELECT 1 FROM [HealthLogs] WHERE [Id] = 120)
    INSERT INTO [HealthLogs] ([Id], [ClientId], [LogDate], [WeightKg], [CalculatedBmi], [CaloriesBurned], [WaterIntakeLiters], [Notes]) VALUES (120, N'20000000-0000-0000-0000-000000000030', '2026-11-12T00:00:00.000', 87.5, 26.4, 675, 3, N'Current check-in logged on target for Explosive Power & Conditioning.');
SET IDENTITY_INSERT [HealthLogs] OFF;

-- ---------------------------------------------------------------------------
-- Table: [Notifications]
-- ---------------------------------------------------------------------------
SET IDENTITY_INSERT [Notifications] ON;
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 1)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (1, N'20000000-0000-0000-0000-000000000001', N'Your coach Marcus Vance assigned your active workout plan: ''Upper / Lower Hypertrophy Split''.', 0, '2026-11-12T07:59:09.920');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 2)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (2, N'20000000-0000-0000-0000-000000000001', N'Your nutrition plan ''High-Protein Recomposition Plan'' (2250 kcal/day) is active.', 0, '2026-11-11T13:59:09.923');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 3)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (3, N'20000000-0000-0000-0000-000000000001', N'Upcoming consultation with Marcus Vance is confirmed at 03:00 PM.', 1, '2026-11-10T13:59:09.923');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 4)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (4, N'20000000-0000-0000-0000-000000000002', N'Your coach Marcus Vance assigned your active workout plan: ''Lower Body & Core Sculpt Routine''.', 0, '2026-11-12T07:59:10.103');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 5)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (5, N'20000000-0000-0000-0000-000000000002', N'Your nutrition plan ''Lean Sculpt Macro Protocol'' (1850 kcal/day) is active.', 0, '2026-11-11T13:59:10.103');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 6)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (6, N'20000000-0000-0000-0000-000000000002', N'Upcoming consultation with Marcus Vance is confirmed at 04:30 PM.', 1, '2026-11-10T13:59:10.103');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 7)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (7, N'20000000-0000-0000-0000-000000000003', N'Your coach Marcus Vance assigned your active workout plan: ''Progressive Push / Pull / Legs''.', 0, '2026-11-12T07:59:10.270');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 8)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (8, N'20000000-0000-0000-0000-000000000003', N'Your nutrition plan ''Clean Lean Mass Surplus Plan'' (2650 kcal/day) is active.', 0, '2026-11-11T13:59:10.270');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 9)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (9, N'20000000-0000-0000-0000-000000000003', N'Upcoming consultation with Marcus Vance is confirmed at 09:00 AM.', 1, '2026-11-10T13:59:10.270');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 10)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (10, N'20000000-0000-0000-0000-000000000004', N'Your coach Marcus Vance assigned your active workout plan: ''Full-Body Resistance & Tone''.', 0, '2026-11-12T07:59:10.396');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 11)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (11, N'20000000-0000-0000-0000-000000000004', N'Your nutrition plan ''Metabolic Balance Nutrition Plan'' (1800 kcal/day) is active.', 0, '2026-11-11T13:59:10.396');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 12)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (12, N'20000000-0000-0000-0000-000000000004', N'Upcoming consultation with Marcus Vance is confirmed at 10:30 AM.', 1, '2026-11-10T13:59:10.396');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 13)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (13, N'20000000-0000-0000-0000-000000000005', N'Your coach Marcus Vance assigned your active workout plan: ''Heavy Compound & Fat-Loss Split''.', 0, '2026-11-12T07:59:10.536');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 14)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (14, N'20000000-0000-0000-0000-000000000005', N'Your nutrition plan ''High-Satiety Cutting Protocol'' (2150 kcal/day) is active.', 0, '2026-11-11T13:59:10.536');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 15)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (15, N'20000000-0000-0000-0000-000000000005', N'Upcoming consultation with Marcus Vance is confirmed at 01:30 PM.', 1, '2026-11-10T13:59:10.536');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 16)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (16, N'20000000-0000-0000-0000-000000000006', N'Your coach Marcus Vance assigned your active workout plan: ''Athletic Hypertrophy & Core''.', 0, '2026-11-12T07:59:10.686');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 17)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (17, N'20000000-0000-0000-0000-000000000006', N'Your nutrition plan ''Performance Lean Fuel Plan'' (1950 kcal/day) is active.', 0, '2026-11-11T13:59:10.686');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 18)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (18, N'20000000-0000-0000-0000-000000000006', N'Upcoming consultation with Marcus Vance is confirmed at 03:00 PM.', 1, '2026-11-10T13:59:10.686');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 19)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (19, N'20000000-0000-0000-0000-000000000007', N'Your coach Marcus Vance assigned your active workout plan: ''Barbell Strength & Hypertrophy''.', 0, '2026-11-12T07:59:10.826');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 20)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (20, N'20000000-0000-0000-0000-000000000007', N'Your nutrition plan ''Balanced Strength Macro Plan'' (2300 kcal/day) is active.', 0, '2026-11-11T13:59:10.826');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 21)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (21, N'20000000-0000-0000-0000-000000000007', N'Upcoming consultation with Marcus Vance is confirmed at 04:30 PM.', 1, '2026-11-10T13:59:10.826');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 22)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (22, N'20000000-0000-0000-0000-000000000008', N'Your coach Marcus Vance assigned your active workout plan: ''Dumbbell & Cable Toning Split''.', 0, '2026-11-12T07:59:11.006');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 23)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (23, N'20000000-0000-0000-0000-000000000008', N'Your nutrition plan ''Clean Micronutrient Deficit Plan'' (1750 kcal/day) is active.', 0, '2026-11-11T13:59:11.006');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 24)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (24, N'20000000-0000-0000-0000-000000000008', N'Upcoming consultation with Marcus Vance is confirmed at 09:00 AM.', 1, '2026-11-10T13:59:11.006');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 25)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (25, N'20000000-0000-0000-0000-000000000009', N'Your coach Marcus Vance assigned your active workout plan: ''5-Day Hypertrophy Volume Block''.', 0, '2026-11-12T07:59:11.173');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 26)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (26, N'20000000-0000-0000-0000-000000000009', N'Your nutrition plan ''Lean Muscle Maintenance Diet'' (2350 kcal/day) is active.', 0, '2026-11-11T13:59:11.173');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 27)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (27, N'20000000-0000-0000-0000-000000000009', N'Upcoming consultation with Marcus Vance is confirmed at 10:30 AM.', 1, '2026-11-10T13:59:11.173');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 28)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (28, N'20000000-0000-0000-0000-000000000010', N'Your coach Marcus Vance assigned your active workout plan: ''Metabolic Resistance Circuit''.', 0, '2026-11-12T07:59:11.353');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 29)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (29, N'20000000-0000-0000-0000-000000000010', N'Your nutrition plan ''High-Protein Toning Nutrition'' (1850 kcal/day) is active.', 0, '2026-11-11T13:59:11.353');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 30)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (30, N'20000000-0000-0000-0000-000000000010', N'Upcoming consultation with Marcus Vance is confirmed at 01:30 PM.', 1, '2026-11-10T13:59:11.353');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 31)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (31, N'20000000-0000-0000-0000-000000000011', N'Your coach Elena Rostova assigned your active workout plan: ''HIIT Sprint & Kettlebell Shred''.', 0, '2026-11-12T07:59:11.543');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 32)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (32, N'20000000-0000-0000-0000-000000000011', N'Your nutrition plan ''Rapid Fat-Oxidation Deficit Plan'' (2050 kcal/day) is active.', 0, '2026-11-11T13:59:11.543');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 33)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (33, N'20000000-0000-0000-0000-000000000011', N'Upcoming consultation with Elena Rostova is confirmed at 03:00 PM.', 1, '2026-11-10T13:59:11.543');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 34)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (34, N'20000000-0000-0000-0000-000000000012', N'Your coach Elena Rostova assigned your active workout plan: ''Tabata & Core Burn Protocol''.', 0, '2026-11-12T07:59:11.726');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 35)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (35, N'20000000-0000-0000-0000-000000000012', N'Your nutrition plan ''Low-Glycemic Metabolic Fuel'' (1780 kcal/day) is active.', 0, '2026-11-11T13:59:11.726');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 36)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (36, N'20000000-0000-0000-0000-000000000012', N'Upcoming consultation with Elena Rostova is confirmed at 04:30 PM.', 1, '2026-11-10T13:59:11.726');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 37)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (37, N'20000000-0000-0000-0000-000000000013', N'Your coach Elena Rostova assigned your active workout plan: ''VO2 Max Interval & Plyometrics''.', 0, '2026-11-12T07:59:11.850');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 38)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (38, N'20000000-0000-0000-0000-000000000013', N'Your nutrition plan ''Endurance Shred Nutrition Plan'' (2100 kcal/day) is active.', 0, '2026-11-11T13:59:11.850');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 39)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (39, N'20000000-0000-0000-0000-000000000013', N'Upcoming consultation with Elena Rostova is confirmed at 09:00 AM.', 1, '2026-11-10T13:59:11.850');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 40)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (40, N'20000000-0000-0000-0000-000000000014', N'Your coach Elena Rostova assigned your active workout plan: ''Functional Cardio & Ab Circuit''.', 0, '2026-11-12T07:59:12.033');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 41)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (41, N'20000000-0000-0000-0000-000000000014', N'Your nutrition plan ''Caloric Deficit Whole-Food Plan'' (1820 kcal/day) is active.', 0, '2026-11-11T13:59:12.033');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 42)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (42, N'20000000-0000-0000-0000-000000000014', N'Upcoming consultation with Elena Rostova is confirmed at 10:30 AM.', 1, '2026-11-10T13:59:12.033');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 43)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (43, N'20000000-0000-0000-0000-000000000015', N'Your coach Elena Rostova assigned your active workout plan: ''EMOM Kettlebell & Battle Ropes''.', 0, '2026-11-12T07:59:12.203');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 44)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (44, N'20000000-0000-0000-0000-000000000015', N'Your nutrition plan ''High-Protein Shred Protocol'' (2150 kcal/day) is active.', 0, '2026-11-11T13:59:12.203');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 45)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (45, N'20000000-0000-0000-0000-000000000015', N'Upcoming consultation with Elena Rostova is confirmed at 01:30 PM.', 1, '2026-11-10T13:59:12.203');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 46)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (46, N'20000000-0000-0000-0000-000000000016', N'Your coach David Chen assigned your active workout plan: ''Calisthenics Pull & Ring Mastery''.', 0, '2026-11-12T07:59:12.346');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 47)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (47, N'20000000-0000-0000-0000-000000000016', N'Your nutrition plan ''Joint-Support Lean Fuel Plan'' (2200 kcal/day) is active.', 0, '2026-11-11T13:59:12.346');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 48)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (48, N'20000000-0000-0000-0000-000000000016', N'Upcoming consultation with David Chen is confirmed at 03:00 PM.', 1, '2026-11-10T13:59:12.346');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 49)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (49, N'20000000-0000-0000-0000-000000000017', N'Your coach David Chen assigned your active workout plan: ''Thoracic & Scapular Alignment Flow''.', 0, '2026-11-12T07:59:12.450');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 50)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (50, N'20000000-0000-0000-0000-000000000017', N'Your nutrition plan ''Anti-Inflammatory Whole-Food Diet'' (1850 kcal/day) is active.', 0, '2026-11-11T13:59:12.450');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 51)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (51, N'20000000-0000-0000-0000-000000000017', N'Upcoming consultation with David Chen is confirmed at 04:30 PM.', 1, '2026-11-10T13:59:12.450');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 52)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (52, N'20000000-0000-0000-0000-000000000018', N'Your coach David Chen assigned your active workout plan: ''Core Stabilization & Hip Mobility''.', 0, '2026-11-12T07:59:12.606');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 53)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (53, N'20000000-0000-0000-0000-000000000018', N'Your nutrition plan ''Collagen & Micronutrient Balance'' (2100 kcal/day) is active.', 0, '2026-11-11T13:59:12.606');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 54)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (54, N'20000000-0000-0000-0000-000000000018', N'Upcoming consultation with David Chen is confirmed at 09:00 AM.', 1, '2026-11-10T13:59:12.606');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 55)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (55, N'20000000-0000-0000-0000-000000000019', N'Your coach David Chen assigned your active workout plan: ''Bodyweight Flow & Deep Stretch''.', 0, '2026-11-12T07:59:12.736');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 56)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (56, N'20000000-0000-0000-0000-000000000019', N'Your nutrition plan ''Clean Plant-Rich Recovery Diet'' (1900 kcal/day) is active.', 0, '2026-11-11T13:59:12.740');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 57)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (57, N'20000000-0000-0000-0000-000000000019', N'Upcoming consultation with David Chen is confirmed at 10:30 AM.', 1, '2026-11-10T13:59:12.740');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 58)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (58, N'20000000-0000-0000-0000-000000000020', N'Your coach David Chen assigned your active workout plan: ''Rotator Cuff & Functional Strength''.', 0, '2026-11-12T07:59:12.986');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 59)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (59, N'20000000-0000-0000-0000-000000000020', N'Your nutrition plan ''Omega-3 Mobility Nutrition Plan'' (2150 kcal/day) is active.', 0, '2026-11-11T13:59:12.986');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 60)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (60, N'20000000-0000-0000-0000-000000000020', N'Upcoming consultation with David Chen is confirmed at 01:30 PM.', 1, '2026-11-10T13:59:12.986');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 61)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (61, N'20000000-0000-0000-0000-000000000021', N'Your coach Dr. Sarah Jenkins assigned your active workout plan: ''Low-Impact Metabolic Walk & Lift''.', 0, '2026-11-12T07:59:13.123');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 62)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (62, N'20000000-0000-0000-0000-000000000021', N'Your nutrition plan ''Clinical Glycemic Balance Plan'' (2050 kcal/day) is active.', 0, '2026-11-11T13:59:13.123');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 63)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (63, N'20000000-0000-0000-0000-000000000021', N'Upcoming consultation with Dr. Sarah Jenkins is confirmed at 03:00 PM.', 1, '2026-11-10T13:59:13.123');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 64)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (64, N'20000000-0000-0000-0000-000000000022', N'Your coach Dr. Sarah Jenkins assigned your active workout plan: ''Full-Body Longevity & Zone-2 Cardio''.', 0, '2026-11-12T07:59:13.223');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 65)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (65, N'20000000-0000-0000-0000-000000000022', N'Your nutrition plan ''Precision Macro Equilibrium Diet'' (1850 kcal/day) is active.', 0, '2026-11-11T13:59:13.223');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 66)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (66, N'20000000-0000-0000-0000-000000000022', N'Upcoming consultation with Dr. Sarah Jenkins is confirmed at 04:30 PM.', 1, '2026-11-10T13:59:13.223');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 67)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (67, N'20000000-0000-0000-0000-000000000023', N'Your coach Dr. Sarah Jenkins assigned your active workout plan: ''Heart-Health Aerobic & Resistance''.', 0, '2026-11-12T07:59:13.353');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 68)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (68, N'20000000-0000-0000-0000-000000000023', N'Your nutrition plan ''Mediterranean Clinical Heart Diet'' (2000 kcal/day) is active.', 0, '2026-11-11T13:59:13.353');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 69)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (69, N'20000000-0000-0000-0000-000000000023', N'Upcoming consultation with Dr. Sarah Jenkins is confirmed at 09:00 AM.', 1, '2026-11-10T13:59:13.353');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 70)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (70, N'20000000-0000-0000-0000-000000000024', N'Your coach Dr. Sarah Jenkins assigned your active workout plan: ''Endurance Pace & Core Toning''.', 0, '2026-11-12T07:59:13.490');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 71)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (71, N'20000000-0000-0000-0000-000000000024', N'Your nutrition plan ''Whole-Food Micronutrient Protocol'' (1880 kcal/day) is active.', 0, '2026-11-11T13:59:13.490');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 72)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (72, N'20000000-0000-0000-0000-000000000024', N'Upcoming consultation with Dr. Sarah Jenkins is confirmed at 10:30 AM.', 1, '2026-11-10T13:59:13.490');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 73)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (73, N'20000000-0000-0000-0000-000000000025', N'Your coach Dr. Sarah Jenkins assigned your active workout plan: ''Steady-State Conditioning & Strength''.', 0, '2026-11-12T07:59:13.630');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 74)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (74, N'20000000-0000-0000-0000-000000000025', N'Your nutrition plan ''Metabolic Insulin-Sensitivity Plan'' (2150 kcal/day) is active.', 0, '2026-11-11T13:59:13.630');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 75)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (75, N'20000000-0000-0000-0000-000000000025', N'Upcoming consultation with Dr. Sarah Jenkins is confirmed at 01:30 PM.', 1, '2026-11-10T13:59:13.630');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 76)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (76, N'20000000-0000-0000-0000-000000000026', N'Your coach Aarav Patel assigned your active workout plan: ''Competition Squat / Bench / Deadlift''.', 0, '2026-11-12T07:59:13.776');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 77)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (77, N'20000000-0000-0000-0000-000000000026', N'Your nutrition plan ''Powerlifting Hyper-Recovery Surplus'' (2850 kcal/day) is active.', 0, '2026-11-11T13:59:13.776');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 78)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (78, N'20000000-0000-0000-0000-000000000026', N'Upcoming consultation with Aarav Patel is confirmed at 03:00 PM.', 1, '2026-11-10T13:59:13.776');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 79)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (79, N'20000000-0000-0000-0000-000000000027', N'Your coach Aarav Patel assigned your active workout plan: ''Barbell Hip-Thrust & Squat Block''.', 0, '2026-11-12T07:59:13.940');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 80)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (80, N'20000000-0000-0000-0000-000000000027', N'Your nutrition plan ''Strength Athlete Macro Protocol'' (2050 kcal/day) is active.', 0, '2026-11-11T13:59:13.940');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 81)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (81, N'20000000-0000-0000-0000-000000000027', N'Upcoming consultation with Aarav Patel is confirmed at 04:30 PM.', 1, '2026-11-10T13:59:13.940');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 82)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (82, N'20000000-0000-0000-0000-000000000028', N'Your coach Aarav Patel assigned your active workout plan: ''Heavy Pull & Posterior Chain Peak''.', 0, '2026-11-12T07:59:14.136');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 83)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (83, N'20000000-0000-0000-0000-000000000028', N'Your nutrition plan ''High-Glycogen Strength Surplus'' (2750 kcal/day) is active.', 0, '2026-11-11T13:59:14.136');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 84)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (84, N'20000000-0000-0000-0000-000000000028', N'Upcoming consultation with Aarav Patel is confirmed at 09:00 AM.', 1, '2026-11-10T13:59:14.136');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 85)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (85, N'20000000-0000-0000-0000-000000000029', N'Your coach Aarav Patel assigned your active workout plan: ''Relative Strength & Explosive Lift''.', 0, '2026-11-12T07:59:14.303');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 86)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (86, N'20000000-0000-0000-0000-000000000029', N'Your nutrition plan ''Lean Power Performance Nutrition'' (1950 kcal/day) is active.', 0, '2026-11-11T13:59:14.303');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 87)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (87, N'20000000-0000-0000-0000-000000000029', N'Upcoming consultation with Aarav Patel is confirmed at 10:30 AM.', 1, '2026-11-10T13:59:14.303');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 88)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (88, N'20000000-0000-0000-0000-000000000030', N'Your coach Aarav Patel assigned your active workout plan: ''Powerbuilding & Sled Conditioning''.', 0, '2026-11-12T07:59:14.506');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 89)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (89, N'20000000-0000-0000-0000-000000000030', N'Your nutrition plan ''Athletic Power Recomposition Diet'' (2450 kcal/day) is active.', 0, '2026-11-11T13:59:14.506');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 90)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (90, N'20000000-0000-0000-0000-000000000030', N'Upcoming consultation with Aarav Patel is confirmed at 01:30 PM.', 1, '2026-11-10T13:59:14.506');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 91)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (91, N'10000000-0000-0000-0000-000000000001', N'Your active coaching roster is synchronized with 10 assigned clients.', 0, '2026-11-12T10:59:14.526');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 92)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (92, N'10000000-0000-0000-0000-000000000002', N'Your active coaching roster is synchronized with 5 assigned clients.', 0, '2026-11-12T10:59:14.543');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 93)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (93, N'10000000-0000-0000-0000-000000000003', N'Your active coaching roster is synchronized with 5 assigned clients.', 0, '2026-11-12T10:59:14.553');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 94)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (94, N'10000000-0000-0000-0000-000000000004', N'Your active coaching roster is synchronized with 5 assigned clients.', 0, '2026-11-12T10:59:14.556');
IF NOT EXISTS (SELECT 1 FROM [Notifications] WHERE [Id] = 95)
    INSERT INTO [Notifications] ([Id], [UserId], [Message], [IsRead], [CreatedAt]) VALUES (95, N'10000000-0000-0000-0000-000000000005', N'Your active coaching roster is synchronized with 5 assigned clients.', 0, '2026-11-12T10:59:14.560');
SET IDENTITY_INSERT [Notifications] OFF;

