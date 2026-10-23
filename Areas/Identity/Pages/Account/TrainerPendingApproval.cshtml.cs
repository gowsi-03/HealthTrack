using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace HealthTrack.Areas.Identity.Pages.Account
{
    [AllowAnonymous]
    public class TrainerPendingApprovalModel : PageModel
    {
        public string Email { get; set; } = string.Empty;
        public string Name { get; set; } = string.Empty;
        public bool FromLogin { get; set; }

        public void OnGet(string? email = null, string? name = null, bool fromLogin = false)
        {
            Email = email ?? "your email address";
            Name = string.IsNullOrWhiteSpace(name) ? "Coach" : name;
            FromLogin = fromLogin;
        }
    }
}
