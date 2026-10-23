using System.Threading.Tasks;

namespace HealthTrack.Services
{
    public interface IEmailService
    {
        Task SendEmailAsync(string toEmail, string subject, string htmlBody);
        Task SendTrainerRegistrationPendingEmailAsync(string toEmail, string trainerFullName);
        Task SendTrainerApprovedEmailAsync(string toEmail, string trainerFullName, string loginUrl);
    }
}
