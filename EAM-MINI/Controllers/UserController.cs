using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using DataAccess.Dao;
using DataAccess.Model;

namespace EAM_MINI.Controllers
{
    public class UserController : BaseController
    {
        private RoleDao _roleDao;
        private UserDao _userDao;
        private List<Role> _roles;

        public UserController()
        {
            _roleDao = new RoleDao();
            _userDao = new UserDao();
            _roles = _roleDao.GetAll().ToList();
        }

        public ActionResult Add()
        {
            ViewBag.roles = _roles;
            return View();
        }

        public ActionResult Index()
        {
            List<User> users = _userDao.GetAll().ToList(); 
            return View(users);
        }

        public ActionResult Delete(int id)
        {
            _userDao.Delete(_userDao.GetById(id));
            return Redirect(Request.UrlReferrer.ToString());
        }

        public ActionResult Detail(int id)
        {
            User user = _userDao.GetById(id);
            ViewBag.roles = _roles;
            return View(user);
        }
        
        [HttpPost]
        public ActionResult Edit(User user, string roleId)
        {
            if (ModelState.IsValid)
            {
                Role role = _roleDao.GetById(int.Parse(roleId));
                user.Role = role;
                _userDao.Update(user);
                return Redirect(Request.UrlReferrer.ToString());
            }

            ViewBag.roles = _roles;
            return View("Detail", user);
        } 

        [HttpPost]
        public ActionResult Create(User user, string roleId)
        {
            if (ModelState.IsValid)
            {
                Role role = _roleDao.GetById(int.Parse(roleId));
                user.Role = role;
                _userDao.Create(user);
                return RedirectToAction("Index", "User");
            }

            ViewBag.roles = _roles;
            return View("Add", user);
        }
    }
}