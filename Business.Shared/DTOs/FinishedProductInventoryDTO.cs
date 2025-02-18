using Business.Shared.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Shared.DTOs
{
    public class FinishedProductInventoryDTO
    {
        public int Id { get; set; }

        public DateTime? CreatedAt { get; set; }

        public DateTime? UpdatedAt { get; set; }

        public string? Notes { get; set; } = "لا يوجد ملاحظات";

        [Required]
        [MaxLength(50)]
        public string? Code { get; set; } = "لا يوجد";

        // اسم المنتج
        [Required]
        [MaxLength(200)]
        public string ItemName { get; set; }

        // سعر المنتج علي اكان تكلفة انتاجه ام بكم قمت بشرائه
        [Required]
        public decimal CostPrice { get; set; }


        //  السعر الأساسي للوحدة للناس
        [Required]
        public decimal UnitPriceForPeople { get; set; }

        //  السعر الأساسي للوحدة للتجار
        [Required]
        public decimal UniPtriceForDealers { get; set; }

        //  السعر الأساسي للوحدة للموزعين
        [Required]
        public decimal UnitPriceForResellers { get; set; }

        // قيمة الخصم على المنتج (يمكن يكون صفر إذا ما في خصم)
        public decimal Discount { get; set; } = 0;

        // قيمة الضريبة على المنتج (يمكن يكون صفر إذا ما في ضريبة)
        public decimal Tax { get; set; } = 0;

        // كمية المنتج المتوفرة للبيع
        public int AvailableQuantity { get; set; }
        public int ReorderLevel { get; set; }//الحد الأدنى للكمية قبل الحاجة لإعادة الطلب.

        public string Location { get; set; }
        public bool? ProductId { get; set; }

      
    
        public UnitOfMeasure UnitOfMeasure { get; set; }
        public int UnitOfMeasureId
        {
            get => (int)UnitOfMeasure;
            set => UnitOfMeasure = (UnitOfMeasure)value;
        }
    }
}
