using System;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace HealthTrack.Services
{
    public class EmailService : IEmailService
    {
        private readonly IConfiguration _configuration;
        private readonly IWebHostEnvironment _env;
        private readonly ILogger<EmailService> _logger;

        public EmailService(
            IConfiguration configuration,
            IWebHostEnvironment env,
            ILogger<EmailService> logger)
        {
            _configuration = configuration;
            _env = env;
            _logger = logger;
        }

        public async Task SendEmailAsync(string toEmail, string subject, string htmlBody)
        {
            var smtpServer = _configuration["EmailSettings:SmtpServer"];
            var portString = _configuration["EmailSettings:SmtpPort"];
            var senderEmail = _configuration["EmailSettings:SenderEmail"] ?? "no-reply@healthtrack.com";
            var senderName = _configuration["EmailSettings:SenderName"] ?? "HealthTrack Platform";
            var username = _configuration["EmailSettings:Username"];
            var password = _configuration["EmailSettings:Password"];
            var enableSsl = bool.TryParse(_configuration["EmailSettings:EnableSsl"], out var ssl) ? ssl : true;

            int.TryParse(portString, out int port);
            if (port <= 0) port = 587;

            // If SMTP server is configured, attempt sending real email
            if (!string.IsNullOrWhiteSpace(smtpServer))
            {
                try
                {
                    using var message = new MailMessage
                    {
                        From = new MailAddress(senderEmail, senderName),
                        Subject = subject,
                        Body = htmlBody,
                        IsBodyHtml = true
                    };
                    message.To.Add(new MailAddress(toEmail));

                    using var client = new SmtpClient(smtpServer, port)
                    {
                        EnableSsl = enableSsl
                    };

                    if (!string.IsNullOrWhiteSpace(username) && !string.IsNullOrWhiteSpace(password))
                    {
                        client.Credentials = new NetworkCredential(username, password);
                    }

                    await client.SendMailAsync(message);
                    _logger.LogInformation("Email sent successfully via SMTP to {ToEmail} with subject '{Subject}'", toEmail, subject);
                    return;
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Failed to send email via SMTP to {ToEmail}. Falling back to preview file.", toEmail);
                }
            }

            // Local development / fallback mode: Save HTML preview file and log to console
            try
            {
                var previewDir = Path.Combine(_env.WebRootPath ?? Path.Combine(Directory.GetCurrentDirectory(), "wwwroot"), "mail-previews");
                if (!Directory.Exists(previewDir))
                {
                    Directory.CreateDirectory(previewDir);
                }

                var safeTo = toEmail.Replace("@", "_at_").Replace(".", "_");
                var fileName = $"{DateTime.UtcNow:yyyyMMdd_HHmmss}_{safeTo}.html";
                var filePath = Path.Combine(previewDir, fileName);

                await File.WriteAllTextAsync(filePath, htmlBody);
                _logger.LogInformation("[DEV EMAIL DISPATCHED] To: {ToEmail} | Subject: {Subject} | Preview saved: /mail-previews/{FileName}", toEmail, subject, fileName);
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "Could not write email preview file to disk.");
            }
        }

        public async Task SendTrainerRegistrationPendingEmailAsync(string toEmail, string trainerFullName)
        {
            var subject = "HealthTrack — Your Trainer Application has been received!";
            var html = $@"<!DOCTYPE html>
<html lang=""en"">
<head>
    <meta charset=""UTF-8"">
    <meta name=""viewport"" content=""width=device-width, initial-scale=1.0"">
    <title>Application Received</title>
</head>
<body style=""font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; background-color: #F8FAFC; margin: 0; padding: 30px 15px; color: #1E293B;"">
    <table align=""center"" border=""0"" cellpadding=""0"" cellspacing=""0"" width=""100%"" style=""max-width: 600px; background-color: #FFFFFF; border: 1px solid #E2E8F0; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.03);"">
        <!-- Header -->
        <tr>
            <td style=""background-color: #0F172A; padding: 28px 32px; text-align: left;"">
                <table width=""100%"" border=""0"" cellpadding=""0"" cellspacing=""0"">
                    <tr>
                        <td>
                            <div style=""display: inline-block; vertical-align: middle; background-color: #10B981; width: 36px; height: 36px; border-radius: 10px; text-align: center; line-height: 36px; color: #FFFFFF; font-weight: 800; font-size: 18px;"">H</div>
                            <span style=""color: #FFFFFF; font-size: 20px; font-weight: 800; letter-spacing: -0.5px; margin-left: 10px; vertical-align: middle;"">HealthTrack</span>
                        </td>
                        <td align=""right"">
                            <span style=""background: rgba(245, 158, 11, 0.15); border: 1px solid rgba(245, 158, 11, 0.4); color: #F59E0B; font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; padding: 5px 12px; border-radius: 999px;"">Pending Review</span>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

        <!-- Main Body -->
        <tr>
            <td style=""padding: 36px 32px;"">
                <h2 style=""margin-top: 0; margin-bottom: 12px; font-size: 22px; font-weight: 800; color: #0F172A; letter-spacing: -0.5px;"">
                    Welcome, {trainerFullName}!
                </h2>
                <p style=""font-size: 15px; line-height: 1.6; color: #475569; margin-bottom: 24px;"">
                    Thank you for registering as a certified coach on <strong>HealthTrack</strong>. Your account has been created successfully, and your profile is currently undergoing verification by our Administrator.
                </p>

                <div style=""background-color: #FFFBEB; border: 1px solid #FDE68A; border-radius: 12px; padding: 20px; margin-bottom: 24px;"">
                    <table border=""0"" cellpadding=""0"" cellspacing=""0"" width=""100%"">
                        <tr>
                            <td width=""36"" valign=""top"" style=""padding-right: 12px;"">
                                <div style=""background-color: #F59E0B; color: #FFFFFF; border-radius: 50%; width: 28px; height: 28px; text-align: center; line-height: 28px; font-weight: bold; font-size: 14px;"">!</div>
                            </td>
                            <td>
                                <div style=""font-size: 14px; font-weight: 700; color: #92400E; margin-bottom: 4px;"">Account Status: Pending Administrator Approval</div>
                                <div style=""font-size: 13px; color: #B45309; line-height: 1.5;"">To ensure quality and client safety, all trainer profiles require administrator review before accessing client rosters and program builders.</div>
                            </td>
                        </tr>
                    </table>
                </div>

                <h3 style=""font-size: 15px; font-weight: 700; color: #0F172A; margin-bottom: 12px;"">What happens next?</h3>
                <ol style=""margin: 0; padding-left: 20px; color: #475569; font-size: 14px; line-height: 1.8;"">
                    <li><strong>Admin Review:</strong> An administrator will review your application details.</li>
                    <li><strong>Instant Approval Notification:</strong> Once approved, you will receive an immediate confirmation email at this address.</li>
                    <li><strong>Access Unlocked:</strong> You will then be able to log in, customize your profile, assign workouts, and coach clients.</li>
                </ol>

                <div style=""margin-top: 30px; padding-top: 24px; border-top: 1px solid #E2E8F0; font-size: 13px; color: #64748B; line-height: 1.6;"">
                    Have questions or need to expedite your verification? Reply directly to this email or contact support at <a href=""mailto:support@healthtrack.com"" style=""color: #10B981; text-decoration: none; font-weight: 600;"">support@healthtrack.com</a>.
                </div>
            </td>
        </tr>

        <!-- Footer -->
        <tr>
            <td style=""background-color: #F1F5F9; padding: 20px 32px; text-align: center; font-size: 12px; color: #94A3B8; border-top: 1px solid #E2E8F0;"">
                &copy; {DateTime.UtcNow.Year} HealthTrack Platform Inc. All rights reserved.<br>
                Secure Performance & Coaching Management System
            </td>
        </tr>
    </table>
</body>
</html>";
            await SendEmailAsync(toEmail, subject, html);
        }

        public async Task SendTrainerApprovedEmailAsync(string toEmail, string trainerFullName, string loginUrl)
        {
            var subject = "Congratulations! Your HealthTrack Trainer Account has been Approved!";
            var html = $@"<!DOCTYPE html>
<html lang=""en"">
<head>
    <meta charset=""UTF-8"">
    <meta name=""viewport"" content=""width=device-width, initial-scale=1.0"">
    <title>Account Approved</title>
</head>
<body style=""font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; background-color: #F8FAFC; margin: 0; padding: 30px 15px; color: #1E293B;"">
    <table align=""center"" border=""0"" cellpadding=""0"" cellspacing=""0"" width=""100%"" style=""max-width: 600px; background-color: #FFFFFF; border: 1px solid #E2E8F0; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.03);"">
        <!-- Header -->
        <tr>
            <td style=""background-color: #0F172A; padding: 28px 32px; text-align: left;"">
                <table width=""100%"" border=""0"" cellpadding=""0"" cellspacing=""0"">
                    <tr>
                        <td>
                            <div style=""display: inline-block; vertical-align: middle; background-color: #10B981; width: 36px; height: 36px; border-radius: 10px; text-align: center; line-height: 36px; color: #FFFFFF; font-weight: 800; font-size: 18px;"">H</div>
                            <span style=""color: #FFFFFF; font-size: 20px; font-weight: 800; letter-spacing: -0.5px; margin-left: 10px; vertical-align: middle;"">HealthTrack</span>
                        </td>
                        <td align=""right"">
                            <span style=""background: rgba(16, 185, 129, 0.15); border: 1px solid rgba(16, 185, 129, 0.4); color: #10B981; font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; padding: 5px 12px; border-radius: 999px;"">Approved & Active</span>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

        <!-- Main Body -->
        <tr>
            <td style=""padding: 36px 32px;"">
                <div style=""background-color: #ECFDF5; border: 1px solid #A7F3D0; border-radius: 12px; padding: 18px 20px; margin-bottom: 24px;"">
                    <table border=""0"" cellpadding=""0"" cellspacing=""0"" width=""100%"">
                        <tr>
                            <td width=""36"" valign=""top"" style=""padding-right: 12px;"">
                                <div style=""background-color: #10B981; color: #FFFFFF; border-radius: 50%; width: 28px; height: 28px; text-align: center; line-height: 28px; font-weight: bold; font-size: 14px;"">&#10003;</div>
                            </td>
                            <td>
                                <div style=""font-size: 15px; font-weight: 700; color: #065F46; margin-bottom: 2px;"">Application Approved!</div>
                                <div style=""font-size: 13px; color: #047857;"">Your coach credentials have been verified and approved by the Administrator.</div>
                            </td>
                        </tr>
                    </table>
                </div>

                <h2 style=""margin-top: 0; margin-bottom: 12px; font-size: 22px; font-weight: 800; color: #0F172A; letter-spacing: -0.5px;"">
                    You're ready to coach, {trainerFullName}!
                </h2>
                <p style=""font-size: 15px; line-height: 1.6; color: #475569; margin-bottom: 24px;"">
                    Great news! Your HealthTrack Trainer account is now fully active. You can log in right away to begin managing your clients, designing progressive training regimens, and customizing nutrition plans.
                </p>

                <!-- Call To Action Button -->
                <div style=""text-align: center; margin: 30px 0;"">
                    <a href=""{loginUrl}"" style=""display: inline-block; background-color: #10B981; color: #FFFFFF; font-size: 15px; font-weight: 700; text-decoration: none; padding: 14px 32px; border-radius: 10px; box-shadow: 0 4px 10px rgba(16, 185, 129, 0.3);"">
                        Enter Trainer Portal &rarr;
                    </a>
                </div>

                <div style=""background-color: #F8FAFC; border: 1px solid #E2E8F0; border-radius: 12px; padding: 20px; margin-top: 24px;"">
                    <div style=""font-size: 14px; font-weight: 700; color: #0F172A; margin-bottom: 10px;"">What you can do right now:</div>
                    <ul style=""margin: 0; padding-left: 20px; color: #475569; font-size: 13px; line-height: 1.7;"">
                        <li><strong>View Client Roster:</strong> Monitor assigned clients and track their current progress.</li>
                        <li><strong>Assign Workout Programs:</strong> Deploy pre-built templates or design custom multi-week routines.</li>
                        <li><strong>Meal Planning:</strong> Create customized nutrition targets and dietary guidelines.</li>
                        <li><strong>Live Schedule:</strong> View and manage upcoming consultation and training appointments.</li>
                    </ul>
                </div>
            </td>
        </tr>

        <!-- Footer -->
        <tr>
            <td style=""background-color: #F1F5F9; padding: 20px 32px; text-align: center; font-size: 12px; color: #94A3B8; border-top: 1px solid #E2E8F0;"">
                &copy; {DateTime.UtcNow.Year} HealthTrack Platform Inc. All rights reserved.<br>
                For security reasons, do not forward this email to anyone.
            </td>
        </tr>
    </table>
</body>
</html>";
            await SendEmailAsync(toEmail, subject, html);
        }
    }
}
