using System.ComponentModel.DataAnnotations;
using DataAccess.Interface;

namespace DataAccess.Model
{
    public class Address : IEntity
    {
        public virtual int Id { get; set; }

        [Required(ErrorMessage = "PSČ je povinný údaj")]
        [RegularExpression(@"^\d{5}(-\d{2})?$", ErrorMessage = "Špatný formát psč - správně je například 513 01")]
        public virtual int Zip { get; set; }
        public virtual string Street { get; set; }
        [Required(ErrorMessage = "Město je povinný údaj")]
        public virtual string City { get; set; }
        public virtual string State { get; set; }

    }
}