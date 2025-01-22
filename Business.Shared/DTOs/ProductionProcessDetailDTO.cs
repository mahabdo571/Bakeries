using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Shared.DTOs
{
    public class ProductionProcessDetailDTO
    {
        public int Id { get; set; }

        [Required]
        [Range(0, double.MaxValue)]
        public float Quantity { get; set; }

        public int stockId { get; set; }

        public int ProductionId { get; set; }

        public string? Notes { get; set; }
    }
}
