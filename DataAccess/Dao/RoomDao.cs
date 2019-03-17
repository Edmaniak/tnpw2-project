using System.Collections.Generic;
using DataAccess.Model;
using NHibernate.Criterion;

namespace DataAccess.Dao
{
    public class RoomDao : DaoBase<Room>
    {
        public IList<Room> getRoomsByEnvironmentId(int environmentId)
        {
            return session.CreateCriteria<Room>().Add(Restrictions.Eq("Environment", environmentId)).List<Room>();
        } 
    }
}