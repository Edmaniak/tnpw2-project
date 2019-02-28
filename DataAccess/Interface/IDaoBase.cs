using System.Collections;
using System.Collections.Generic;

namespace DataAccess.Interface
{
    public interface IDaoBase<T>
    {
        void Update(T entity);
        void Delete(T entity);
        T GetById(int id);
    }
}