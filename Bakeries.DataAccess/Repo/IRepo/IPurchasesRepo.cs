using Bakeries.DataAccess.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Repo.IRepo
{
    public interface IPurchasesRepo : IRepoBase<PurchaseModel>
    {
        Task<StockModel> GetStockDetailsFromItemId(int itemId, clsDbContext dbContext);
        Task UpdateStockOnPurchase(int stockId, decimal Quantity);
    }
}
