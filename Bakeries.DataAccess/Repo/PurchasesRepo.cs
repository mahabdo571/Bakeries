using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Repo
{
    public class PurchasesRepo : IPurchasesRepo
    {
        private readonly clsDbContext _dbContext;
   
       
        public PurchasesRepo(clsDbContext dbContext)
        {
            _dbContext = dbContext;

        }

 
        public async Task<int> AddAsync(PurchasesModel model)
        {
            if (model is null)
                throw new ArgumentNullException(nameof(model));

            if (model.Quantity <= 0)
                throw new ArgumentException("Quantity must be greater than zero.");

            using var transaction = await _dbContext.Database.BeginTransactionAsync();

            try
            {
               
                await _dbContext.Purchases.AddAsync(model);
                await _dbContext.SaveChangesAsync();

            
                await _dbContext.Database.ExecuteSqlRawAsync(
                    "EXEC UpdateStockOnPurchase @p0, @p1",
                    parameters: new object[] { model.ItemId, model.Quantity }
                );

                await transaction.CommitAsync();
                return model.Id;
            }
            catch
            {
                await transaction.RollbackAsync();
                throw;
            }
        }

        public async Task DeleteAsync(int id)
        {
            var model = await _dbContext.Purchases.WhereNotDeleted().FirstOrDefaultAsync(p=>p.Id==id);

            model.DeletedAt = DateTime.Now;

            _dbContext.Update(model);
           await _dbContext.SaveChangesAsync();

          

        }

        public async Task<IEnumerable<PurchasesModel>> GetAllAsync()
        {
            var model =  await _dbContext.Purchases.WhereNotDeleted().ToListAsync();

         
        return model;
        }
        public async Task<StockModel> GetStockDetailsFromItemId(int itemId, clsDbContext dbContext)
        {
       
           return await dbContext.Stock.FirstOrDefaultAsync(i => i.Id == itemId);


        

      
        }

        public async Task<PurchasesModel> GetByIdAsync(int id)
        {
           return await _dbContext.Purchases.WhereNotDeleted().FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task UpdateAsync(PurchasesModel model)
        {
            _dbContext.Update(model);
            await _dbContext.SaveChangesAsync();
        }
    }
}
