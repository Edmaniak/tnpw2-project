using DataAccess.Model;

namespace DataAccess.Dao
{
    public class ControlStatusDao : DaoBase<ControlStatus>
    {
        public struct Constants
        {
            public static int PLANNED = 2;
            public const int NO_CATEGORY = 1;
            public const int ARCHIVATED = 5;
        }
    }
}