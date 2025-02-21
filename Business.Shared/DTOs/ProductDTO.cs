using Business.Shared.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Shared.DTOs
{
    public record ProductDTO
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "is Requird")]
        [MaxLength(100,ErrorMessage ="max 100")]
        public string Name { get; set; }

        [MaxLength(500,ErrorMessage ="max 500")]
        public string Description { get; set; }

        [Required(ErrorMessage ="is Requird")]
        [Range(0, double.MaxValue)]
        public decimal Price { get; set; } // سعر المنتج النهائي


        public UnitOfMeasure UnitOfMeasure { get; set; } // وحدة القياس
        public int UnitOfMeasureId
        {
            get => (int)UnitOfMeasure;
            set => UnitOfMeasure = (UnitOfMeasure)value;
        }
        public string? Notes { get; set; } = "لا يوجد ملاحظات";
        public DateTime? CreatedAt { get; set; }

        public DateTime? UpdatedAt { get; set; }


    }
}
