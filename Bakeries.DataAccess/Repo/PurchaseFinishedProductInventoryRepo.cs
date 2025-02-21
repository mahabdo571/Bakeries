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
    public class PurchaseFinishedProductInventoryRepo(clsDbContext context) : IPurchaseFinishedProductInventoryRepo
    {
        public async  Task AddAsync(PurchaseFinishedProductInventoryModel model)
        {
            await context.PurchasesFinishedProductInventorys.AddAsync(model);
            await context.SaveChangesAsync();
        }
        public async Task UpdateAvailableQuantityOnFinishedProductInventoryAfterPurchase(int? finishedProductInventoryId, decimal Quantity)
        {
            if(finishedProductInventoryId is null || finishedProductInventoryId <= 0)
            {
                return;
            }
            await context.Database.ExecuteSqlRawAsync(
                "EXEC UpdateFinishedProductInventoryAfterPurchase @p0, @p1",
                parameters: new object[] { finishedProductInventoryId, Quantity }
            );
        }
        public async  Task DeleteAsync(int id)
        {
            var model = await context.PurchasesFinishedProductInventorys.WhereNotDeleted().FirstOrDefaultAsync(s => s.Id == id);

            if (model is not null)
            {
 
                model.DeletedAt = DateTime.Now;

                context.PurchasesFinishedProductInventorys.Update(model);
                await context.SaveChangesAsync();
            }
            else
            {
                throw new NullReferenceException("MODEL IS NULL");
            }
        }
        public async Task<IEnumerable<PurchaseFinishedProductInventoryModel>> GetAllByItemIdAsync(int itemId)
        {
            var model = await context
                .PurchasesFinishedProductInventorys
                .WhereNotDeleted()
                .Where(p => p.FinishedProductInventoryId == itemId)
                .Include(p => p.FinishedProductInventory)
                .ToListAsync();


            return model;
        }
        public async Task<IEnumerable<PurchaseFinishedProductInventoryModel>> GetAllAsync()
        {
            return await context.PurchasesFinishedProductInventorys.WhereNotDeleted().ToListAsync();
        }

        public async Task<PurchaseFinishedProductInventoryModel> GetByIdAsync(int id)
        {
            return await context.PurchasesFinishedProductInventorys.AsNoTracking().WhereNotDeleted().FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task UpdateAsync(PurchaseFinishedProductInventoryModel model)
        {
            if (model is not null)
            {
                context.PurchasesFinishedProductInventorys.Update(model);
                await context.SaveChangesAsync();
            }
            else
            {
                throw new ArgumentNullException(nameof(model));
            }
        }
    }
}
