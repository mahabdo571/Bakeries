using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Entities
{
    public class ProductionModel : clsBaseEntities
    {
        [Required]
        public float QuantityProduced { get; set; }

        [Required]
        public float QuantityDamaged { get; set; }


        [Required]
        [ForeignKey("Product")]
        public int ProductId { get; set; }
        public  ProductModel Product { get; set; }


        public ICollection<ProductionProcessDetailModel> Details { get; set; } = new List<ProductionProcessDetailModel>();

    }
}
