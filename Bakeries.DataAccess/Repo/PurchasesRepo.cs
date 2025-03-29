using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Repo
{
    public class PurchasesRepo(clsDbContext context) : IPurchasesRepo
    {
   

 
        public async Task AddAsync(PurchaseModel model)
        {
            if (model is null)
                throw new ArgumentNullException(nameof(model));

            if (model.Quantity <= 0)
                throw new ArgumentException("Quantity must be greater than zero.");

         
               
                await context.Purchases.AddAsync(model);
              
          
        }

        public async Task UpdateStockOnPurchase(PurchaseModel model)
        {
            if(model is null ) return;


            var itemIdParam = new SqlParameter("@ItemId", model.ItemId);
            var quantityParam = new SqlParameter("@Quantity", model.Quantity);
            var lastPriceParam = new SqlParameter("@lastPriceCost", SqlDbType.Decimal)
            {
                Precision = 18,
                Scale = 5,
                Value = model.UnitPrice  // تأكد إن القيمة فعلاً 0.00006
            };

            await context.Database.ExecuteSqlRawAsync(
                "EXEC UpdateStockOnPurchase @ItemId, @Quantity, @lastPriceCost",
                itemIdParam, quantityParam, lastPriceParam
            );

            //await context.Database.ExecuteSqlRawAsync(
            //    "EXEC UpdateStockOnPurchase @p0, @p1, @p2",
            //    parameters: new object[] { model.ItemId, model.Quantity,model.UnitPrice }
            //);
        }




        public async Task DeleteAsync(int id)
        {
            var model = await context.Purchases.WhereNotDeleted().FirstOrDefaultAsync(p=>p.Id==id);

            model.DeletedAt = DateTime.Now;

            context.Update(model);
         //  await context.SaveChangesAsync();

          

        }

        public async Task<IEnumerable<PurchaseModel>> GetAllAsync()
        {
            var model =  await context.Purchases.WhereNotDeleted().ToListAsync();

         
        return model;
        }   
        
        public async Task<IEnumerable<CombinedPurchase>> GetAllCombinedPurchaseAsync()
        {
            var model =  await context.CombinedPurchases.ToListAsync();

         
        return model;
        }     
        
        public async Task<IEnumerable<PurchaseModel>> GetAllByItemIdAsync(int itemId)
        {
            var model =  await context
                .Purchases
                .WhereNotDeleted()
                .Where(p=>p.ItemId == itemId)
                .Include(p => p.Item)
                .ToListAsync();

           
        return model;
        }
        public async Task<StockModel> GetStockDetailsFromItemId(int itemId, clsDbContext dbContext)
        {
       
           return await dbContext.Stocks.FirstOrDefaultAsync(i => i.Id == itemId);


        

      
        }

        public async Task<PurchaseModel> GetByIdAsync(int id)
        {
           return await context.Purchases.AsNoTracking().WhereNotDeleted().FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task UpdateAsync(PurchaseModel model)
        {
            context.Update(model);
           // await context.SaveChangesAsync();
        }
    }
}
