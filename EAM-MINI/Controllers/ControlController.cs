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
        private EnvironmentDao _environmentDao;
        private RoomDao _roomDao;
        private ControlStatusDao _controlStatusDao;
        private ControlCategoryDao _controlCategoryDao;

        public ControlController()
        {
            _userDao = new UserDao();
            _roomDao = new RoomDao();
            _environmentDao = new EnvironmentDao();
            _controlDao = new ControlDao();
            _controlStatusDao = new ControlStatusDao();
            _controlCategoryDao = new ControlCategoryDao();
            _equipmentDao = new EquipmentDao();
        }

        public void InitViewBag()
        {
            ViewBag.users = _userDao.GetAll();
            ViewBag.equipments = _equipmentDao.GetAll().ToList();
            ViewBag.environments = _environmentDao.GetAll().ToList();
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
            return RedirectToAction("Index");
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

        public ActionResult Create(Control control, int categoryId, int userId, int? equipmentId)
        {
            if (ModelState.IsValid)
            {
                if (equipmentId.HasValue)
                {
                    Equipment equipment = _equipmentDao.GetById(equipmentId.Value);
                    control.Equipment = equipment;
                }

                User user = _userDao.GetById(userId);
                control.UserPlanned = _userDao.GetByEmail(User.Identity.Name);
                control.UserToPerform = user;
                control.Status = _controlStatusDao.GetById(ControlStatusDao.Constants.PLANNED);
                control.Category = _controlCategoryDao.GetById(categoryId);

                _controlDao.Create(control);
                return RedirectToAction("Index", "Control");
            }

            InitViewBag();
            return View("Add", control);
        }
        
        public ActionResult SetDone(int id)
        {
            Control control = _controlDao.GetById(id);
            control.Status = _controlStatusDao.GetById(ControlStatusDao.Constants.DONE);
            control.UserPerformed = _userDao.GetByEmail(User.Identity.Name);
            _controlDao.Update(control);
            return Refresh();
        }

        public ActionResult Equipments(int? equipmentId, int? roomId)
        {
            InitViewBag();
            ViewBag.equipmentId = equipmentId;
            List<Equipment> equipments = new List<Equipment>();
            if (roomId != null)
            {
                equipments = _roomDao.GetById(roomId.Value).Equipments.ToList();
            }

            return PartialView("Equipments", equipments);
        }

        public ActionResult Rooms(int environmentId)
        {
            List<Room> rooms = _environmentDao.GetById(environmentId).Rooms.ToList();
            List<Room> roomsReturn = new List<Room>();
            foreach (Room room in rooms) roomsReturn.Add(new Room {Id = room.Id, Name = room.Name});
            return Json(roomsReturn);
        }

        public ActionResult Search(string phrase)
        {
            List<Equipment> equipments = new List<Equipment>();

            if (phrase.Length > 0)
            {
                equipments = _equipmentDao.Search(phrase).ToList();
            }

            return PartialView("Equipments", equipments);
        }
    }
}