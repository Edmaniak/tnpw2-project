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
    [Authorize]
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
        
        [Authorize(Roles = "admin")]
        public ActionResult Add()
        {
            ViewBag.roles = _roles;
            return View();
        }

        [Authorize(Roles = "admin")]
        public ActionResult Index()
        {
            List<User> users = _userDao.GetAll().ToList(); 
            return View(users);
        }

        [Authorize(Roles = "admin")]
        public ActionResult Delete(int id)
        {
            _userDao.Delete(_userDao.GetById(id));
            return Redirect(Request.UrlReferrer.ToString());
        }

        [Authorize(Roles = "admin")]
        public ActionResult Detail(int id)
        {
            User user = _userDao.GetById(id);
            ViewBag.roles = _roles;
            return View(user);
        }

        public ActionResult Profile(int id)
        {
            User user = _userDao.GetById(id);
            return View(user);
        }
        
        [HttpPost]
        [Authorize(Roles = "admin")]
        public ActionResult Edit(User user, string roleId)
        {
            if (ModelState.IsValid)
            {
                User us = _userDao.GetById(user.Id);
                Role role = _roleDao.GetById(int.Parse(roleId));

                us.Name = user.Name;
                us.Address = user.Address;
                us.Profession = user.Profession;
                us.Email = user.Email;
                us.Phone = user.Phone;
                us.Password = user.Password;
                us.Surname = user.Surname;
                us.Role = role;
                
                _userDao.Update(us);
                return RedirectToAction("Index", "User");
            }

            ViewBag.roles = _roles;
            return View("Detail", user);
        } 

        [HttpPost]
        [Authorize(Roles = "admin")]
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