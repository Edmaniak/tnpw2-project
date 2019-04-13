using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using DataAccess.Dao;
using DataAccess.Model;
using Newtonsoft.Json;
using Environment = DataAccess.Model.Environment;

namespace EAM_MINI.Controllers
{
    [Authorize]
    public class EquipmentController : BaseController
    {
        private EnvironmentDao _environmentDao;
        private EquipmentDao _equipmentDao;
        private EquipmentStatusDao _equipmentStatusDao;
        private EquipmentCategoryDao _equipmentCategoryDao;
        private RoomDao _roomDao;
        private List<Environment> _environments;
        private List<EquipmentCategory> _categories;
        private List<EquipmentStatus> _statuses;

        public EquipmentController()
        {
            _roomDao = new RoomDao();
            _environmentDao = new EnvironmentDao();
            _equipmentDao = new EquipmentDao();
            _equipmentCategoryDao = new EquipmentCategoryDao();
            _equipmentStatusDao = new EquipmentStatusDao();
        }

        private void InitViewBag()
        {
            ViewBag.environments = _environmentDao.GetAll().ToList();
            ViewBag.statuses = _equipmentStatusDao.GetAll().ToList();
            ViewBag.categories = _equipmentCategoryDao.GetAll().ToList();
            ViewBag.rooms = _roomDao.GetAll().ToList();
        }

        [Authorize(Roles = "manager, admin")]
        public ActionResult Add()
        {
            InitViewBag();
            return View();
        }

        [Authorize(Roles = "manager, admin")]
        public ActionResult Delete(int id)
        {
            _equipmentDao.Delete(_equipmentDao.GetById(id));
            return RedirectToAction("Index");
        }

        [Authorize(Roles = "manager, admin")]
        public ActionResult Detail(int id)
        {
            Equipment equipment = _equipmentDao.GetById(id);
            InitViewBag();
            ViewBag.selectedRoom = equipment.Room.Id;
            Console.Write(equipment.Room.Id);
            return View(equipment);
        }

        public ActionResult Edit(Equipment equipment, int roomIdd, int statusId, int categoryId)
        {
            if (ModelState.IsValid)
            {
                Equipment eq = _equipmentDao.GetById(equipment.Id);
                eq.Code = equipment.Code;
                eq.Room = _roomDao.GetById(roomIdd);
                eq.Title = equipment.Title;
                eq.Status = _equipmentStatusDao.GetById(statusId);
                eq.Category = _equipmentCategoryDao.GetById(categoryId);
                eq.Warranty = equipment.Warranty;
                eq.Purchased = equipment.Purchased;
                eq.Description = equipment.Description;

                _equipmentDao.Update(eq);
                
                InitViewBag();
                return RedirectToAction("Index", "Equipment");
            }

            Equipment e = _equipmentDao.GetById(equipment.Id);
            InitViewBag();
            return View("Detail", e);
        }

        [Authorize(Roles = "manager, admin")]
        public ActionResult Index()
        {
            List<Equipment> equipments = _equipmentDao.GetAll().ToList();
            return View(equipments);
        }

        [Authorize(Roles = "manager, admin")]
        public ActionResult Create(Equipment equipment, int roomIdd, int statusId, int categoryId)
        {
            equipment.Room = _roomDao.GetById(roomIdd);
            equipment.Status = _equipmentStatusDao.GetById(statusId);
            equipment.Category = _equipmentCategoryDao.GetById(categoryId);

            if (ModelState.IsValid)
            {
                _equipmentDao.Create(equipment);
                return RedirectToAction("Index", "Equipment");
            }

            InitViewBag();
            return View("Add", equipment);
        }

        [Authorize(Roles = "manager, admin")]
        public ActionResult Statuses()
        {
            List<EquipmentStatus> statuses = _statuses;
            return View(statuses);
        }

        [Authorize(Roles = "manager, admin")]
        public ActionResult Rooms(int environmentId, int? selectedRoom)
        {
            List<Room> rooms = _environmentDao.GetById(environmentId).Rooms.ToList();
            if (selectedRoom.HasValue)
                ViewBag.roomSelected = selectedRoom;
            return PartialView("Rooms", rooms);
        }

        [Authorize(Roles = "manager, admin")]
        public ActionResult SearchRooms(string phrase)
        {
            List<Room> rooms = new List<Room>();

            if (phrase.Length > 0)
            {
                rooms = _roomDao.Search(phrase).ToList();
            }

            return PartialView("Rooms", rooms);
        }
    }
}