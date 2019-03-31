using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using DataAccess.Dao;
using DataAccess.Model;

namespace EAM_MINI.Controllers
{
    public class ControlCategoryController : BaseController
    {
        private ControlCategoryDao _controlCategoryDao;

        public ControlCategoryController()
        {
            _controlCategoryDao = new ControlCategoryDao();
        }

        public ActionResult Index()
        {
            ViewBag.categories = _controlCategoryDao.GetAll().ToList();
            return View();
        }

        public ActionResult Delete(int id)
        {
            _controlCategoryDao.Delete(id);
            return Refresh();
        }

        public ActionResult Detail(int id)
        {
            ControlCategory environmentCategory = _controlCategoryDao.GetById(id);
            return View(environmentCategory);
        }


        [HttpPost]
        public ActionResult Edit(ControlCategory category)
        {
            if (ModelState.IsValid)
            {
                ControlCategory cat = _controlCategoryDao.GetById(category.Id);

                cat.Title = category.Title;
                cat.Description = category.Description;

                _controlCategoryDao.Update(cat);
                return RedirectToAction("Index", "ControlCategory");
            }

            ViewBag.categories = _controlCategoryDao.GetAll().ToList();
            return View("Index");
        }

        [HttpPost]
        public ActionResult Create(ControlCategory category)
        {
            if (ModelState.IsValid)
            {
                _controlCategoryDao.Create(category);
                return RedirectToAction("Index", "ControlCategory");
            }

            ViewBag.categories = _controlCategoryDao.GetAll().ToList();
            return View("Index");
        }
    }
}