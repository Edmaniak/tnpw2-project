using DataAccess.Interface;

namespace DataAccess.Model
{
    public class Ticket : IEntity
    {
        public virtual string Title { get; set; }
        public virtual string Description { get; set; }
        public virtual User Author { get; set; }
        public virtual User Solver { get; set; }
        public virtual User Assigned { get; set; }
        public virtual TicketStatus Status { get; set; }
        public virtual TicketCategory Category { get; set; }
    }
}