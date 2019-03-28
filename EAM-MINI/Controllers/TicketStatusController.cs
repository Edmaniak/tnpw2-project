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
    public class TicketStatusController : BaseController
    {
        private TicketStatusDao _ticketStatusDao;

        public TicketStatusController()
        {
            _ticketStatusDao = new TicketStatusDao();
           
        }
        public ActionResult Add()
        {
            return View();
        }

        public ActionResult Delete(int id)
        {
            _ticketStatusDao.DeleteById(id);
            return Redirect(Request.UrlReferrer.ToString());
        } 

        public ActionResult Index()
        {
            ViewBag.statuses = _ticketStatusDao.GetAll().ToList();
            return View();
        }
        
        [HttpPost]
        public ActionResult Create(TicketStatus status)
        {
            if (ModelState.IsValid)
            {
                _ticketStatusDao.Create(status);
                return RedirectToAction("Index", "TicketStatus");
            }

            ViewBag.categories = _ticketStatusDao.GetAll().ToList();
            return View("Index");
        }

          
    }
}