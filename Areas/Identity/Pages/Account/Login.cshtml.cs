using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using HealthTrack.Models;

namespace HealthTrack.Areas.Identity.Pages.Account
{
    public class LoginModel : PageModel
    {
        private readonly SignInManager<ApplicationUser> _signInManager;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly ILogger<LoginModel> _logger;

        public LoginModel(
            SignInManager<ApplicationUser> signInManager,
            UserManager<ApplicationUser> userManager,
            ILogger<LoginModel> logger)
        {
            _signInManager = signInManager;
            _userManager = userManager;
            _logger = logger;
        }

        [BindProperty]
        public InputModel Input { get; set; } = new();

        public IList<AuthenticationScheme> ExternalLogins { get; set; } = new List<AuthenticationScheme>();

        public string? ReturnUrl { get; set; }

        [TempData]
        public string? ErrorMessage { get; set; }

        public class InputModel
        {
            [Required(ErrorMessage = "Email address is required.")]
            [EmailAddress(ErrorMessage = "Please enter a valid email address.")]
            [Display(Name = "Email address")]
            public string Email { get; set; } = string.Empty;

            [Required(ErrorMessage = "Password is required.")]
            [DataType(DataType.Password)]
            [Display(Name = "Password")]
            public string Password { get; set; } = string.Empty;

            [Display(Name = "Remember me")]
            public bool RememberMe { get; set; }
        }

        public async Task OnGetAsync(string? returnUrl = null)
        {
            if (!string.IsNullOrEmpty(ErrorMessage))
            {
                ModelState.AddModelError(string.Empty, ErrorMessage);
            }

            returnUrl ??= Url.Content("~/");

            // Clear the existing external cookie to ensure a clean login process
            await HttpContext.SignOutAsync(IdentityConstants.ExternalScheme);

            ExternalLogins = (await _signInManager.GetExternalAuthenticationSchemesAsync()).ToList();

            ReturnUrl = returnUrl;
        }

        public async Task<IActionResult> OnPostAsync(string? returnUrl = null)
        {
            returnUrl ??= Url.Content("~/");
            ExternalLogins = (await _signInManager.GetExternalAuthenticationSchemesAsync()).ToList();

            if (ModelState.IsValid)
            {
                var result = await _signInManager.PasswordSignInAsync(
                    Input.Email,
                    Input.Password,
                    Input.RememberMe,
                    lockoutOnFailure: false);

                if (result.Succeeded)
                {
                    _logger.LogInformation("User {Email} logged in successfully.", Input.Email);

                    // Check user role for strict, seamless redirection:
                    // If user is Trainer -> go to Trainer Dashboard (/Trainer)
                    // If user is Client  -> go to Client Dashboard (/Client)
                    var user = await _userManager.FindByEmailAsync(Input.Email);
                    if (user != null)
                    {
                        var roles = await _userManager.GetRolesAsync(user);
                        var isAdmin = roles.Contains("Admin") || user.Role == "Admin";
                        var isTrainer = roles.Contains("Trainer") || user.Role == "Trainer";

                        if (isAdmin)
                        {
                            if (!string.IsNullOrEmpty(returnUrl) && !returnUrl.Equals("/") && !returnUrl.Equals("~/") && returnUrl.StartsWith("/Admin", StringComparison.OrdinalIgnoreCase))
                            {
                                return LocalRedirect(returnUrl);
                            }
                            return RedirectToAction("Index", "Admin");
                        }
                        else if (isTrainer)
                        {
                            if (!string.IsNullOrEmpty(returnUrl) && !returnUrl.Equals("/") && !returnUrl.Equals("~/") && returnUrl.StartsWith("/Trainer", StringComparison.OrdinalIgnoreCase))
                            {
                                return LocalRedirect(returnUrl);
                            }
                            return RedirectToAction("Index", "Trainer");
                        }
                        else
                        {
                            if (!string.IsNullOrEmpty(returnUrl) && !returnUrl.Equals("/") && !returnUrl.Equals("~/") && returnUrl.StartsWith("/Client", StringComparison.OrdinalIgnoreCase))
                            {
                                return LocalRedirect(returnUrl);
                            }
                            return RedirectToAction("Index", "Client");
                        }
                    }

                    return LocalRedirect(returnUrl);
                }

                if (result.RequiresTwoFactor)
                {
                    return RedirectToPage("./LoginWith2fa", new { ReturnUrl = returnUrl, RememberMe = Input.RememberMe });
                }

                if (result.IsLockedOut)
                {
                    _logger.LogWarning("User account locked out.");
                    return RedirectToPage("./Lockout");
                }
                else
                {
                    ModelState.AddModelError(string.Empty, "Invalid login credentials. Please check your email and password.");
                    return Page();
                }
            }

            return Page();
        }
    }
}
