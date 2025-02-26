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
    public class PurchaseFinishedProductInventoryDTO 
    {

        public int Id { get; set; } 
        
        [StringLength(100)] // تحديد الحد الأقصى لعدد الحروف
        public string SupplierName { get; set; } // اسم المورد

        public int? ProductionId { get; set; } = null; 




        [StringLength(50)] // تحديد الحد الأقصى لعدد الحروف
        public string SupplierInvoiceNumber { get; set; } // رقم فاتورة المورد



        
        [Column(TypeName = "decimal(18,4)")]
        public decimal Quantity { get; set; } // الكمية

        

        public UnitOfMeasure UnitOfMeasure { get; set; } // وحدة القياس
        public int UnitOfMeasureId
        {
            get => (int)UnitOfMeasure;
            set => UnitOfMeasure = (UnitOfMeasure)value;
        }

        [Column(TypeName = "decimal(18,4)")]
        public decimal UnitPrice { get; set; } // سعر الوحدة

        
        [Column(TypeName = "decimal(18,4)")]
        public decimal TotalPrice { get; set; } // إجمالي السعر      



        
        [StringLength(50)] // تحديد الحد الأقصى لعدد الحروف
        public string PaymentMethod { get; set; } // طريقة الدفع

        
        [StringLength(50)] // تحديد الحد الأقصى لعدد الحروف
        public string Status { get; set; } // حالة العملية


        public int? FinishedProductInventoryId { get; set; }

        public FinishedProductInventoryDTO? FinishedProductInventory { get;set; }

        public DateTime? CreatedAt { get; set; }

        public DateTime? UpdatedAt { get; set; }

        public string Notes { get; set; }

       
    }
}
