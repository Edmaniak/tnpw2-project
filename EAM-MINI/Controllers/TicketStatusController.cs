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
        private List<TicketStatus> _statuses;

        public TicketStatusController()
        {
            _ticketStatusDao = new TicketStatusDao();
            _statuses = _ticketStatusDao.GetAll().ToList();
           
        }
        public ActionResult Add()
        {
            return View();
        }

        public ActionResult Delete(int id)
        {
            _ticketStatusDao.Delete(id);
            return Refresh();
        } 
        
        public ActionResult Detail(int id)
        {
            TicketStatus ticketStatuses = _ticketStatusDao.GetById(id);
            return View(ticketStatuses);
        }
        
        [HttpPost]
        public ActionResult Edit(TicketStatus category)
        {
            if (ModelState.IsValid)
            {
                TicketStatus stats = _ticketStatusDao.GetById(category.Id);

                stats.Title = category.Title;
                stats.Description = category.Description;

                _ticketStatusDao.Update(stats);
                return RedirectToAction("Index", "TicketStatus");
            }

            ViewBag.statuses = _statuses;
            return View("Index");
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