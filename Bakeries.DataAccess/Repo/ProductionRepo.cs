using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Repo
{
    public class ProductionRepo(clsDbContext context) : IProductionRepo
    {
        public async Task<IEnumerable<ProductionModel>> GetAllAsync()
        {
            return await context.Productions.WhereNotDeleted().ToListAsync();
        }

        public async Task<ProductionModel> GetByIdAsync(int id)
        {
            return await context.Productions.AsNoTracking().WhereNotDeleted().FirstOrDefaultAsync(p => p.Id == id);

        }
        public async Task AddAsync(ProductionModel model)
        {
            try
            {
                await context.Productions.AddAsync(model);
                await context.SaveChangesAsync();
              //  return model.Id;
            }catch
            {
                throw;
             //   return 0;
            }
        }




        public async Task UpdateAsync(ProductionModel model)
        {
            context.Productions.Update(model);
         //   await context.SaveChangesAsync();
        }

        public async Task DeleteAsync(int id)
        {
            var model = await context.Productions.WhereNotDeleted().AsNoTracking().FirstOrDefaultAsync(p => p.Id == id);
            if (model is not null)
            {
                model.DeletedAt = DateTime.Now;

                context.Update(model);
               // await context.SaveChangesAsync();
            }
        }


        public async Task<ProductionModel> GetProductionWithProductAndIngredientsAsync(int productionId)
        {
            return await context.Productions.WhereNotDeleted()
                .Include(p => p.Product)
                    .ThenInclude(p => p.Ingredients)
                .FirstOrDefaultAsync(p => p.Id == productionId);
        }

        public async Task<StockModel> GetStockItemAsync(int stockId)
        {
       
                return await context.Stocks.WhereNotDeleted().FirstOrDefaultAsync(s => s.Id == stockId);
            
        }

        public async Task UpdateStockAsync(StockModel stockItems)
        {
            context.Stocks.Update(stockItems);
         //  await context.SaveChangesAsync();
        }

        public async Task SaveChangesAsync()
        {
            await context.SaveChangesAsync();
        }

        public async Task<IDbContextTransaction> BeginTransactionAsync()
        {
            return await context.Database.BeginTransactionAsync();
        }

        public async Task<IEnumerable<ProductionModel>> ProductionProcessWithAssociatedProductAsync()
        {
      

            return await context.Productions
        .WhereNotDeleted()
        .Include(pI => pI.Product)
        .ToListAsync();



        }

    }
}
