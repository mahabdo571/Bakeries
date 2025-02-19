using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Business.Shared.Enums;

namespace Business.Shared.DTOs
{
    public record PurchasesDTO 
    {
        public int Id { get; set; }

        public string? ItemName { get; set; }
        public string? ItemDescription { get; set; }


        [MaxLength]
        [Column(TypeName = "nvarchar(max)")]
        [DataType(DataType.MultilineText)]
        public string? Notes { get; set; } = "لا يوجد ملاحظات";

        [Required]
        [StringLength(100)] // تحديد الحد الأقصى لعدد الحروف
        public string SupplierName { get; set; } // اسم المورد
        public int ItemId { get; set; } // اسم المورد

        [StringLength(50)] // تحديد الحد الأقصى لعدد الحروف
        public string SupplierInvoiceNumber { get; set; } // رقم فاتورة المورد
 

        [Required]
        public decimal Quantity { get; set; } // الكمية

        [Required]      
        public UnitOfMeasure UnitOfMeasure { get; set; } // وحدة القياس
        public int UnitOfMeasureId
        {
            get => (int)UnitOfMeasure;
            set => UnitOfMeasure = (UnitOfMeasure)value;
        }

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

        public DateTime? CreatedAt { get; set; }

        public DateTime? UpdatedAt { get; set; }


        public StockDTO item { get; set; }
    }
}
