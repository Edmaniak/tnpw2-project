using DataAccess.Interface;

namespace DataAccess.Model
{
    public class Role : IEntity
    {
        public virtual int Id { get; set; }
        public virtual string Title { get; set; }
        public virtual string Description { get; set; }
    }
}