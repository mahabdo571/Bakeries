using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Repo.IRepo
{
    public interface IUnitOfWork : IDisposable
    {
        Task BeginTransactionAsync();
        Task CommitAsync();
        Task RollbackAsync();
        Task SaveChangesAsync();
       IProductsRepo ProductRepository { get; }
       IProductionRepo ProductionRepository { get; }
       IStockRepo StockRepository { get; }
        IProductIngredientRepo ProductIngredientRepository { get; }
        IPurchasesRepo PurchasesRepository { get; }
        IProductionProcessDetailRepo ProductionProcessDetailRepository { get; }
        IFinishedProductInventoryRepo FinishedProductInventoryRepo { get; }

    }
}
