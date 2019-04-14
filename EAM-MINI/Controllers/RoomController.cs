using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using DataAccess.Dao;
using DataAccess.Model;

namespace EAM_MINI.Controllers
{
    [Authorize(Roles = "manager, admin")]
    public class RoomController : BaseController
    {
        private RoomDao _roomDao;
        private EnvironmentDao _environmentDao;
        private RoomCategoryDao _roomCategoryDao;
        private List<Environment> _environments;

        public RoomController()
        {
            _roomDao = new RoomDao();
            _environmentDao = new EnvironmentDao();
            _roomCategoryDao = new RoomCategoryDao();
            _environments = _environmentDao.GetAll().ToList();
        }

        public void InitViewBag()
        {
            ViewBag.environments = _environmentDao.GetAll().ToList();
            ViewBag.categories = _roomCategoryDao.GetAll().ToList();
        }

        public ActionResult Add()
        {
            InitViewBag();
            return View();
        }

        public ActionResult Delete(int id)
        {
            _roomDao.Delete(_roomDao.GetById(id));
            return RedirectToAction("Index");
        }

        public ActionResult Detail(int id)
        {
            Room room = _roomDao.GetById(id);
            ViewBag.equipments = room.Equipments;
            InitViewBag();
            return View(room);
        }

        public ActionResult Edit(Room room, int environmentId, int categoryId)
        {
            if (ModelState.IsValid)
            {
                Room roo = _roomDao.GetById(room.Id);

                roo.Code = room.Code;
                roo.Name = room.Name;
                roo.Floor = room.Floor;
                roo.Category = _roomCategoryDao.GetById(categoryId);
                roo.Purpouse = room.Purpouse;
                roo.Environment = _environmentDao.GetById(environmentId);

                _roomDao.Update(roo);
                return RedirectToAction("Index", "Room");
            }

            InitViewBag();
            return View("Detail", room);
        }

        public ActionResult Index()
        {
            List<Room> rooms = _roomDao.GetAll().ToList();
            return View(rooms);
        }

        public ActionResult Create(Room room, int environmentId, int categoryId)
        {
            room.Category = _roomCategoryDao.GetById(categoryId);
            room.Environment = _environmentDao.GetById(environmentId);
            
            if (ModelState.IsValid)
            {
                _roomDao.Create(room);
                return RedirectToAction("Index", "Room");
            }
            
            InitViewBag();
            return View("Add", room);
        }
    }
}