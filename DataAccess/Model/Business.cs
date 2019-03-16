using DataAccess.Interface;

namespace DataAccess.Model
{
    public class Business : IEntity
    {
        public virtual string Name { get; set; }
        public virtual string Description { get; set; }
        public virtual Address Address { get; set; }
    }
}