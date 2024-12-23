using Bakeries.DataAccess.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Repo.IRepo
{
    public interface IStockRepo
    {
        Task<IEnumerable<StockModel>> GetAllStockAsync();
        Task<StockModel> GetStockByIdAsync(int id);
        Task<int> AddStockAsync(StockModel model);
        Task UpdateStockAsync(StockModel model);
        Task DeleteStockAsync(int id);
    }
}
