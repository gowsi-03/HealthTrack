using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HealthTrack.Models
{
    public class Appointment
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string ClientId { get; set; } = string.Empty;

        [ForeignKey("ClientId")]
        public virtual ApplicationUser? Client { get; set; }

        [Required]
        public string TrainerId { get; set; } = string.Empty;

        [ForeignKey("TrainerId")]
        public virtual ApplicationUser? Trainer { get; set; }

        [Required]
        [DataType(DataType.Date)]
        [Display(Name = "Consultation Date")]
        public DateTime AppointmentDate { get; set; }

        [Required]
        [StringLength(50)]
        [Display(Name = "Time Slot")]
        public string TimeSlot { get; set; } = "10:00 AM";

        [Required]
        [StringLength(20)]
        public string Status { get; set; } = "Pending"; // Pending, Confirmed, Declined, Completed

        [StringLength(250)]
        [Display(Name = "Notes / Reason")]
        public string? Notes { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}
