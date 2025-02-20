using Business.Shared.DTOs;

namespace bakerbalzorwebassembly.Models
{
    public class NavigationMode
    {
        public StockDTO? stockDTO { get; set; }
        public FinishedProductInventoryDTO? FPIDTO { get; set; }

        public void restState()
        {
            stockDTO = null;
            FPIDTO = null;
        } 
    }
}
