using System;
using System.ComponentModel.DataAnnotations;
using DataAccess.Dao;
using DataAccess.Interface;

namespace DataAccess.Model
{
    public class Equipment : IEntity
    {
        public virtual int Id { get; set; }
        public virtual string Title { get; set; }
        public virtual string Description { get; set; }
        public virtual string Code { get; set; }
        
        public virtual DateTime Purchased { get; set; }
        
        public virtual DateTime Warranty { get; set; }


        // TODO Status DB
        public virtual string Status { get; set; }
        public virtual Room Room { get; set; }


        public virtual string GenerateCode()
        {
            return "";
        }
    }
}