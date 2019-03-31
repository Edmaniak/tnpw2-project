using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using DataAccess.Dao;
using DataAccess.Model;

namespace EAM_MINI.Controllers
{
    public class EquipmentStatusController : Controller
    {
        private List<EquipmentStatus> _statuses;
        private EquipmentStatusDao _statusCategoryDao;

        public EquipmentStatusController()
        {
            _statusCategoryDao = new EquipmentStatusDao();
            _statuses = _statusCategoryDao.GetAll().ToList();
        }

        public ActionResult Index()
        {
            ViewBag.statuses = _statuses;
            return View();
        }

        public ActionResult Detail(int id)
        {
            return View();
        }

        
        public ActionResult Delete(int id)
        {
            _statusCategoryDao.Delete(id);
            return RedirectToAction("Index", "EquipmentStatus");
        }

        [HttpPost]
        public ActionResult Create(EquipmentStatus status)
        {
            if (ModelState.IsValid)
            {
                _statusCategoryDao.Create(status);
                return RedirectToAction("Index", "EquipmentStatus");
            }

            ViewBag.categories = _statuses;
            return View("Index");
        }
    }
}