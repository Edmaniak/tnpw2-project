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
        public ActionResult Index()
        {
            return View();
        }

    }
}