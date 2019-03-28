using System;
using System.ComponentModel.DataAnnotations;
using DataAccess.Dao;
using DataAccess.Interface;

namespace DataAccess.Model
{
    public class Equipment : IEntity
    {
        public virtual int Id { get; set; }

        [Required(ErrorMessage = "Titulek (název vybavení) je povinný údaj.")]
        public virtual string Title { get; set; }

        public virtual string BaseInfo => Title + " ( " + Room.Name + " - " + Room.Environment.Name + " )";

        public virtual string Description { get; set; }

        public virtual string Code { get; set; }

        [DataType(DataType.Date)] public virtual DateTime Purchased { get; set; }

        [DataType(DataType.Date)] public virtual DateTime Warranty { get; set; }


        public virtual EquipmentCategory Category { get; set; }


        public virtual EquipmentStatus Status { get; set; }


        public virtual Room Room { get; set; }


        public virtual string GenerateCode()
        {
            return "";
        }
    }
}