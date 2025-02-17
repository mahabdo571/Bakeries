using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Entities
{
    public class PurchaseModel : clsBaseEntities
    {

        [Required]
        [StringLength(100)] // تحديد الحد الأقصى لعدد الحروف
        public string SupplierName { get; set; } // اسم المورد
      
  

        [StringLength(50)] // تحديد الحد الأقصى لعدد الحروف
        public string SupplierInvoiceNumber { get; set; } // رقم فاتورة المورد

    

        [Required]
        [Column(TypeName = "decimal(18,4)")]
        public decimal Quantity { get; set; } // الكمية

        [Required]
     
        public int UnitOfMeasure { get; set; } // وحدة القياس

        [Required]
        [Column(TypeName = "decimal(18,4)")]
        public decimal UnitPrice { get; set; } // سعر الوحدة

        [Required]
        [Column(TypeName = "decimal(18,4)")]
        public decimal TotalPrice { get; set; } // إجمالي السعر      

 

        [Required]
        [StringLength(50)] // تحديد الحد الأقصى لعدد الحروف
        public string PaymentMethod { get; set; } // طريقة الدفع

        [Required]
        [StringLength(50)] // تحديد الحد الأقصى لعدد الحروف
        public string Status { get; set; } // حالة العملية


 


        // قيمة لتحديد المخزن المختار: 
        // مثلاً 1 = مخزن أول، 2 = مخزن ثاني
        public int WarehouseSelection { get; set; }


        // العلاقة مع المخزن الأول (nullable لأن العملية قد تكون من المخزن الثاني)

        public int? ItemId { get; set; } //اسم العنصر بالمخزن
        [ForeignKey("ItemId")]
        public virtual StockModel Item  { get; set; }

        // العلاقة مع المخزن الثاني (nullable لأن العملية قد تكون من المخزن الأول)
        public int? FinishedProductInventoryId { get; set; }
        [ForeignKey("FinishedProductInventoryId")]
        public virtual FinishedProductInventoryModel FinishedProductInventory { get; set; }

    }
}
