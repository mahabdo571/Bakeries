using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Entities
{
    public class PurchasesModel : clsBaseEntities
    {

        [Required]
        [StringLength(100)] // تحديد الحد الأقصى لعدد الحروف
        public string SupplierName { get; set; } // اسم المورد
      
        [Required]

        public int ItemId { get; set; } // اسم المورد

        [StringLength(50)] // تحديد الحد الأقصى لعدد الحروف
        public string SupplierInvoiceNumber { get; set; } // رقم فاتورة المورد

    

        [Required]
        public float Quantity { get; set; } // الكمية

        [Required]
        [StringLength(50)] // تحديد الحد الأقصى لعدد الحروف
        public string UnitOfMeasure { get; set; } // وحدة القياس

        [Required]
        [Range(0.01, double.MaxValue)] // التأكد من أن السعر أكبر من 0
        [Column(TypeName = "decimal(18, 3)")]
        public decimal UnitPrice { get; set; } // سعر الوحدة

        [Required]
        [Range(0.01, double.MaxValue)] // التأكد من أن السعر الإجمالي أكبر من 0
        [Column(TypeName = "decimal(18, 3)")]
        public decimal TotalPrice { get; set; } // إجمالي السعر      

 

        [Required]
        [StringLength(50)] // تحديد الحد الأقصى لعدد الحروف
        public string PaymentMethod { get; set; } // طريقة الدفع

        [Required]
        [StringLength(50)] // تحديد الحد الأقصى لعدد الحروف
        public string Status { get; set; } // حالة العملية


        [ForeignKey("ItemId")]
        public StockModel Item { get; set; } // الكلاس المرتبط

    }
}
