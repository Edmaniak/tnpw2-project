using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using DataAccess.Dao;
using DataAccess.Model;
using NHibernate.Mapping;

namespace EAM_MINI.Controllers
{
    public class EnvironmentController : BaseController
    {
        private BusinessDao _businessDao;
        private EnvironmentDao _environmentDao;
        private EnvironmentCategoryDao _environmentCategoryDao;

        public EnvironmentController()
        {
            _businessDao = new BusinessDao();
            _environmentDao = new EnvironmentDao();
            _environmentCategoryDao = new EnvironmentCategoryDao();
        }

        public void InitViewBag()
        {
            ViewBag.categories = _environmentCategoryDao.GetAll().ToList();
        }

        public ActionResult Add()
        {
            InitViewBag();
            return View();
        }

        public ActionResult Detail(int id)
        {
            Environment environment = _environmentDao.GetById(id);
            InitViewBag();
            return View(environment);
        }

        public ActionResult Index()
        {
            List<Environment> environments = _environmentDao.GetAll().ToList();
            return View(environments);
        }

        public ActionResult Delete(int id)
        {
            _environmentDao.Delete(_environmentDao.GetById(id));
            return Refresh();
        }

        [HttpPost]
        public ActionResult Edit(Environment environment, int categoryId)
        {
            if (ModelState.IsValid)
            {
                Environment env = _environmentDao.GetById(environment.Id);
                
                env.Code = environment.Code;
                env.Name = environment.Name;
                env.Address = environment.Address;
                env.Description = environment.Description;
                env.Category = _environmentCategoryDao.GetById(categoryId);
                
                _environmentDao.Update(env);
                return RedirectToAction("Index", "Environment");
            }

            return View("Add", environment);
        }

        [HttpPost]
        public ActionResult Create(Environment environment, int categoryId)
        {
            if (ModelState.IsValid)
            {
                environment.Category = _environmentCategoryDao.GetById(categoryId);
                _environmentDao.Create(environment);
                return RedirectToAction("Index", "Environment");
            }
            
            InitViewBag();
            return View("Add", environment);
        }
    }
}