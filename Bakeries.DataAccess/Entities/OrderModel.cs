using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Entities
{
    public class OrderModel : clsBaseEntities
    {

        public decimal TotalAmount { get; set; }
        public int TotalItems { get; set; }
        public int PaymentMethod { get; set; }
        public int cashierId { get; set; }
        public decimal ProfitMargin { get; set; } //الربح المحقق من البيع
        public int OrderType { get; set; } //من المحل - توصيل - موزع 



        public virtual ICollection<SalesDetailModel> SalesDetails { get; set; } = new List<SalesDetailModel>();
    }
}

