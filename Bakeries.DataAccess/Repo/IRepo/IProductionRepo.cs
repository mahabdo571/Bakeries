using Bakeries.DataAccess.Entities;
using Microsoft.EntityFrameworkCore.Storage;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Repo.IRepo
{
    public interface IProductionRepo : IRepoBase<ProductionModel>
    {
        Task<ProductionModel> GetProductionWithProductAndIngredientsAsync(int productionId);
        Task<StockModel> GetStockItemAsync(int stockId);
        Task UpdateStockAsync(StockModel stockItems);
        Task SaveChangesAsync();

        Task<IDbContextTransaction> BeginTransactionAsync();
    }
}
