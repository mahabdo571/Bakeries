using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Entities
{
    public class ProductsModel :clsBaseEntities
    {
        [Required]
        [MaxLength(100)]
        public string Name { get; set; }

        [MaxLength(500)]
        public string Description { get; set; }

        [Required]
        [Range(0, double.MaxValue)]
        public decimal Price { get; set; } // سعر المنتج النهائي

        [Required]
        [MaxLength(50)]
        public string Unit { get; set; } // مثل "قطعة" أو "كيلوغرام"

        public virtual ICollection<ProductIngredientModel> Ingredients { get; set; }

    }
}
