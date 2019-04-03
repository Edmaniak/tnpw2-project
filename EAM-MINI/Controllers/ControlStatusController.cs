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
    public class ControlStatusController : BaseController
    {
        private ControlStatusDao _controlStatusDao;

        public ControlStatusController()
        {
            _controlStatusDao = new ControlStatusDao();
           
        }
        [Authorize(Roles = "manager, admin")]
        public ActionResult Add()
        {
            return View();
        }
        [Authorize(Roles = "manager, admin")]
        public ActionResult Delete(int id)
        {
            _controlStatusDao.Delete(id);
            return Refresh();
        } 
        [Authorize(Roles = "manager, admin")]
        public ActionResult Index()
        {
            ViewBag.statuses = _controlStatusDao.GetAll().ToList();
            return View();
        }
        [Authorize(Roles = "manager, admin")]
        public ActionResult Detail(int id)
        {
            ControlStatus controlStatus = _controlStatusDao.GetById(id);
            return View(controlStatus);
        }
        
        [Authorize(Roles = "manager, admin")]
        public ActionResult Edit(ControlStatus category)
        {
            if (ModelState.IsValid)
            {
                ControlStatus cat = _controlStatusDao.GetById(category.Id);

                cat.Title = category.Title;
                cat.Description = category.Description;

                _controlStatusDao.Update(cat);
                return RedirectToAction("Index", "ControlStatus");
            }

            ViewBag.categories = _controlStatusDao.GetAll().ToList();
            return View("Index");
        }
        
        [HttpPost]
        [Authorize(Roles = "manager, admin")]
        public ActionResult Create(ControlStatus status)
        {
            if (ModelState.IsValid)
            {
                _controlStatusDao.Create(status);
                return RedirectToAction("Index", "ControlStatus");
            }

            ViewBag.categories = _controlStatusDao.GetAll().ToList();
            return View("Index");
        }

          
    }
}