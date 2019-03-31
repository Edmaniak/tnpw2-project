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
    public class TicketController : BaseController
    {
        private TicketDao _ticketDao;
        private TicketCategoryDao _ticketCategoryDao;
        private EnvironmentDao _environmentDao;
        private RoomDao _roomDao;
        private EquipmentDao _equipmentDao;
        private List<TicketCategory> _categories;

        public TicketController()
        {
            _ticketDao = new TicketDao();
            _ticketCategoryDao = new TicketCategoryDao();
            _environmentDao = new EnvironmentDao();
            _equipmentDao = new EquipmentDao();
            _roomDao = new RoomDao();
        }

        public void InitViewBag()
        {
            ViewBag.categories = _ticketCategoryDao.GetAll().ToList();
            ViewBag.environments = _environmentDao.GetAll().ToList();
        }

        public ActionResult Add(int? equipmentId)
        {
            InitViewBag();
            return View();
        }

        public ActionResult Equipments(int? environmentId, int? roomId)
        {
            InitViewBag();
            List<Equipment> equipments = new List<Equipment>();
            if (roomId != null)
            {
                equipments = _roomDao.GetById(roomId.Value).Equipments.ToList();
            }

            return PartialView("Equipments", equipments);
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
            return View(ticket);
        }

        public ActionResult Delete(int id)
        {
            return Redirect(Request.UrlReferrer.ToString());
        }


        public ActionResult Index()
        {
            List<Ticket> tickets = _ticketDao.GetAll().ToList();
            return View(tickets);
        }

        public ActionResult Create(Ticket ticket)
        {
            if (ModelState.IsValid)
            {
                _ticketDao.Create(ticket);
                return RedirectToAction("Index", "Ticket");
            }

            return View("Add");
        }
    }
}