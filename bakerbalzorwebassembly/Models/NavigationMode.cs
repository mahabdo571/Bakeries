using Business.Shared.DTOs;

namespace bakerbalzorwebassembly.Models
{
    public class NavigationMode
    {
        public StockDTO? stockDTO { get; set; }

        public void restState()
        {
            stockDTO = null;
        } 
    }
}
