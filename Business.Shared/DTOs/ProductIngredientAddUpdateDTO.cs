using Business.Shared.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Shared.DTOs
{
    public record ProductIngredientAddUpdateDTO
    {

        public int Id { get; set; }

        [Required]
        public int stockId { get; set; }
        [Required]
        public int ProductId { get; set; }

        [Required]
        [Range(0, float.MaxValue)]
        public float Quantity { get; set; }

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
