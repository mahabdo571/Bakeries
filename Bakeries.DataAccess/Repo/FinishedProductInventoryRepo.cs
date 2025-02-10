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
                model.DeletedAt = DateTime.Now;

                context.Update(model);
                
            }
        }

      

      

    
    }
}
