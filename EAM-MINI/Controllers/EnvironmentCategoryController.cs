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
            _environmentCategoryDao.Delete(id);
            return RedirectToAction("Index", "EnvironmentCategory");
        }
        
        public ActionResult Detail(int id)
        {
            EnvironmentCategory environmentCategory = _environmentCategoryDao.GetById(id);
            return View(environmentCategory);
        }
        
        
        [HttpPost]
        public ActionResult Edit(EnvironmentCategory category)
        {
            if (ModelState.IsValid)
            {
                EnvironmentCategory cat = _environmentCategoryDao.GetById(category.Id);
                
                cat.Title = category.Title;
                cat.Description = category.Description;
                
                _environmentCategoryDao.Update(cat);
                return RedirectToAction("Index", "EnvironmentCategory");
            }

            ViewBag.categories = _categories;
            return View("Index");
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