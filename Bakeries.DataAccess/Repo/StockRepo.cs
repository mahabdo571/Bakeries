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
    public class StockRepo(clsDbContext context) : IStockRepo
    {
    
        
        public async  Task AddAsync(StockModel model)
        {
            await context.Stocks.AddAsync(model);
            await context.SaveChangesAsync();
            //return model .Id;
        }

        public async Task DeleteAsync(int id)
        {
            var model = await context.Stocks.WhereNotDeleted().FirstOrDefaultAsync(s=>s.Id == id);

            var purchases = await context.Purchases.WhereNotDeleted().FirstOrDefaultAsync((p) => p.ItemId == model.Id);

            if (purchases is not null)
                throw new Exception("المنتج مرتبط بعمليات شراء وفواتير معرفة بالنظام يجب عليك حذفها اولا");

            model.DeletedAt  = DateTime.Now;

            context.Stocks.Update(model);
            await context.SaveChangesAsync();

        }

        public async Task<IEnumerable<StockModel>> GetAllAsync()
        {
          return  await context.Stocks.WhereNotDeleted().ToListAsync();
        }

        public async Task<StockModel> GetByIdAsync(int id)
        {
            return await context.Stocks.AsNoTracking().WhereNotDeleted().FirstOrDefaultAsync(p => p.Id == id);

        }

        public async Task UpdateAsync(StockModel model)
        {
            context.Stocks.Update(model);
        }
    }
}
