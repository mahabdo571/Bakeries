using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Shared.DTOs
{
    public class SalesDetailDTO
    {
        public int Id { get; set; }
        public int OrderId { get; set; }

        public string ProductName { get; set; }


        public decimal UnitPrice { get; set; }


        public int Quantity { get; set; }


        public decimal Discount { get; set; }


        [NotMapped]
        public decimal Total
        {
            get { return (UnitPrice * Quantity) - (Discount*100); }
        }


        public int FinishedProductInventoryId { get; set; }
    }
}
