using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using DataAccess.Interface;

namespace DataAccess.Model
{
    public class RoomCategory : IEntity
    {
        public virtual int Id { get; set; }
        [Required(ErrorMessage = "Titulek kategorie je povinný údaj.")]
        public virtual string Title { get; set; }
        public virtual string Description { get; set; }
        public virtual bool Deletable { get; set; }
        
        public RoomCategory()
        {
            Deletable = true;
        }
    }
}