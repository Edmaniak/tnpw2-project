using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using DataAccess.Dao;
using DataAccess.Model;

namespace EAM_MINI.Controllers
{
    [Authorize(Roles = "manager, admin")]
    public class EquipmentCategoryController : BaseController
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
        
        
        public ActionResult Delete(int id)
        {
            _equipmentCategoryDao.Delete(id);
            return RedirectToAction("Index");
        }
        
        
        public ActionResult Detail(int id)
        {
            EquipmentCategory equipmentCategory = _equipmentCategoryDao.GetById(id);
            return View(equipmentCategory);
        }
        
        [HttpPost]
        
        public ActionResult Edit(EquipmentCategory category)
        {
            if (ModelState.IsValid)
            {
                EquipmentCategory cat = _equipmentCategoryDao.GetById(category.Id);

                cat.Title = category.Title;
                cat.Description = category.Description;

                _equipmentCategoryDao.Update(cat);
                return RedirectToAction("Index", "EquipmentCategory");
            }

            ViewBag.categories = _categories;
            EquipmentCategory ec = _equipmentCategoryDao.GetById(category.Id);
            return View("Detail", ec);
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