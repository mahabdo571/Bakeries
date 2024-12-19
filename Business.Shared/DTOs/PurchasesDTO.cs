using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Shared.DTOs
{
    public class PurchasesDTO 
    {
        public int Id { get; set; }

        

        [MaxLength]
        [Column(TypeName = "nvarchar(max)")]
        [DataType(DataType.MultilineText)]
        public string? Notes { get; set; }

        [Required]
        [StringLength(100)] // تحديد الحد الأقصى لعدد الحروف
        public string SupplierName { get; set; } // اسم المورد

        [StringLength(50)] // تحديد الحد الأقصى لعدد الحروف
        public string SupplierInvoiceNumber { get; set; } // رقم فاتورة المورد

        [Required]
        [StringLength(200)] // تحديد الحد الأقصى لعدد الحروف
        public string ItemName { get; set; } // اسم المادة

        [StringLength(500)] // تحديد الحد الأقصى لعدد الحروف
        public string ItemDescription { get; set; } // وصف المادة

        [Required]
        public int Quantity { get; set; } // الكمية

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
        [Column(TypeName = "decimal(18, 3)")]
        public decimal TotalCost { get; set; } // التكلفة الإجمالية

        [Required]
        [StringLength(50)] // تحديد الحد الأقصى لعدد الحروف
        public string PaymentMethod { get; set; } // طريقة الدفع

        [Required]
        [StringLength(50)] // تحديد الحد الأقصى لعدد الحروف
        public string Status { get; set; } // حالة العملية



    }
}
