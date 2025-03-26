using Business.Shared.DTOs;

namespace bakerbalzorwebassembly.Models
{
    public class NavigationMode
    {
        public StockDTO? stockDTO { get; set; }
        public FinishedProductInventoryDTO? FPIDTO { get; set; }
        public ProductDTO? productDTO { get; set; }

        public ProductionDTO? productionDTO { get; set; }
        public OrderDTO? orderDTO { get; set; }
        public SalesDetailDTO? salesDetailDTO { get; set; }
        public DateTime dateTody { get; set; }
        public void restState()
        {
            stockDTO = null;
            productDTO = null;
            FPIDTO = null;
            productionDTO = null;
            orderDTO = null;
            salesDetailDTO = null;
            dateTody = DateTime.MinValue;
        } 

        public bool isAllRested()
        {
            return stockDTO is null &&
                FPIDTO is null && 
                productDTO is null && 
                productionDTO is null &&
                salesDetailDTO is null &&
                orderDTO is null 

                ;
        }
    }
}
