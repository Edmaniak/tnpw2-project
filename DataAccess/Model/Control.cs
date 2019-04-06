using System;
using System.ComponentModel.DataAnnotations;
using DataAccess.Interface;

namespace DataAccess.Model
{
    public class Control : IEntity
    {
        public virtual int Id { get; set; }
        [Required(ErrorMessage = "Titulek je povinný údaj.")]
        public virtual string Title { get; set; }
        public virtual string Description { get; set; }
        

        public virtual DateTime? DatePerformed { get; set; }
        
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd. mm. yyyy}", ApplyFormatInEditMode = true)]
        public virtual DateTime? DatePlanned { get; set; }
        public virtual User UserToPerform{ get; set; }
        public virtual User UserPerformed{ get; set; }
        public virtual User UserPlanned{ get; set; }
        
        public virtual ControlStatus Status { get; set; }
        public virtual ControlCategory Category { get; set; }
        public virtual Equipment Equipment{ get; set; }

        public virtual string EquipmentInfo
        {
            get
            {
                if (Equipment == null) return "Není specifikováno";
                return Equipment.BaseInfo;
            }
        }
        
     

    }
}