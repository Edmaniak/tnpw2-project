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
            _environments = _environmentDao.GetAll().ToList();
            _categories = _equipmentCategoryDao.GetAll().ToList();
            _statuses = _equipmentStatusDao.GetAll().ToList();
        }

        private void InitiateViewBag()
        {
            ViewBag.environments = _environments;
            ViewBag.statuses = _statuses;
            ViewBag.categories = _categories;
        }

        public ActionResult Add()
        {
            InitiateViewBag();
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
            ViewBag.environments = _environments;
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

            InitiateViewBag();
            return View("Add", equipment);
        }
          
        public ActionResult Statuses()
        {
            List<EquipmentStatus> statuses = _statuses;
            return View(statuses);
        }

        public JsonResult Rooms(int environmentId)
        {
            List<Room> rooms = _environmentDao.GetById(environmentId).Rooms.ToList();
            List<Room> roomsReturn = new List<Room>();
            foreach (Room room in rooms) roomsReturn.Add(new Room {Id = room.Id, Name = room.Name});
            return Json(roomsReturn);
        }
    }
}