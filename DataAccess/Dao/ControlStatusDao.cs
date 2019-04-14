using System.Collections.Generic;
using DataAccess.Model;

namespace DataAccess.Dao
{
    public class ControlStatusDao : DaoBase<ControlStatus>
    {
        public struct Constants
        {
            public const int PLANNED = 2;
            public const int SOLVING = 3;
            public const int DONE = 4;
            public const int NO_CATEGORY = 1;
            public const int ARCHIVATED = 5;
        }

        
    }
}