using System.Collections.Generic;
using DataAccess.Model;
using NHibernate.Criterion;

namespace DataAccess.Dao
{
    public class EquipmentDao : DaoBase<Equipment>
    {
        public IList<Equipment> Search(string phrase)
        {
            return session.CreateCriteria<Equipment>()
                .Add(Restrictions.Like("Title", string.Format("%{0}%", phrase)))
                .List<Equipment>();
        }
    }
}