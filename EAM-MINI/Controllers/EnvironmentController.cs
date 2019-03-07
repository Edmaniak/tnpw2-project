using System.Web.Mvc;
using DataAccess.Dao;
using DataAccess.Model;

namespace EAM_MINI.Controllers
{
    public class EnvironmentController : BaseController
    {
        private EnvironmentDao _environmentDao = new EnvironmentDao();
        
        public ActionResult Add()
        {
            return View();
        }
        
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Create(Environment environment)
        {
            if (ModelState.IsValid)
            {
                _environmentDao.Create(environment);
                return RedirectToAction("Index", "Environment");
            }

            return View("Add", environment);
        }
        
    }
}