using DataAccess.Model;
using NHibernate.Criterion;

namespace DataAccess.Dao
{
    public class UserDao : DaoBase<User>
    {
        public UserDao() : base()
        {
        }

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
    }
}