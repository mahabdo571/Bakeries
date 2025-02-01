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
    public class ProductionProcessDetailRepo(clsDbContext context) : IProductionProcessDetailRepo
    {
        public async Task AddAsync(ProductionProcessDetailModel model)
        {
            await context.ProductionProcessDetails.AddAsync(model);
        }

        public async Task DeleteAsync(int id)
        {
            var model = await context.ProductionProcessDetails.WhereNotDeleted().FirstOrDefaultAsync(s => s.Id == id);

            if (model is not null)
            {
                model.DeletedAt = DateTime.Now;

                context.ProductionProcessDetails.Update(model);
                await context.SaveChangesAsync();
            }
            else
            {
                throw new NullReferenceException("MODEL IS NULL");
            }

        }

        public async Task DeleteWhereProductionIdAsync(int productionId)
        {
            var model =await  context.ProductionProcessDetails.WhereNotDeleted().AsNoTracking().Where(s => s.ProductionId == productionId).ToListAsync();

            if (model is not null)
            {
                foreach(var item in model)
                {
                    item.DeletedAt = DateTime.Now;
                }

              // await context.SaveChangesAsync();

            }
            else
            {
                throw new NullReferenceException("MODEL IS NULL");
            }

        }


        public async Task<IEnumerable<ProductionProcessDetailModel>> GetAllWhereProductionId(int productionId)
        {
            return await context.ProductionProcessDetails
                .WhereNotDeleted().AsNoTracking()
                .Include(s => s.Stock)
                .Where(s => s.ProductionId == productionId)
                .ToListAsync();


        }

        public async Task<IEnumerable<ProductionProcessDetailModel>> GetAllAsync()
        {
            return await context.ProductionProcessDetails.WhereNotDeleted().ToListAsync();
        }

        public async Task<ProductionProcessDetailModel> GetByIdAsync(int id)
        {
            return await context.ProductionProcessDetails.WhereNotDeleted().FirstOrDefaultAsync(p => p.Id == id);
        }  
        
        public async Task<ProductionProcessDetailModel> GetByStockIdAndProductionIdAsync(int productionId,int stockId)
        {
            return await context.ProductionProcessDetails.AsNoTracking().WhereNotDeleted().FirstOrDefaultAsync(p => p.ProductionId == productionId && p.stockId == stockId);
        }

        public async Task UpdateAsync(ProductionProcessDetailModel model)
        {
            if (model is not null)
            {
                context.ProductionProcessDetails.Update(model);
                await context.SaveChangesAsync();
            }
            else
            {
                throw new ArgumentNullException(nameof(model));
            }
        }
    }
}
