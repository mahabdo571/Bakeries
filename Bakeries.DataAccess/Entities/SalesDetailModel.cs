using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Entities
{
    public class SalesDetailModel : clsBaseEntities
    {

        // المفتاح الخارجي لربط التفاصيل بعملية المبيعات اليومية
        public int OrderId { get; set; }
       
        public virtual OrderModel Order { get; set; }



        public string ProductName { get; set; }

        // السعر للوحدة
        public decimal UnitPrice { get; set; }

        // الكمية المباعة من المنتج
        public int Quantity { get; set; }

        // قيمة الخصم (إن وجد)
        public decimal Discount { get; set; }



        [Required]
        public int FinishedProductInventoryId { get; set; }
        public FinishedProductInventoryModel FinishedProductInventory { get; set; }
    }
}
