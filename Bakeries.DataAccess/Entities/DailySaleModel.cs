using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Entities
{
    public class DailySaleModel : clsBaseEntities
    {

        public decimal TotalSales { get; set; }

        public virtual ICollection<SalesDetailModel> SalesDetails { get; set; } = new List<SalesDetailModel>();
    }
}

