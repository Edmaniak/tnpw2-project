using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using DataAccess.Dao;
using DataAccess.Model;

namespace EAM_MINI.Controllers
{
    [Authorize(Roles = "manager, admin")]
    public class EquipmentStatusController : BaseController
    {
        private List<EquipmentStatus> _statuses;
        private EquipmentStatusDao _equipmentStatusDao;

        public EquipmentStatusController()
        {
            _equipmentStatusDao = new EquipmentStatusDao();
            _statuses = _equipmentStatusDao.GetAll().ToList();
        }

        
        public ActionResult Index()
        {
            ViewBag.statuses = _statuses;
            return View();
        }

       
        public ActionResult Detail(int id)
        {
            EquipmentStatus equipmentStatus = _equipmentStatusDao.GetById(id);
            return View(equipmentStatus);
        }

        [HttpPost]
        
        public ActionResult Edit(EquipmentStatus status)
        {
            if (ModelState.IsValid)
            {
                EquipmentStatus cat = _equipmentStatusDao.GetById(status.Id);

                cat.Title = status.Title;
                cat.Description = status.Description;

                _equipmentStatusDao.Update(cat);
                return RedirectToAction("Index", "EquipmentStatus");
            }

            ViewBag.categories = _statuses;
            EquipmentStatus es = _equipmentStatusDao.GetById(status.Id);
            return View("Index", es);
        }

        
        public ActionResult Delete(int id)
        {
            _equipmentStatusDao.Delete(id);
            return RedirectToAction("Index");
        }

        [HttpPost]
        
        public ActionResult Create(EquipmentStatus status)
        {
            if (ModelState.IsValid)
            {
                _equipmentStatusDao.Create(status);
                return RedirectToAction("Index", "EquipmentStatus");
            }

            ViewBag.categories = _statuses;
            return View("Index");
        }
    }
}