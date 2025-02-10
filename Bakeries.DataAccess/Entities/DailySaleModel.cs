using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Entities
{
    public class DailySaleModel : clsBaseEntities
    {

        

        // إجمالي المبيعات لليوم (يمكن تحديثه بعد حساب تفاصيل المبيعات)
        public decimal TotalSales { get; set; }

        // مجموعة تفاصيل المبيعات المرتبطة بهذا اليوم
        public virtual ICollection<SalesDetailModel> SalesDetails { get; set; } = new List<SalesDetailModel>();
    }
}
}
