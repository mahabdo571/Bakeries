using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Shared.DTOs
{
    public class ProductIngredientDTO
    {
        public int Id { get; set; }
        public StockDTO stock { get; set;}
        public ProductDTO product { get; set;}


        [Required]
        [Range(0, double.MaxValue)]
        public double Quantity { get; set; }

        [Required]
        [StringLength(50)] 
        public string UnitOfMeasure { get; set; }
        public string Notes { get; set; }
    }
}
