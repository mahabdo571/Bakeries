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
    public class ProductionRepo(clsDbContext _dbContext) : IProductionRepo
    {
        public async Task<IEnumerable<ProductionModel>> GetAllAsync()
        {
            return await _dbContext.Production.WhereNotDeleted().ToListAsync();
        }

        public async Task<ProductionModel> GetByIdAsync(int id)
        {
            return await _dbContext.Production.WhereNotDeleted().FirstOrDefaultAsync(p => p.Id == id);

        }
        public async Task<int> AddAsync(ProductionModel model)
        {
            try
            {
                await _dbContext.Production.AddAsync(model);
                await _dbContext.SaveChangesAsync();
                return model.Id;
            }catch(Exception ex)
            {
                return 0;
            }
        }




        public async Task UpdateAsync(ProductionModel model)
        {
            _dbContext.Production.Update(model);
            await _dbContext.SaveChangesAsync();
        }

        public async Task DeleteAsync(int id)
        {
            var model = await _dbContext.Production.WhereNotDeleted().FirstOrDefaultAsync(p => p.Id == id);

            model.DeletedAt = DateTime.Now;

            _dbContext.Update(model);
            await _dbContext.SaveChangesAsync();
        }


        public async Task<ProductionModel> GetProductionWithProductAndIngredientsAsync(int productionId)
        {
            return await _dbContext.Production.WhereNotDeleted()
                .Include(p => p.Product)
                    .ThenInclude(p => p.Ingredients)
                .FirstOrDefaultAsync(p => p.Id == productionId);
        }

        public async Task<StockModel> GetStockItemAsync(int stockId)
        {
       
                return await _dbContext.Stock.WhereNotDeleted().FirstOrDefaultAsync(s => s.Id == stockId);
            
        }

        public async Task UpdateStockAsync(StockModel stockItems)
        {
            _dbContext.Stock.Update(stockItems);
           await _dbContext.SaveChangesAsync();
        }

        public async Task SaveChangesAsync()
        {
            await _dbContext.SaveChangesAsync();
        }

        public async Task<IDbContextTransaction> BeginTransactionAsync()
        {
            return await _dbContext.Database.BeginTransactionAsync();
        }

        public async Task<IEnumerable<ProductionModel>> ProductionProcessWithAssociatedProductAsync()
        {
      

            return await _dbContext.Production
        .WhereNotDeleted()
        .Include(pI => pI.Product)
        .ToListAsync();



        }

    }
}
