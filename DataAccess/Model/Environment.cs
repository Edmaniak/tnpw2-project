using DataAccess.Interface;

namespace DataAccess.Model
{
    public class Environment : IEntity
    {
        public virtual string Title { get; set; }
        public virtual string Description { get; set; }
        public virtual Business Business { get; set; }
        public virtual Address Address { get; set; }
    }
}