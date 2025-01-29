using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Entities
{
    public class ProductionProcessDetailModel : clsBaseEntities
    {


        [Required]
        [Column(TypeName = "decimal(18,4)")]
        public decimal Quantity { get; set; } // الكمية المطلوبة من المكون لإنتاج المنتج




        [Required]
        public int stockId { get; set; }
        public  StockModel Stock { get; set; }


        public int ProductionId { get; set; }
        public ProductionModel Production { get; set; }
    }
}
