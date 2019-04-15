using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using DataAccess.Dao;
using DataAccess.Model;

namespace EAM_MINI.Controllers
{
    [Authorize(Roles = "admin")]
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
            return RedirectToAction("Index");
        }

        public ActionResult Detail(int id)
        {
            User user = _userDao.GetById(id);
            ViewBag.roles = _roles;
            return View(user);
        }

        [Authorize(Roles = "admin, manager, maintainer")]
        public ActionResult Profile(int id)
        {
            User user = _userDao.GetById(id);
            return View(user);
        }
        
        [HttpPost]
        public ActionResult Edit(User user, string password, string roleId)
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
                if (password.Length > 0)
                {
                    us.Password = EncryptPassword(password);
                }
                us.Surname = user.Surname;
                us.Role = role;
                
                _userDao.Update(us);
                return RedirectToAction("Index", "User");
            }

            ViewBag.roles = _roles;
            return View("Detail", user);
        } 

        [HttpPost]
        public ActionResult Create(User user, string password, string email, string roleId)
        {
            if (ModelState.IsValid)
            {
                Role role = _roleDao.GetById(int.Parse(roleId));
                user.Role = role;
                user.Password = EncryptPassword(password);
                
                if (_userDao.IsEmailUnique(email))
                {
                    _userDao.Create(user);
                    return RedirectToAction("Index", "User");
                }

                TempData["email-error"] = "Email není jedinečný";

            }

            ViewBag.roles = _roles;
            return View("Add", user);
        }

        private string EncryptPassword(string password)
        {
            SHA256 sh256 = new SHA256CryptoServiceProvider();
            Byte[] hashedPassword = sh256.ComputeHash(GetBytesForPassword(password));
            return Encoding.ASCII.GetString(hashedPassword);
        }
        
        private byte[] GetBytesForPassword(string password)
        {
            return Encoding.ASCII.GetBytes(password);
        }
    }
}