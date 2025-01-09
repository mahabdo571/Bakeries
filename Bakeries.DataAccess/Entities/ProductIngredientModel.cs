using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Entities
{
    public class ProductIngredientModel :clsBaseEntities
    {
        [Required]
        [ForeignKey("Product")]
        public int ProductId { get; set; }
        public virtual ProductsModel Product { get; set; }

        [Required]
        [Range(0, double.MaxValue)]
        public float Quantity { get; set; } // الكمية المطلوبة من المكون لإنتاج المنتج
   
        [Required]
        [StringLength(50)] // تحديد الحد الأقصى لعدد الحروف
        public string UnitOfMeasure { get; set; } // وحدة القياس


        [Required]
        [ForeignKey("stock")]
        public int stockId { get; set; }
        public virtual StockModel stock { get; set; }
    }
}
