using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Repo
{
    public class StockRepo : IStockRepo
    {
        private readonly clsDbContext _dbContext;
        public StockRepo(clsDbContext dbContext) { 
        _dbContext = dbContext;
        
        }
        public async  Task<int> AddStockAsync(StockModel model)
        {
            await _dbContext.Stock.AddAsync(model);
            await _dbContext.SaveChangesAsync();
            return model .Id;
        }

        public async Task DeleteStockAsync(int id)
        {
            var model = await _dbContext.Stock.WhereNotDeleted().FirstOrDefaultAsync(s=>s.Id == id);

            var purchases = await _dbContext.Purchases.WhereNotDeleted().FirstOrDefaultAsync((p) => p.ItemId == model.Id);

            if (purchases is not null)
                throw new Exception("Item associated with purchases cannot be deleted - delete associated purchases first");

            model.DeletedAt  = DateTime.Now;

            _dbContext.Stock.Update(model);
            await _dbContext.SaveChangesAsync();

        }

        public async Task<IEnumerable<StockModel>> GetAllStockAsync()
        {
          return  await _dbContext.Stock.WhereNotDeleted().ToListAsync();
        }

        public async Task<StockModel> GetStockByIdAsync(int id)
        {
            return await _dbContext.Stock.WhereNotDeleted().FirstOrDefaultAsync(p => p.Id == id);

        }

        public async Task UpdateStockAsync(StockModel model)
        {
            _dbContext.Stock.Update(model);
            await _dbContext.SaveChangesAsync();
        }
    }
}
