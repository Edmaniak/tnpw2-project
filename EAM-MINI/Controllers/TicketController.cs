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
    public class TicketController : BaseController
    {
        private TicketDao _ticketDao;
        private TicketCategoryDao _ticketCategoryDao;
        private TicketStatusDao _ticketStatusDao;
        private EnvironmentDao _environmentDao;
        private RoomDao _roomDao;
        private UserDao _userDao;
        private EquipmentDao _equipmentDao;
        private List<TicketCategory> _categories;

        public TicketController()
        {
            _ticketDao = new TicketDao();
            _ticketCategoryDao = new TicketCategoryDao();
            _ticketStatusDao = new TicketStatusDao();
            _userDao = new UserDao();
            _environmentDao = new EnvironmentDao();
            _equipmentDao = new EquipmentDao();
            _roomDao = new RoomDao();
        }

        public void InitViewBag()
        {
            ViewBag.categories = _ticketCategoryDao.GetAll().ToList();
            ViewBag.statuses = _ticketStatusDao.GetAll().ToList();
            ViewBag.environments = _environmentDao.GetAll().ToList();
            ViewBag.maintainers = _userDao.GetManagersAndMaintainers();
            ViewBag.equipments = _equipmentDao.GetAll().ToList();
        }

        public ActionResult Add(int? equipmentId)
        {
            InitViewBag();
            return View();
        }

        public ActionResult Archive()
        {
            List<Ticket> tickets = _ticketDao.GetAllArchivated();
            return View(tickets);
        }

        public ActionResult Archivate(int id)
        {
            Ticket ticket = _ticketDao.GetById(id);
            ticket.Status = _ticketStatusDao.GetById(TicketStatusDao.Constants.ARCHIVATED);
            _ticketDao.Update(ticket);
            return RedirectToAction("Index", "Ticket");
        }

        public ActionResult Unarchivate(int id)
        {
            Ticket ticket = _ticketDao.GetById(id);
            ticket.Status = _ticketStatusDao.GetById(TicketStatusDao.Constants.RECORDED);
            _ticketDao.Update(ticket);
            return RedirectToAction("Archive", "Ticket");
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


        public ActionResult Detail(int id)
        {
            Ticket ticket = _ticketDao.GetById(id);
            InitViewBag();
            return View(ticket);
        }

        public ActionResult Edit(Ticket ticket, int categoryId, int? assignedId, int? equipmentId)
        {
            if (ModelState.IsValid)
            {
                Ticket tic = _ticketDao.GetById(ticket.Id);
                tic.Title = ticket.Title;
                tic.Description = ticket.Description;
                tic.Category = _ticketCategoryDao.GetById(categoryId);
                tic.Deadline = ticket.Deadline;
                tic.Assigned = assignedId.HasValue ? _userDao.GetById(assignedId.Value) : null;
                tic.Equipment = equipmentId.HasValue ? _equipmentDao.GetById(equipmentId.Value) : null;
                tic.Author = _userDao.GetByEmail(User.Identity.Name);

                _ticketDao.Update(tic);
                InitViewBag();
                return RedirectToAction("Index", "Ticket");
            }

            InitViewBag();
            Ticket t = _ticketDao.GetById(ticket.Id);
            return View("Detail", t);
        }

        public ActionResult Delete(int id)
        {
            _ticketDao.Delete(id);
            return RedirectToAction("Index");
        }


        public ActionResult Index()
        {
            List<Ticket> tickets = _ticketDao.GetAllNotArchivated();
            InitViewBag();
            return View(tickets);
        }

        public ActionResult Create(Ticket ticket, int categoryId, int? assignedId, int? equipmentId)
        {
            if (ModelState.IsValid)
            {
                ticket.Category = _ticketCategoryDao.GetById(categoryId);
                ticket.Status = _ticketStatusDao.GetById(TicketStatusDao.Constants.RECORDED);
                if (assignedId.HasValue)
                {
                    ticket.Assigned = _userDao.GetById(assignedId.Value);
                    ticket.Status = _ticketStatusDao.GetById(TicketStatusDao.Constants.ASSIGNED);
                }

                if (equipmentId.HasValue)
                    ticket.Equipment = _equipmentDao.GetById(equipmentId.Value);

                ticket.Author = _userDao.GetByEmail(User.Identity.Name);
                _ticketDao.Create(ticket);
                return RedirectToAction("Index", "Ticket");
            }

            InitViewBag();
            return View("Add");
        }

        public ActionResult AssignUser(int ticketId, int userId)
        {
            Ticket ticket = _ticketDao.GetById(ticketId);
            ticket.Assigned = _userDao.GetById(userId);
            _ticketDao.Update(ticket);
            return Refresh();
        }
    }
}