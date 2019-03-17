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
        RoomDao _roomDao;
        private List<Environment> _environments;

        public EquipmentController(RoomDao roomDao)
        {
            _roomDao = roomDao;
            _environmentDao = new EnvironmentDao();
            _equipmentDao = new EquipmentDao();
            _environments = _environmentDao.GetAll().ToList();
        }

        public ActionResult Add()
        {
            ViewBag.environments = _environments;
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

        public ActionResult Create(Equipment equipment, int roomId)
        {
            if (ModelState.IsValid)
            {
                _equipmentDao.Create(equipment);
                Room room = _roomDao
                return RedirectToAction("Index", "Equipment");
            }

            return View("Add", equipment);
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