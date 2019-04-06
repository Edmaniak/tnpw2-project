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
            public const int MANAGER_ID = 3;
            public const int ADMIN_ID = 1;
            public const int MAINTAINER_ID = 2;
            public const int EMPLOYEE_ID = 4;
        }
    }
}