using System.ComponentModel.DataAnnotations;

namespace HealthTrack.Models.ViewModels
{
    public class AdminTrainerManagementViewModel
    {
        // Admin Profile Info
        public string AdminFullName { get; set; } = "Jordan Lee";
        public string AdminEmail { get; set; } = "admin@healthtrack.com";
        public string AdminRole { get; set; } = "Administrator";
        public string AdminInitials { get; set; } = "JL";
        public int UnreadNotificationsCount { get; set; } = 3;

        // Search & Filters
        public string SearchTerm { get; set; } = string.Empty;
        public string SpecialtyFilter { get; set; } = "All"; // All, Personal Training, Nutrition, Strength, Rehab
        public string StatusFilter { get; set; } = "All"; // All, Active, Inactive

        // Pagination
        public int CurrentPage { get; set; } = 1;
        public int PageSize { get; set; } = 4;
        public int TotalItems { get; set; } = 0;
        public int TotalPages => (int)Math.Ceiling((double)TotalItems / (PageSize > 0 ? PageSize : 4));
        public int StartItemIndex => TotalItems == 0 ? 0 : ((CurrentPage - 1) * PageSize) + 1;
        public int EndItemIndex => Math.Min(CurrentPage * PageSize, TotalItems);

        // Trainers List
        public List<AdminTrainerListItemViewModel> Trainers { get; set; } = new();

        // Form for Add Trainer modal
        public AdminAddTrainerInputModel NewTrainerForm { get; set; } = new();
    }

    public class AdminTrainerListItemViewModel
    {
        public string Id { get; set; } = string.Empty;
        public string FullName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Specialty { get; set; } = "Certified Performance Coach";
        public int AssignedClientsCount { get; set; } = 0;
        public string Status { get; set; } = "Active"; // Active, Inactive
        public string JoinedDate { get; set; } = "Apr 12, 2025";
        public string Initials { get; set; } = "MP";
        public string AvatarBgColor { get; set; } = "#E0F2FE";
        public string AvatarTextColor { get; set; } = "#0284C7";
    }

    public class AdminAddTrainerInputModel
    {
        [Required(ErrorMessage = "Full Name is required.")]
        [StringLength(100)]
        public string FullName { get; set; } = string.Empty;

        [Required(ErrorMessage = "Email is required.")]
        [EmailAddress(ErrorMessage = "Please enter a valid email address.")]
        public string Email { get; set; } = string.Empty;

        [Required(ErrorMessage = "Specialty / Coaching Domain is required.")]
        [StringLength(100)]
        public string Specialty { get; set; } = "Personal Training";

        [Required(ErrorMessage = "Temporary password is required.")]
        [StringLength(100, MinimumLength = 6, ErrorMessage = "Password must be at least 6 characters.")]
        public string Password { get; set; } = "Trainer123!";
    }
}
