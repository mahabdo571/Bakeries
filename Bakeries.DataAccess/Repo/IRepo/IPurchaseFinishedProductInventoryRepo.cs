using Bakeries.DataAccess.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Repo.IRepo
{
    public interface IPurchaseFinishedProductInventoryRepo : IRepoBase<PurchaseFinishedProductInventoryModel>
    {
        Task UpdateAvailableQuantityOnFinishedProductInventoryAfterPurchase(int? finishedProductInventoryId, decimal Quantity);
        Task<IEnumerable<PurchaseFinishedProductInventoryModel>> GetAllByItemIdAsync(int itemId);

        Task<PurchaseFinishedProductInventoryModel> GetByProductionIdAsync(int productionId);
    }
}
