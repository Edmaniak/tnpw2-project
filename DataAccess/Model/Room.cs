using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using DataAccess.Interface;

namespace DataAccess.Model
{
    public class Room : IEntity
    {
        public virtual int Id { get; set; }
        [Required(ErrorMessage = "Titulek je povinný údaj.")]
        public virtual string Name { get; set; }
        public virtual string Purpouse { get; set; }
        public virtual string Code { get; set; }
        public virtual string Floor { get; set; }
        public virtual Environment Environment { get; set; }

        public virtual RoomCategory Category { get; set; }

        public virtual IList<Equipment> Equipments { get; set; }


        public virtual string GenerateCode()
        {
            return "";
        }
    }
}