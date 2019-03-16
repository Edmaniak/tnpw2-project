using System;
using DataAccess.Interface;

namespace DataAccess.Model
{
    public class Control : IEntity
    {
        public virtual int Id { get; set; }
        public virtual string Title { get; set; }
        public virtual string Description { get; set; }
        public virtual DateTime DatePerformed { get; set; }
        public virtual DateTime DatePlanned { get; set; }
        public virtual User UserToPerfom{ get; set; }
        public virtual User UserPerformed{ get; set; }
        public virtual User UserPlanned{ get; set; }
        public virtual Equipment Equipment{ get; set; }
        
    }
}