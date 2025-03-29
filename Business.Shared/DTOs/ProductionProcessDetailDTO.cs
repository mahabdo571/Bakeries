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
    public class ProductionProcessDetailDTO
    {
        public int Id { get; set; }

        [Column(TypeName = "decimal(18,4)")]
        public decimal Quantity { get; set; }


        [Column(TypeName = "decimal(18,4)")]
        public decimal Cost { get; set; }
        public UnitOfMeasure UnitOfMeasure { get; set; }

        public string ItemName { get; set; }
        public DateTime? CreatedAt { get; set; }

        public DateTime? UpdatedAt { get; set; }

    }
}
