using System.Collections.Generic;
using System.Linq;
using DataAccess.Model;
using NHibernate.Criterion;

namespace DataAccess.Dao
{
    public class UserDao : DaoBase<User>
    {
        public User GetByEmailAndPassword(string email, string password)
        {
            return session.CreateCriteria<User>()
                .Add(Restrictions.Eq("Email", email))
                .Add(Restrictions.Eq("Password", password))
                .UniqueResult<User>();
        }

        public User GetByEmail(string email)
        {
            return session.CreateCriteria<User>()
                .Add(Restrictions.Eq("Email", email))
                .UniqueResult<User>();
        }

        public IList<User> GetAdmins()
        {
            return session.Query<User>().Where(c => c.Role.Id == RoleDao.Constants.ADMIN_ID).ToList();
        }

        public IList<User> GetMaintainers()
        {
            return session.Query<User>().Where(c => c.Role.Id == RoleDao.Constants.MAINTAINER_ID).ToList();
        }

        public IList<User> GetMangers()
        {
            return session.Query<User>().Where(c => c.Role.Id == RoleDao.Constants.MANAGER_ID).ToList();
        }

        public IList<User> GetManagersAndMaintainers()
        {
            return session.Query<User>().Where(c =>
                c.Role.Id == RoleDao.Constants.MANAGER_ID 
                || c.Role.Id == RoleDao.Constants.MAINTAINER_ID
                || c.Role.Id == RoleDao.Constants.ADMIN_ID).ToList();
        }


        public IList<User> GetEmployees()
        {
            return session.Query<User>().Where(c => c.Role.Id == RoleDao.Constants.EMPLOYEE_ID).ToList();
        }

        public bool IsEmailUnique(string email)
        {
            return !session.Query<User>().Any(c => c.Email == email);
        }
    }
}