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
    public class PurchasesRepo(clsDbContext context) : IPurchasesRepo
    {
   

 
        public async Task AddAsync(PurchasesModel model)
        {
            if (model is null)
                throw new ArgumentNullException(nameof(model));

            if (model.Quantity <= 0)
                throw new ArgumentException("Quantity must be greater than zero.");

         
               
                await context.Purchases.AddAsync(model);
              
          
        }

        public async Task UpdateStockOnPurchase(int stockId,float Quantity)
        {
            await context.Database.ExecuteSqlRawAsync(
                "EXEC UpdateStockOnPurchase @p0, @p1",
                parameters: new object[] { stockId, Quantity }
            );
        }




        public async Task DeleteAsync(int id)
        {
            var model = await context.Purchases.WhereNotDeleted().FirstOrDefaultAsync(p=>p.Id==id);

            model.DeletedAt = DateTime.Now;

            context.Update(model);
         //  await context.SaveChangesAsync();

          

        }

        public async Task<IEnumerable<PurchasesModel>> GetAllAsync()
        {
            var model =  await context.Purchases.WhereNotDeleted().ToListAsync();

         
        return model;
        }
        public async Task<StockModel> GetStockDetailsFromItemId(int itemId, clsDbContext dbContext)
        {
       
           return await dbContext.Stock.FirstOrDefaultAsync(i => i.Id == itemId);


        

      
        }

        public async Task<PurchasesModel> GetByIdAsync(int id)
        {
           return await context.Purchases.AsNoTracking().WhereNotDeleted().FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task UpdateAsync(PurchasesModel model)
        {
            context.Update(model);
           // await context.SaveChangesAsync();
        }
    }
}
