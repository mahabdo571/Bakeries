using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Entities
{
    public class ProductModel :clsBaseEntities
    {
        [Required]
        [MaxLength(100)]
        public string Name { get; set; }

        [MaxLength(500)]
        public string Description { get; set; }

        [Required]
        [Column(TypeName = "decimal(18,4)")]
        public decimal Price { get; set; } // سعر المنتج النهائي

 
        public int UnitOfMeasure { get; set; }
        public int? FinishedProductInventoryId { get; set; } //اذا فارغ اذا هو منتج لا يتم تصنيعه ويتم شرائه من الخارج اما اذا لديه قيمة فهو منتج يتم تصنيعه ومرتبط بالمنتج بقسم الانتاج
        [ForeignKey("FinishedProductInventoryId")]
        public virtual FinishedProductInventoryModel FinishedProductInventory { get; set; }
        public virtual ICollection<ProductIngredientModel> Ingredients { get; set; }
        public virtual ICollection<ProductionModel> Production { get; set; }

       


    }
}
