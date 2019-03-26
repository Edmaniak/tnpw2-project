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

        [HttpPost]
        public ActionResult Delete(int id)
        {
            return Redirect(Request.UrlReferrer.ToString());
        }

        public ActionResult Detail(int id)
        {

            return View();
        }

        public ActionResult Index()
        {
            return View();
        }

          
    }
}