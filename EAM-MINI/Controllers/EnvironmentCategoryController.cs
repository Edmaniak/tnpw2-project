using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using DataAccess.Dao;
using DataAccess.Model;

namespace EAM_MINI.Controllers
{
    public class EnvironmentCategoryController : Controller
    {
        private List<EnvironmentCategory> _categories;
        private EnvironmentCategoryDao _environmentCategoryDao;

        public EnvironmentCategoryController()
        {
            _environmentCategoryDao = new EnvironmentCategoryDao();
            _categories = _environmentCategoryDao.GetAll().ToList();
        }

        public ActionResult Index()
        {
            ViewBag.categories = _categories;
            return View();
        }
        
        public ActionResult Delete(int id)
        {
            _environmentCategoryDao.DeleteById(id);
            return RedirectToAction("Index", "EnvironmentCategory");
        }

        [HttpPost]
        public ActionResult Create(EnvironmentCategory category)
        {
            if (ModelState.IsValid)
            {
                _environmentCategoryDao.Create(category);
                return RedirectToAction("Index", "EnvironmentCategory");
            }

            ViewBag.categories = _categories;
            return View("Index");
        }
    }
}