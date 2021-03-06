using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using DataAccess.Interface;
using System.Web;
using System.Web.Security;
using NHibernate.Mapping;

namespace DataAccess.Model
{
    public class User : MembershipUser, IEntity
    {
        public virtual int Id { get; set; }

        [Required(ErrorMessage = "Jméno uživatele je povinný údaj")]
        public virtual string Name { get; set; }

        [Required(ErrorMessage = "Příjmení uživatele je povinný údaj")]
        public virtual string Surname { get; set; }

        [Required(ErrorMessage = "Email uživatele je povinný údaj")]
        [EmailAddress(ErrorMessage = "Email uživatele není ve správném formátu")]
        public virtual string Email { get; set; }

        [Required(ErrorMessage = "Heslo uživatele je povinný údaj")]
        public virtual string Password { get; set; }

        public virtual string Phone { get; set; }

        public virtual string Profession { get; set; }

        public virtual Address Address { get; set; }

        public virtual Role Role { get; set; }

        public virtual bool Deletable { get; set; }

        public virtual IList<Control> AssignedControls { get; set; }

        public virtual IList<Ticket> AssignedTickets { get; set; }

        public virtual string FullName => Name + " " + Surname;

        public virtual string UserInfo => FullName + " " + "(" + Profession + ")";

        public User()
        {
            Deletable = true;
        }
    }
}