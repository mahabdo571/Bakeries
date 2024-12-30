using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Shared.DTOs
{
    public class ProductDTO
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

        [Required(ErrorMessage = "is Requird")]
        [MaxLength(50)]
        public string Unit { get; set; } // مثل "قطعة" أو "كيلوغرام"
        public string Notes { get; set; } 

    }
}
