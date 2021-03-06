using System;
using System.ComponentModel.DataAnnotations;
using DataAccess.Dao;
using DataAccess.Interface;

namespace DataAccess.Model
{
    public class Ticket : IEntity
    {
        public virtual int Id { get; set; }
        [Required(ErrorMessage = "Titulek je povinný údaj.")]
        public virtual string Title { get; set; }
        public virtual string Description { get; set; }
        public virtual Equipment Equipment { get; set; }
        
        public virtual User Author { get; set; }
        public virtual User Solver { get; set; }
        public virtual User Assigned { get; set; }
        public virtual TicketStatus Status { get; set; }
        public virtual TicketCategory Category { get; set; }
        
        public virtual DateTime? Created { get; set; }
        public virtual DateTime? Deadline { get; set; }

        public Ticket()
        {
            Created = DateTime.Now;
        }
    }
}