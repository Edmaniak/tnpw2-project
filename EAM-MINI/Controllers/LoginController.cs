using System;
using System.Security.Cryptography;
using System.Text;
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
            SHA256 sha256 = new SHA256CryptoServiceProvider();
            Byte [] hashedPassword = sha256.ComputeHash(GetBytesForPassword(password));
            password = Encoding.ASCII.GetString(hashedPassword);
            if (Membership.ValidateUser(email, password))
            {
                FormsAuthentication.SetAuthCookie(email, remember == "1");
                return RedirectToAction("Index", "Home");
            }

            TempData["error"] = "Přihlašovací údaje jsou špatné";
            return RedirectToAction("Index", "Login");
        }

        public ActionResult LogOut()
        {
            if (User.Identity.Name == null) return Refresh();
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Login");
        }
        private byte[] GetBytesForPassword(string password)
        {
            return Encoding.ASCII.GetBytes(password);
        }
    }
}