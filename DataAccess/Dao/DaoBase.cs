using System;
using System.Collections.Generic;
using DataAccess.Interface;
using NHibernate;
using NHibernate.Criterion;

namespace DataAccess.Dao
{
    public class DaoBase<T> : IDaoBase<T> where T : class, IEntity
    {
        protected ISession session;

        protected DaoBase()
        {
            session = NHibernateHelper.Session;
        }

        public IList<T> GetAll()
        {
            return session.QueryOver<T>().List<T>();
        }

        public object Create(T entity)
        {
            object o;

            using (ITransaction transaction = session.BeginTransaction())
            {
                o = session.Save(entity);
                transaction.Commit();
            }

            return o;
        }

        public void Update(T entity)
        {
            using (ITransaction transaction = session.BeginTransaction())
            {
                session.Update(entity);
                transaction.Commit();
            }
        }

        public void Delete(T entity)
        {
            using (ITransaction transaction = session.BeginTransaction())
            {
                session.Delete(entity);
                transaction.Commit();
            }
        }

        public void DeleteById(int id)
        {
            T entity = GetById(id);
            if (entity != null) Delete(entity);
        }

        public T GetById(int id)
        {
            return session.CreateCriteria<T>().Add(Restrictions.Eq("Id", id)).UniqueResult<T>();
        }
    }
}