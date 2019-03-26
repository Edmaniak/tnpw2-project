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

        public TicketController()
        {
            _ticketDao = new TicketDao();
        }

        public ActionResult Add()
        {
            return View();
        }

        public ActionResult Detail(int id)
        {
            Ticket ticket = _ticketDao.GetById(id);
            return View(ticket);
        }

        [HttpPost]
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