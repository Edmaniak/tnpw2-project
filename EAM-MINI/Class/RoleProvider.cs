using DataAccess.Dao;
using DataAccess.Model;

namespace EAM_MINI.Class

{
    public class RoleProvider : System.Web.Security.RoleProvider
    {
        public override string ApplicationName { get; set; }
        private UserDao _userDao = new UserDao();

        public override bool IsUserInRole(string email, string roleName)
        {
            User user = _userDao.GetByEmail(email);
            
            if (user == null) return false;
            return user.Role.Title == roleName;
        }

        public override string[] GetRolesForUser(string email)
        {
            User user = _userDao.GetByEmail(email);

            return user == null ? new string[] { } : new[] {user.Role.Title};
        }

        public override void CreateRole(string roleName)
        {
            throw new System.NotImplementedException();
        }

        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            throw new System.NotImplementedException();
        }

        public override bool RoleExists(string roleName)
        {
            throw new System.NotImplementedException();
        }

        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            throw new System.NotImplementedException();
        }

        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            throw new System.NotImplementedException();
        }

        public override string[] GetUsersInRole(string roleName)
        {
            throw new System.NotImplementedException();
        }

        public override string[] GetAllRoles()
        {
            throw new System.NotImplementedException();
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            throw new System.NotImplementedException();
        }
    }
}