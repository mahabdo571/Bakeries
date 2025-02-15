using Business.Shared.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
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
        public float AvailableQuantity { get; set; }

        [StringLength(50, ErrorMessage = "lenght max 50")]
        public UnitOfMeasure? UnitOfMeasure { get; set; }


        public int ReorderLevel { get; set; }


        public string Location { get; set; }
        public string Notes { get; set; }

        public DateTime? UpdatedAt { get; set; }

        public DateTime? CreatedAt { get; set; }


    }
}
