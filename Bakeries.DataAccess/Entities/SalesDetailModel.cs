using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Entities
{
    public class SalesDetailModel : clsBaseEntities
    {

        // المفتاح الخارجي لربط التفاصيل بعملية المبيعات اليومية
        public int DailySalesId { get; set; }
        [ForeignKey("DailySalesId")]
        public virtual DailySaleModel DailySales { get; set; }

        // معرف المنتج المباع
        public int FinishedProductInventoryId { get; set; }

        // اسم المنتج (للتوثيق في حال تغيرت بيانات المنتج لاحقاً)
        public string ProductName { get; set; }

        // السعر للوحدة
        public decimal UnitPrice { get; set; }

        // الكمية المباعة من المنتج
        public int Quantity { get; set; }

        // قيمة الخصم (إن وجد)
        public decimal Discount { get; set; }

        // ممكن نحسب إجمالي قيمة المنتج بعد الخصم (خاصية محسوبة)
        [NotMapped]
        public decimal Total
        {
            get { return (UnitPrice * Quantity) - Discount; }
        }
    }
}
