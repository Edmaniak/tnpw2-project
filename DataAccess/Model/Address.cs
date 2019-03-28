using System.ComponentModel.DataAnnotations;
using DataAccess.Interface;

namespace DataAccess.Model
{
    public class Address : IEntity
    {
        public virtual int Id { get; set; }

        [Required(ErrorMessage = "PSČ je povinný údaj")]
        [Range(0, int.MaxValue, ErrorMessage = "PSČ je povinný údaj")]
        public virtual int Zip { get; set; }
        public virtual string Street { get; set; }
        [Required(ErrorMessage = "Město je povinný údaj")]
        public virtual string City { get; set; }
        public virtual string State { get; set; }

    }
}