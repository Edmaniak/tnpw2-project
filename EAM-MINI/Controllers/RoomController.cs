

using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using DataAccess.Dao;
using DataAccess.Model;

namespace EAM_MINI.Controllers
{
    public class RoomController : BaseController
    {
        private RoomDao _roomDao;
        private EnvironmentDao _environmentDao;
        private List<Environment> _environments;

        public RoomController()
        {
            _roomDao = new RoomDao();
            _environmentDao = new EnvironmentDao();
            _environments = _environmentDao.GetAll().ToList();
        }

        public ActionResult Add()
        {
            ViewBag.environments = _environments;
            return View();
        }

        public ActionResult Delete(int id)
        {
            _environmentDao.Delete(_environmentDao.GetById(id));
            return Redirect(Request.UrlReferrer.ToString());
        }

        public ActionResult Detail()
        {
            return View();
        }

        public ActionResult Index()
        {
            List<Room> rooms = _roomDao.GetAll().ToList();
            return View(rooms);
        }

        public ActionResult Create(Room room, string environmentId)
        {
            if (ModelState.IsValid)
            {
                Environment environment = _environmentDao.GetById(int.Parse(environmentId));
                room.Environment = environment;
                _roomDao.Create(room);
                return RedirectToAction("Index", "Room");
            }

            return View("Add", room);
        }
    }
}