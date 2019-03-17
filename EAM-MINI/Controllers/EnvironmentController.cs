using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using DataAccess.Dao;
using DataAccess.Model;
using NHibernate.Mapping;

namespace EAM_MINI.Controllers
{
    public class EnvironmentController : BaseController
    {
        private BusinessDao _businessDao;
        private EnvironmentDao _environmentDao;

        public EnvironmentController()
        {
            _businessDao = new BusinessDao();
            _environmentDao = new EnvironmentDao();
        }

        public ActionResult Add()
        {
            return View();
        }

        public ActionResult Detail(int id)
        {
            Environment environment = _environmentDao.GetById(id);
            return View(environment);
        }

        public ActionResult Index()
        {
            List<Environment> environments = _environmentDao.GetAll().ToList();
            return View(environments);
        }

        public ActionResult Delete(int id)
        {
            _environmentDao.Delete(_environmentDao.GetById(id));
            return Redirect(Request.UrlReferrer.ToString());
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