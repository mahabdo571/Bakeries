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
        [Column(TypeName = "decimal(18,4)")]
        public decimal QuantityProduced { get; set; }

        [Required]
        [Column(TypeName = "decimal(18,4)")]
        public decimal QuantityDamaged { get; set; }


        [Required]
        public int ProductId { get; set; }

        [ForeignKey(nameof(ProductId))]
        public ProductModel Product { get; set; }


        public PurchaseFinishedProductInventoryModel PFPIM { get; set; }

        public ICollection<ProductionProcessDetailModel> Details { get; set; } = new List<ProductionProcessDetailModel>();

    }
}
