using DataAccess.Interface;

namespace DataAccess.Model
{
    public class Address : IEntity
    {
        public virtual int Id { get; set; }
        public virtual int Zip { get; set; }
        public virtual string Street { get; set; }
        public virtual string City { get; set; }
        public virtual string State { get; set; }
        
        public virtual User User { get; set; }
    }
}