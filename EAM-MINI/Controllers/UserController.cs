using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using DataAccess.Dao;
using DataAccess.Model;

namespace EAM_MINI.Controllers
{
    public class UserController : Controller
    {
        private RoleDao _roleDao = new RoleDao();
        public ActionResult Add()
        {
            List<Role> roles = _roleDao.GetAll().ToList();

            ViewBag.roles = roles;
            return View();
        }

        public ActionResult Index()
        {
            return View();
        } 
    }
}