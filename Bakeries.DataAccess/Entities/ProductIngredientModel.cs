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
        public virtual ProductModel Product { get; set; }

        [Required]
        [Column(TypeName = "decimal(18,4)")]
        public decimal Quantity { get; set; } // الكمية المطلوبة من المكون لإنتاج المنتج
   

        public int UnitOfMeasure { get; set; } // وحدة القياس


        [Required]
        [ForeignKey("stock")]
        public int stockId { get; set; }
        public virtual StockModel stock { get; set; }
    }
}
