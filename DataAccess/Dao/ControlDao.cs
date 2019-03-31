using System.Collections.Generic;
using System.Web.UI.WebControls;
using DataAccess.Model;

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

        public List<Control> GetAllNotArchivated()
        {
            
        }
        
        
    }
}