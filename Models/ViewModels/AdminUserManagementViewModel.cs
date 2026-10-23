using System.ComponentModel.DataAnnotations;

namespace HealthTrack.Models.ViewModels
{
    public class AdminUserManagementViewModel
    {
        // Admin Profile Info
        public string AdminFullName { get; set; } = "Jordan Lee";
        public string AdminEmail { get; set; } = "admin@healthtrack.com";
        public string AdminRole { get; set; } = "Administrator";
        public string AdminInitials { get; set; } = "JL";
        public int UnreadNotificationsCount { get; set; } = 3;

        // Search & Filters
        public string SearchTerm { get; set; } = string.Empty;
        public string StatusFilter { get; set; } = "All"; // All, Active, Inactive
        public string RoleFilter { get; set; } = "All"; // All, Client, Trainer, Admin

        // Pagination
        public int CurrentPage { get; set; } = 1;
        public int PageSize { get; set; } = 4;
        public int TotalItems { get; set; } = 28;
        public int TotalPages => (int)Math.Ceiling((double)TotalItems / (PageSize > 0 ? PageSize : 4));

        public int StartItemIndex => TotalItems == 0 ? 0 : ((CurrentPage - 1) * PageSize) + 1;
        public int EndItemIndex => Math.Min(CurrentPage * PageSize, TotalItems);

        // Users List
        public List<AdminUserListItemViewModel> Users { get; set; } = new();

        // Form for Add User modal
        public AdminAddUserInputModel NewUserForm { get; set; } = new();
    }

    public class AdminUserListItemViewModel
    {
        public string Id { get; set; } = string.Empty;
        public string FullName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Role { get; set; } = "Client"; // Client, Trainer, Admin
        public string Status { get; set; } = "Active"; // Active, Inactive
        public string LastActive { get; set; } = "Apr 12, 2025";
        public string Initials { get; set; } = "AM";
        public string AvatarBgColor { get; set; } = "#E0F2FE";
        public string AvatarTextColor { get; set; } = "#0284C7";
    }
}
