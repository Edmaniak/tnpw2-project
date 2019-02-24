using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Mvc;
using System.Collections;
using DataAccess;
using DataAccess.Dao;
using DataAccess.Model;

namespace EAM_MINI.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            UserDao users = new UserDao();
            IList<User> us = users.GetAll();
         
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}