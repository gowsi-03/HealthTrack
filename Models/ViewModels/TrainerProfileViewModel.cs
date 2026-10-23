using System.ComponentModel.DataAnnotations;

namespace HealthTrack.Models.ViewModels
{
    public class TrainerProfileViewModel
    {
        public string Id { get; set; } = string.Empty;

        [Required(ErrorMessage = "Full Name is required.")]
        [StringLength(100)]
        [Display(Name = "Full Name")]
        public string FullName { get; set; } = string.Empty;

        public string Email { get; set; } = string.Empty;

        [Display(Name = "Phone Number")]
        [Phone(ErrorMessage = "Please enter a valid phone number.")]
        public string? PhoneNumber { get; set; }

        [Required(ErrorMessage = "Please select or enter your coaching specialty.")]
        [StringLength(100)]
        [Display(Name = "Coaching Specialization")]
        public string Specialty { get; set; } = "Strength & Conditioning";

        [Display(Name = "Certifications & Credentials")]
        [StringLength(300)]
        public string? Certifications { get; set; }

        [Display(Name = "Coaching Bio / Philosophy")]
        [StringLength(1000)]
        public string? Bio { get; set; }

        public string JoinedDate { get; set; } = string.Empty;
        public string Initials { get; set; } = "TR";
        public string AvatarBgColor { get; set; } = "#ECFDF5";
        public string AvatarTextColor { get; set; } = "#059669";

        public int AssignedClientsCount { get; set; }
        public int ActivePlansCount { get; set; }
        public int UpcomingAppointmentsCount { get; set; }

        public bool IsFirstTimeSetup { get; set; }
        public bool IsProfileCompleted { get; set; }
    }
}
