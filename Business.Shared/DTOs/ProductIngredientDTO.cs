using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Shared.DTOs
{
    public record ProductIngredientDTO
    {



        public int Id { get; set; }



        [Required]
        [Range(0, float.MaxValue)]
        public float Quantity { get; set; }

        [Required]
        [StringLength(50)]
        public string UnitOfMeasure { get; set; }
        public string Notes { get; set; }

        public StockDTO? stock { get; set; }
        public ProductDTO? product { get; set; }

        public DateTime? CreatedAt { get; set; }

        public DateTime? UpdatedAt { get; set; }


    }
}
