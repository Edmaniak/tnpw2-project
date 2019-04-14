using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Mvc;
using System.Collections;
using System.Linq;
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
        private TicketCategoryDao _ticketCategoryDao;
        private EnvironmentDao _environmentDao;
        private UserDao _userDao;

        public HomeController()
        {
            _controlDao = new ControlDao();
            _ticketDao = new TicketDao();
            _userDao = new UserDao();
            _environmentDao = new EnvironmentDao();
            _ticketCategoryDao = new TicketCategoryDao();
        }

        public ActionResult Index()
        {
            if (User.IsInRole("maintainer"))
            {
                User user = _userDao.GetByEmail(User.Identity.Name);
                ViewBag.myTickets = _ticketDao.GetUndoneForUser(user.Id);
                ViewBag.myControls = _controlDao.GetUndoneForUser(user.Id);
                return View("Maintainer");
            }

            if (User.IsInRole("employee"))
            {
                ViewBag.categories = _ticketCategoryDao.GetAll().ToList();
                ViewBag.environments = _environmentDao.GetAll().ToList();
                return View("Employee");
            }

            ViewBag.openTickets = _ticketDao.GetNotAssignedTickets();
            ViewBag.solvingTickets = _ticketDao.GetSolvingTickets();
            ViewBag.plannedControls = _controlDao.GetPlannedControls();
            return View("Index");
        }
    }
}