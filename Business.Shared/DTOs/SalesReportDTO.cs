using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Shared.DTOs
{
    public class SalesReportDTO
    {
        public DateTime SaleDate { get; set; }

        public string DayName { get; set; }

        public decimal TotalSales { get; set; }
        public decimal TotalCost { get; set; }
        public decimal FinalResult { get; set; }
        public int TotalItems { get; set; }
    }
}
