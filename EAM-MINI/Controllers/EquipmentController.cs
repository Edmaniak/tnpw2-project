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

        public ActionResult Add()
        {
            InitViewBag();
            return View();
        }

        public ActionResult Delete(int id)
        {
            _equipmentDao.Delete(_equipmentDao.GetById(id));
            return Redirect(Request.UrlReferrer.ToString());
        }

        public ActionResult Detail(int id)
        {
            Equipment equipment = _equipmentDao.GetById(id);
            InitViewBag();
            ViewBag.selectedRoom = equipment.Room.Id;
            Console.Write(equipment.Room.Id);
            return View(equipment);
        }

        public ActionResult Index()
        {
            List<Equipment> equipments = _equipmentDao.GetAll().ToList();
            return View(equipments);
        }

        public ActionResult Create(Equipment equipment, int roomId, int statusId, int categoryId)
        {
            Room room = _roomDao.GetById(roomId);
            equipment.Room = room;
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
          
        public ActionResult Statuses()
        {
            List<EquipmentStatus> statuses = _statuses;
            return View(statuses);
        }

        public ActionResult Rooms(int environmentId)
        {
            List<Room> rooms = _environmentDao.GetById(environmentId).Rooms.ToList();
            return PartialView("Rooms", rooms);
        }
        
        public ActionResult SearchRooms(string phrase)
        {
            List<Room> rooms= new List<Room>();

            if (phrase.Length > 0)
            {
                rooms = _roomDao.Search(phrase).ToList();
            }

            return PartialView("Rooms", rooms);
        }
    }
}