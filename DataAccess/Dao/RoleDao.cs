using DataAccess.Model;

namespace DataAccess.Dao
{
    public class RoleDao : DaoBase<Role>
    {
        public struct Constants
        {
            public const string MANAGER = "manager";
            public const string ADMIN = "admin";
            public const string MAINTAINER = "maintainer";
            public const string EMPLOYEE = "employee";
        }
    }
}