using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using DataAccess.Interface;

namespace DataAccess.Model
{
    public class Environment : IEntity
    {
        public virtual int Id { get; set; }
        [Required(ErrorMessage = "Titulek je povinný údaj.")]
        public virtual string Name { get; set; }
        public virtual string Description { get; set; }
        public virtual string Code { get; set; }
        public virtual Business Business { get; set; }
        public virtual EnvironmentCategory Category { get; set; }
        public virtual Address Address { get; set; }
       

        public virtual IList<Room> Rooms { get; set; }


        public void UpdateDataFrom(Environment entity)
        {
            Id = entity.Id == null ? Id : entity.Id;
            Name = entity.Name == null ? Name : entity.Name;
        }
    }
}