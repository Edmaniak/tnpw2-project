using System.Web.Mvc;
using System.Web.Security;

namespace EAM_MINI.Controllers
{
    public class LoginController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult SignIn(string email, string password, string remember)
        {
            if (Membership.ValidateUser(email, password))
            {
                FormsAuthentication.SetAuthCookie(email, remember == "1");
                return RedirectToAction("Index", "Home");
            }

            TempData["error"] = "Login failed";
            return RedirectToAction("Index", "Login");
        }
    }
}