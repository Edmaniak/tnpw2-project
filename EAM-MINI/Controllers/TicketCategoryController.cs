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
    [Authorize(Roles = "manager, admin")]
    public class TicketCategoryController : BaseController
    {
        private TicketCategoryDao _ticketCategoryDao;
        private List<TicketCategory> _categories;

        public TicketCategoryController()
        {
            _ticketCategoryDao = new TicketCategoryDao();
            _categories = _ticketCategoryDao.GetAll().ToList();
           
        }
        
        public ActionResult Add()
        {
            return View();
        }
        
        public ActionResult Detail(int id)
        {
            TicketCategory equipmentCategory = _ticketCategoryDao.GetById(id);
            return View(equipmentCategory);
        }
        
        [HttpPost]
        public ActionResult Edit(TicketCategory category)
        {
            if (ModelState.IsValid)
            {
                TicketCategory cat = _ticketCategoryDao.GetById(category.Id);

                cat.Title = category.Title;
                cat.Description = category.Description;

                _ticketCategoryDao.Update(cat);
                return RedirectToAction("Index", "TicketCategory");
            }

            ViewBag.categories = _categories;
            return View("Index");
        }

        public ActionResult Delete(int id)
        {
            _ticketCategoryDao.Delete(id);
            return RedirectToAction("Index");
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