using System.Collections.Generic;
using DataAccess.Interface;

namespace DataAccess.Model
{
    public class TicketStatus : IEntity
    {
        public virtual string Title { get; set; }
        public virtual string Description { get; set; }
        public virtual IList<Ticket> Tickets { get; set; }
    }
}