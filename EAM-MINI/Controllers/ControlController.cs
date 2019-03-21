using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.ModelBinding;
using System.Web.Mvc;
using DataAccess.Dao;
using DataAccess.Model;

namespace EAM_MINI.Controllers
{
    public class ControlController : BaseController
    {
        private ControlDao _controlDao;
        private UserDao _userDao;
        private EquipmentDao _equipmentDao;

        public ControlController()
        {
            _userDao = new UserDao();
            _controlDao = new ControlDao();
            _equipmentDao = new EquipmentDao();
        }

        public ActionResult Add()
        {
            ViewBag.users = _userDao.GetAll();
            ViewBag.equipments = _equipmentDao.GetAll();
            return View();
        }

        public ActionResult Detail()
        {
            return View();
        }

        public ActionResult Archiv()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Delete()
        {
            return View();
        }

        public ActionResult Index()
        {
            List<Control> controls = _controlDao.GetAll().ToList();
            return View(controls);
        }

        public ActionResult Create(Control control, int equipmentId, int userId)
        {
            if (ModelState.IsValid)
            {
                Equipment equipment = _equipmentDao.GetById(equipmentId);
                User user = _userDao.GetById(userId);
                
                control.Equipment = equipment;
                control.UserToPerform = user;
                
                _controlDao.Create(control);
                return RedirectToAction("Index", "Control");
            }

            return View("Add", control);
        }
    }
}