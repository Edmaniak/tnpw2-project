using System.Collections.Generic;
using System.Linq;
using DataAccess.Model;

namespace DataAccess.Dao
{
    public class TicketDao : DaoBase<Ticket>
    {
       
        public List<Ticket> GetSolvingTickets()
        {
            return session.Query<Ticket>()
                .Where(
                    c => c.Status.Id == TicketStatusDao.Constants.SOLVING ||
                         c.Status.Id == TicketStatusDao.Constants.PLANNED
                            )
                .ToList();
        }
        
        public List<Ticket> GetNotAssignedTickets()
        {
            return session.Query<Ticket>()
                .Where(c => c.Status.Id == TicketStatusDao.Constants.RECORDED)
                .ToList();
        }
        
        public List<Ticket> GetAllNotArchivated()
        {
            return session.Query<Ticket>().Where(c => c.Status.Id != TicketStatusDao.Constants.ARCHIVATED).ToList();
        }
        
        public List<Ticket> GetAllArchivated()
        {
            return session.Query<Ticket>().Where(c => c.Status.Id == TicketStatusDao.Constants.ARCHIVATED).ToList();
        }
    }
}