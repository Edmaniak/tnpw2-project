using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Mvc;
using System.Collections;
using DataAccess;
using DataAccess.Dao;
using DataAccess.Model;


namespace EAM_MINI.Controllers
{
    [Authorize]
    public class HomeController : BaseController
    {
        private ControlDao _controlDao;
        private TicketDao _ticketDao;
        public HomeController()
        {
            _controlDao = new ControlDao();
            _ticketDao = new TicketDao();
        }
        public ActionResult Index()
        {
            ViewBag.openTickets = _ticketDao.GetNotAssignedTickets();
            ViewBag.solvingTickets = _ticketDao.GetSolvingTickets();
            ViewBag.plannedControls = _controlDao.GetPlannedControls();
            return View();
        }

    }
}