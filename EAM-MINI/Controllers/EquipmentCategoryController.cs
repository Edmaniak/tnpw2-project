using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using DataAccess.Dao;
using DataAccess.Model;

namespace EAM_MINI.Controllers
{
    public class EquipmentCategoryController : Controller
    {
        private List<EquipmentCategory> _categories;
        private EquipmentCategoryDao _equipmentCategoryDao;

        public EquipmentCategoryController()
        {
            _equipmentCategoryDao = new EquipmentCategoryDao();
            _categories = _equipmentCategoryDao.GetAll().ToList();
        }

        public ActionResult Index()
        {
            ViewBag.categories = _categories;
            return View();
        }

        public ActionResult Detail(int id)
        {
            return View();
        }

        
        public ActionResult Delete(int id)
        {
            _equipmentCategoryDao.DeleteById(id);
            return RedirectToAction("Index", "EquipmentCategory");
        }

        [HttpPost]
        public ActionResult Create(EquipmentCategory category)
        {
            if (ModelState.IsValid)
            {
                _equipmentCategoryDao.Create(category);
                return RedirectToAction("Index", "EquipmentCategory");
            }

            ViewBag.categories = _categories;
            return View("Index");
        }
    }
}