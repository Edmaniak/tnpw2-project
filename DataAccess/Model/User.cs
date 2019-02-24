using DataAccess.Interface;

namespace DataAccess.Model
{
    public class User : IEntity
    {
        public virtual int Id { get; set; }
        public virtual string Name { get; set; }
        public virtual string Surname { get; set; }
    }
}