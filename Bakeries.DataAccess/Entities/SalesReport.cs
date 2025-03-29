using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Entities
{
    [Keyless]
    public class SalesReport
    {
        public DateTime SaleDate { get; set; }

        public string DayName { get; set; }

        public decimal TotalSales { get; set; }
        public decimal TotalCost { get; set; }
        public decimal FinalResult { get; set; }
        public int  TotalItems { get; set; }
    }
}
