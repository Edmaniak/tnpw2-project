using System.Collections.Generic;
using System.Linq;
using DataAccess.Model;

namespace DataAccess.Dao
{
    public class TicketDao : DaoBase<Ticket>
    {
        private TicketStatusDao _ticketStatusDao = new TicketStatusDao();

        public List<Ticket> GetSolvingTickets()
        {
            return session.Query<Ticket>()
                .Where(
                    c => c.Status.Id == TicketStatusDao.Constants.SOLVING ||
                         c.Status.Id == TicketStatusDao.Constants.ASSIGNED
                )
                .ToList();
        }

        public void Archivate(Ticket ticket)
        {
            ticket.Status = _ticketStatusDao.GetById(TicketStatusDao.Constants.ARCHIVATED);
            Update(ticket);
        }

        public void Archivate(int id)
        {
            Ticket t = GetById(id);
            Archivate(t);
        }
        
        public void Unarchivate(Ticket ticket)
        {
            ticket.Status = _ticketStatusDao.GetById(TicketStatusDao.Constants.RECORDED);
            Update(ticket);
        }

        public void Unarchivate(int id)
        {
            Ticket t = GetById(id);
            Unarchivate(t);
        }

        public List<Ticket> GetNotAssignedTickets()
        {
            return session.Query<Ticket>()
                .Where(c => c.Status.Id == TicketStatusDao.Constants.RECORDED && c.Assigned == null)
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

        public List<Ticket> GetUndoneForUser(int userId)
        {
            return session.Query<Ticket>().Where(
                    c => c.Status.Id != TicketStatusDao.Constants.SOLVED &&
                         c.Status.Id != TicketStatusDao.Constants.ARCHIVATED &&
                         c.Assigned.Id == userId)
                .ToList();
        }
    }
}