using Business.Shared.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.Business.Services.IServices
{
    public interface IStockServices
    {
        Task<IEnumerable<StockDTO>> GetAllStockAsync();
        Task<StockDTO> GetStockByIdAsync(int id);
        Task<int> AddStockAsync(StockDTO model);
        Task UpdateStockAsync(StockDTO model);
        Task DeleteStockAsync(int id);
    }
}
