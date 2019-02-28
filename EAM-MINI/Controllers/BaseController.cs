using System.Web.Mvc;
using System.Web.Security;

namespace EAM_MINI.Controllers
{
    public abstract class BaseController : Controller
    {
        protected override ViewResult View(IView view, object model)
        {
            if (User.Identity.Name != null)
            {
                ViewBag.User = User.Identity.Name;
            }
            return base.View(view, model);
        }

        protected override ViewResult View(string viewName, string masterName, object model)
        {
            if (User.Identity.Name != null)
            {
                ViewBag.User = User.Identity.Name;
            }
            return base.View(viewName, masterName, model);
        }
    }
}