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
    [Authorize]
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

        public ActionResult Edit(Control control, int categoryId, int statusId, int? equipmentId, int userId)
        {
            if (ModelState.IsValid)
            {
                Control con = _controlDao.GetById(control.Id);
                con.Title = control.Title;
                con.Status = control.Status;
                con.Category = _controlCategoryDao.GetById(categoryId);
                con.Equipment = equipmentId == null ? null : _equipmentDao.GetById(equipmentId.Value);
                con.Description = control.Description;
                con.DatePlanned = control.DatePlanned;
                con.UserToPerform = _userDao.GetById(userId);
                con.Status = _controlStatusDao.GetById(statusId);

                _controlDao.Update(con);
                InitViewBag();
                return RedirectToAction("Index", "Control");
            }
            InitViewBag();
            Control c = _controlDao.GetById(control.Id);
            return View("Detail", c);
        }

        public ActionResult Detail(int id)
        {
            InitViewBag();
            Control control = _controlDao.GetById(id);
            return View(control);
        }

        public ActionResult Archivate(int id)
        {
            _controlDao.Archivate(id);
            return Refresh();
        }

        public ActionResult UnArchivate(int id)
        {
            _controlDao.Unarchivate(id);
            return Refresh();
        }

        public ActionResult Archive()
        {
            List<Control> controls = _controlDao.GetAllArchivated();
            return View(controls);
        }

        public ActionResult Delete(int id)
        {
            _controlDao.Delete(id);
            return Refresh();
        }

        [HttpPost]
        public ActionResult SaveStatus(int controlId, int statusId)
        {
            Control control = _controlDao.GetById(controlId);
            ControlStatus status = _controlStatusDao.GetById(statusId);
            control.Status = status;
            ViewBag.statusName = status.Title;
            ViewBag.controlName = control.Title;
            ViewBag.controlId = control.Id;
            _controlDao.Update(control);
            return PartialView("StatusChangeModal");
        }


        public ActionResult Index()
        {
            List<Control> controls = _controlDao.GetAllNotArchivated();
            InitViewBag();
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
                control.Status = _controlStatusDao.GetById(ControlStatusDao.Constants.PLANNED);

                _controlDao.Create(control);
                return RedirectToAction("Index", "Control");
            }

            InitViewBag();
            return View("Add", control);
        }
    }
}