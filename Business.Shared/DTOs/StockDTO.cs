using Business.Shared.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Shared.DTOs
{
    public record StockDTO
    {
        public int Id { get; set; }
        [Required]
        [StringLength(255, ErrorMessage = "Lenght 255 max")]
        public string ItemName { get; set; }

        [Required]
        public decimal AvailableQuantity { get; set; }
      
        [Range(0.00001, double.MaxValue)] // التأكد من أن السعر الإجمالي أكبر من 0
        [Column(TypeName = "decimal(18,5)")]
        public decimal lastPriceCost { get; set; }

        public UnitOfMeasure UnitOfMeasure { get; set; }


        public int UnitOfMeasureId
        {
            get => (int)UnitOfMeasure;
            set => UnitOfMeasure = (UnitOfMeasure)value;
        } 

        public int ReorderLevel { get; set; }


        public string Location { get; set; }
        public string? Notes { get; set; } = "لا يوجد ملاحظات";

        public DateTime? UpdatedAt { get; set; }

        public DateTime? CreatedAt { get; set; }


    }
}
