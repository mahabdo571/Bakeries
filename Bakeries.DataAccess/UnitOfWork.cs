using Bakeries.DataAccess.Repo;
using Bakeries.DataAccess.Repo.IRepo;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage;


namespace Bakeries.DataAccess
{
    public class UnitOfWork
        (clsDbContext context, IProductsRepo productRepository,
        IProductionRepo productionRepository, IStockRepo stockRepository,
        IProductIngredientRepo productIngredientRepository, IPurchasesRepo purchasesRepository,
        IProductionProcessDetailRepo productionProcessDetailRepo
        
        ) : IUnitOfWork
    {

       
        private IDbContextTransaction? _transaction;



        public IProductsRepo ProductRepository { get; } = productRepository;
        public IProductionRepo ProductionRepository { get; } = productionRepository;
        public IStockRepo StockRepository { get; } = stockRepository;
        public IProductIngredientRepo ProductIngredientRepository { get; } = productIngredientRepository;
        public IPurchasesRepo PurchasesRepository { get; } = purchasesRepository;
        public IProductionProcessDetailRepo ProductionProcessDetailRepository { get; } = productionProcessDetailRepo;

        public async Task BeginTransactionAsync()
        {
            if (context.Database.CurrentTransaction is null)  
                 _transaction = await context.Database.BeginTransactionAsync() ;


        }

        
        public async Task CommitAsync()
        {
            if (_transaction != null)
            {
                await _transaction.CommitAsync();
                await _transaction.DisposeAsync();
                _transaction = null;
            }
        }

        public async Task RollbackAsync()
        {
            if (_transaction != null)
            {
                Console.WriteLine("Rolling back transaction...");

                await _transaction.RollbackAsync();
                await _transaction.DisposeAsync();
                _transaction = null;
            }
        }

        public void Dispose()
        {
            context.Dispose();
        }

        public async Task SaveChangesAsync()
        {
            await context.SaveChangesAsync();
        }
    }

}

