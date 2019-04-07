using DataAccess.Model;

namespace DataAccess.Dao
{
    public class TicketStatusDao : DaoBase<TicketStatus>
    {
        public struct Constants
        {
            public const int SOLVING = 1;
            public const int ASSIGNED = 2;
            public const int RECORDED = 3;
            public const int SOLVED = 4;
            public const int ARCHIVATED = 5;
        }
    }
}