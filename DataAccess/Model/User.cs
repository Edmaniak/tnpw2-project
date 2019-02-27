using DataAccess.Interface;
using System.Web;
using System.Web.Security;

namespace DataAccess.Model
{
    public class User : MembershipUser, IEntity
    {
        public virtual int Id { get; set; }
        public virtual string Name { get; set; }
        public virtual string Surname { get; set; }
        public virtual string Password { get; set; }
        public virtual Role Role { get; set; }
    }
}