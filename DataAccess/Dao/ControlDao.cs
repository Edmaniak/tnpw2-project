using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using DataAccess.Model;
using NHibernate.Criterion;

namespace DataAccess.Dao
{
    public class ControlDao : DaoBase<Control>
    {
        protected ControlStatusDao _controlStatusDao;

        public ControlDao()
        {
            _controlStatusDao = new ControlStatusDao();
        }

        public void Archivate(Control control)
        {
            control.Status = _controlStatusDao.GetById(ControlStatusDao.Constants.ARCHIVATED);
            Update(control);
        }

        public void Archivate(int id)
        {
            Control c = GetById(id);
            Archivate(c);
        }
        
        public void Unarchivate(Control control)
        {
            control.Status = _controlStatusDao.GetById(ControlStatusDao.Constants.NO_CATEGORY);
            Update(control);
        }

        public void Unarchivate(int id)
        {
            Control c = GetById(id);
            Unarchivate(c);
        }

        public List<Control> GetAllNotArchivated()
        {
            return session.Query<Control>().Where(c => c.Status.Id != ControlStatusDao.Constants.ARCHIVATED).ToList();
        }
        
        public List<Control> GetAllArchivated()
        {
            return session.Query<Control>().Where(c => c.Status.Id == ControlStatusDao.Constants.ARCHIVATED).ToList();
        }

        public List<Control> GetPlannedControls()
        {
            return session.Query<Control>().Where(c => c.Status.Id == ControlStatusDao.Constants.PLANNED).ToList();
        }
        
        public List<Control> GetUndoneForUser(int userId)
        {
            return session.Query<Control>().Where(
                    c => c.Status.Id != ControlStatusDao.Constants.DONE &&
                         c.Status.Id != ControlStatusDao.Constants.ARCHIVATED &&
                         c.UserToPerform.Id == userId)
                .ToList();
        }
        
       
        
        
    }
}