using System.ComponentModel.DataAnnotations;
using HealthTrack.Models;

namespace HealthTrack.Models.ViewModels
{
    public class NotificationsViewModel
    {
        public string ClientId { get; set; } = string.Empty;
        public string FullName { get; set; } = "John Doe";
        public string Email { get; set; } = "client@healthtrack.com";

        public int UnreadCount { get; set; } = 2;
        public int TotalCount { get; set; } = 4;

        public List<NotificationItemViewModel> Notifications { get; set; } = new();
    }

    public class NotificationItemViewModel
    {
        public int Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public string Body { get; set; } = string.Empty;
        public string TimeAgo { get; set; } = "Just now";
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public bool IsRead { get; set; } = false;
        public string Category { get; set; } = "workout"; // workout, appointment, diet, progress
        public string IconType { get; set; } = "dumbbell"; // dumbbell, calendar, cutlery, activity
    }
}
