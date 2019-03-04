using System.Web.Mvc;
using System.Web.Security;
using DataAccess.Dao;

namespace EAM_MINI.Controllers
{
    public abstract class BaseController : Controller
    {
        private UserDao _userDao;

        public BaseController()
        {
            _userDao = new UserDao();
        }
        protected override ViewResult View(IView view, object model)
        {
            if (User.Identity.Name != null)
            {
                ViewBag.User = _userDao.GetByEmail(User.Identity.Name);
            }
            return base.View(view, model);
        }

        protected override ViewResult View(string viewName, string masterName, object model)
        {
            if (User.Identity.Name != null)
            {
                ViewBag.User = _userDao.GetByEmail(User.Identity.Name);
            }
            return base.View(viewName, masterName, model);
        }
    }
}