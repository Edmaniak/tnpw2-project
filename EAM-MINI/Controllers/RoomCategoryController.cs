using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using DataAccess.Dao;
using DataAccess.Model;

namespace EAM_MINI.Controllers
{
    public class RoomCategoryController : Controller
    {
        private List<RoomCategory> _categories;
        private RoomCategoryDao _roomCategoryDao;

        public RoomCategoryController()
        {
            _roomCategoryDao = new RoomCategoryDao();
            _categories = _roomCategoryDao.GetAll().ToList();
        }

        public ActionResult Index()
        {
            ViewBag.categories = _categories;
            return View();
        }

        public ActionResult Detail(int id)
        {
            RoomCategory roomCategory = _roomCategoryDao.GetById(id);
            return View(roomCategory);
        }

        public ActionResult Delete(int id)
        {
            _roomCategoryDao.DeleteById(id);
            return RedirectToAction("Index", "RoomCategory");
        }

        [HttpPost]
        public ActionResult Edit(RoomCategory category)
        {
            if (ModelState.IsValid)
            {
                RoomCategory cat = _roomCategoryDao.GetById(category.Id);

                cat.Title = category.Title;
                cat.Description = category.Description;

                _roomCategoryDao.Update(cat);
                return RedirectToAction("Index", "RoomCategory");
            }

            ViewBag.categories = _categories;
            return View("Index");
        }

        [HttpPost]
        public ActionResult Create(RoomCategory category)
        {
            if (ModelState.IsValid)
            {
                _roomCategoryDao.Create(category);
                return RedirectToAction("Index", "RoomCategory");
            }

            ViewBag.categories = _categories;
            return View("Index");
        }
    }
}