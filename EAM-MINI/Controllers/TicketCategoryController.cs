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
    public class TicketCategoryController : BaseController
    {
        private TicketCategoryDao _ticketCategoryDao;

        public TicketCategoryController()
        {
            _ticketCategoryDao = new TicketCategoryDao();
           
        }
        public ActionResult Add()
        {
            return View();
        }

      
        public ActionResult Delete(int id)
        {
            _ticketCategoryDao.Delete(id);
            return Redirect(Request.UrlReferrer.ToString());
        }

        public ActionResult Index()
        {
            ViewBag.categories = _ticketCategoryDao.GetAll().ToList();
            return View();
        }

        [HttpPost]
        public ActionResult Create(TicketCategory category)
        {
            if (ModelState.IsValid)
            {
                _ticketCategoryDao.Create(category);
                return RedirectToAction("Index", "TicketCategory");
            }

            ViewBag.categories = _ticketCategoryDao.GetAll().ToList();
            return View("Index");
        }


          
    }
}