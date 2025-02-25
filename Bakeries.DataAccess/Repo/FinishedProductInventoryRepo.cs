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
    public class FinishedProductInventoryRepo(clsDbContext context) : IFinishedProductInventoryRepo
    {
        public async Task<IEnumerable<FinishedProductInventoryModel>> GetAllAsync()
        {
            return await context.FinishedProductInventorys.WhereNotDeleted().ToListAsync();
        }

        public async Task<FinishedProductInventoryModel> GetByIdAsync(int id)
        {
            return await context.FinishedProductInventorys.AsNoTracking().WhereNotDeleted().FirstOrDefaultAsync(p => p.Id == id);
        }   
        
        public async Task<FinishedProductInventoryModel> GetByProuductIdAsync(int productId)
        {
            return await context.FinishedProductInventorys.AsNoTracking().WhereNotDeleted().FirstOrDefaultAsync(p => p.ProductId == productId);
        }

        public async Task AddAsync(FinishedProductInventoryModel model)
        {
            try
            {
                await context.FinishedProductInventorys.AddAsync(model);

                await context.SaveChangesAsync();
               
              
            }
            catch
            {
                throw;
             
            }
        }

        public async Task UpdateAsync(FinishedProductInventoryModel model)
        {
            context.FinishedProductInventorys.Update(model);
        }

        public async Task DeleteAsync(int id)
        {
            var model = await context.FinishedProductInventorys.WhereNotDeleted().AsNoTracking().FirstOrDefaultAsync(p => p.Id == id);
            if (model is not null)
            {
                var purchases = await context.PurchasesFinishedProductInventorys.WhereNotDeleted().AnyAsync((p) => p.FinishedProductInventoryId == model.Id);

                if (purchases)
                    throw new Exception("المنتج مرتبط بعمليات شراء وفواتير معرفة بالنظام يجب عليك حذفها اولا");

                model.DeletedAt = DateTime.Now;

                context.Update(model);
                
            }
        }

      

      

    
    }
}
