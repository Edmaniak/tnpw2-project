using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.ModelBinding;
using System.Web.Mvc;
using DataAccess.Dao;
using DataAccess.Model;
using NHibernate.Mapping;

namespace EAM_MINI.Controllers
{
    public class ControlController : BaseController
    {
        private ControlDao _controlDao;
        private UserDao _userDao;
        private EquipmentDao _equipmentDao;
        private ControlStatusDao _controlStatusDao;
        private ControlCategoryDao _controlCategoryDao;

        public ControlController()
        {
            _userDao = new UserDao();
            _controlDao = new ControlDao();
            _controlStatusDao = new ControlStatusDao();
            _controlCategoryDao = new ControlCategoryDao();
            _equipmentDao = new EquipmentDao();
        }

        public void InitViewBag()
        {
            ViewBag.users = _userDao.GetAll();
            List<Equipment> equipments = _equipmentDao.GetAll().ToList();
            ViewBag.equipments = equipments;
            ViewBag.statuses = _controlStatusDao.GetAll();
            ViewBag.categories = _controlCategoryDao.GetAll();
        }

        public ActionResult Add()
        {
            InitViewBag();
            return View();
        }

        public ActionResult Detail()
        {
            InitViewBag();
            return View();
        }

        public ActionResult Archiv()
        {
            return View();
        }

        public ActionResult Delete(int id)
        {
            _controlDao.DeleteById(id);
            return Redirect(Request.UrlReferrer.ToString());
        }


        public ActionResult Index()
        {
            List<Control> controls = _controlDao.GetAll().ToList();
            return View(controls);
        }

        public ActionResult Create(Control control, int userId, string equipmentId)
        {
            if (ModelState.IsValid)
            {
                if (equipmentId.Length > 0)
                {
                    Equipment equipment = _equipmentDao.GetById(int.Parse(equipmentId));
                    control.Equipment = equipment;
                }

                User user = _userDao.GetById(userId);

                control.UserToPerform = user;

                _controlDao.Create(control);
                return RedirectToAction("Index", "Control");
            }

            InitViewBag();
            return View("Add", control);
        }
    }
}