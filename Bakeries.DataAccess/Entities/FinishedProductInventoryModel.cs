using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Entities
{
    public class FinishedProductInventoryModel :clsBaseEntities
    {
  
        [Required]
        [MaxLength(50)]
        public string Code { get; set; }

        // اسم المنتج
        [Required]
        [MaxLength(200)]
        public string ItemName { get; set; }

        // سعر المنتج علي اكان تكلفة انتاجه ام بكم قمت بشرائه
        [Required]
        public decimal CostPrice { get; set; } 
        
        
        //  السعر الأساسي للوحدة للناس
        [Required]
        public decimal UnitPriceForPeople  { get; set; } 
        
        //  السعر الأساسي للوحدة للتجار
        [Required]
        public decimal UniPtriceForDealers  { get; set; }  
        
        //  السعر الأساسي للوحدة للموزعين
        [Required]
        public decimal UnitPriceForResellers  { get; set; }

        // قيمة الخصم على المنتج (يمكن يكون صفر إذا ما في خصم)
        public decimal Discount { get; set; }

        // قيمة الضريبة على المنتج (يمكن يكون صفر إذا ما في ضريبة)
        public decimal Tax { get; set; }

        // كمية المنتج المتوفرة للبيع
        public int AvailableQuantity { get; set; }
        public int ReorderLevel { get; set; }//الحد الأدنى للكمية قبل الحاجة لإعادة الطلب.

        public string Location { get; set; }

        public int UnitOfMeasure { get; set; }

        public int? ProductId { get; set; } //اذا فارغ اذا هو منتج لا يتم تصنيعه ويتم شرائه من الخارج اما اذا لديه قيمة فهو منتج يتم تصنيعه ومرتبط بالمنتج بقسم الانتاج
        [ForeignKey("ProductId")]
        public virtual ProductModel Product { get; set; }
  

        public ICollection<PurchaseModel> Purchases { get; set; }

        public ICollection<SalesDetailModel> Details { get; set; } = new List<SalesDetailModel>();


    }
}
