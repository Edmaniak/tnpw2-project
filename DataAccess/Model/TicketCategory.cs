using System.Collections.Generic;
using DataAccess.Interface;

namespace DataAccess.Model
{
    public class TicketCategory : IEntity
    {
        public virtual int Id { get; set; }
        public virtual string Title { get; set; }
        public virtual string Description { get; set; }
        public virtual bool Deletable { get; set; }
        public virtual IList<Ticket> Tickets { get; set; }
        
        public TicketCategory()
        {
            Deletable = true;
        }
    }
}