using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Entities
{
    public class StockModel : clsBaseEntities
    {
        [Required]
        [StringLength(255,ErrorMessage ="Lenght 255 max")]
        public string ItemName { get; set; }

        [Required]
        [Column(TypeName = "decimal(18,4)")]
        public decimal AvailableQuantity { get; set; }

        public int UnitOfMeasure { get; set; }


        public int ReorderLevel { get; set; }//الحد الأدنى للكمية قبل الحاجة لإعادة الطلب.


        public string Location { get; set; }

        public ICollection<PurchaseModel> Purchases { get; set; }

        public ICollection<ProductionProcessDetailModel> Details { get; set; } = new List<ProductionProcessDetailModel>();



    }
}
