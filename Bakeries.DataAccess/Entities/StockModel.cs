using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Entities
{
    public class StockModel : clsBaseEntities
    {
        [Required]
        [StringLength(255,ErrorMessage ="Lenght 255 max")]
        public string ItemName { get; set; }

        [Required]
        public int QuantityInStock { get; set; }
        [StringLength(50,ErrorMessage ="lenght max 50")]
        public string UnitOfMeasure { get; set; }


        public int ReorderLevel { get; set; }//الحد الأدنى للكمية قبل الحاجة لإعادة الطلب.


        public string Location { get; set; }

        public ICollection<PurchasesModel> Purchases { get; set; }




    }
}
