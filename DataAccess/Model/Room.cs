using System;
using DataAccess.Interface;

namespace DataAccess.Model
{
    public class Room : IEntity
    {
        public virtual string Name { get; set; }
        public virtual string Purpouse { get; set; }
        public virtual string Code { get; set; }
        public virtual string Floor { get; set; }
        public virtual Environment Environment { get; set; }

        public string GenerateCode()
        {
            return "";
        }
    }
}