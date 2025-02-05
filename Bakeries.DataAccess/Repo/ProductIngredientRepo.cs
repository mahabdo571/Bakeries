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
    public class ProductIngredientRepo(clsDbContext context) : IProductIngredientRepo
    {
    

        public async Task AddAsync(ProductIngredientModel model)
        {
            await context.ProductIngredients.AddAsync(model);
            await context.SaveChangesAsync();
            //return model.Id;
        }

        public async Task DeleteAsync(int id)
        {
            var model = await context.ProductIngredients.WhereNotDeleted().FirstOrDefaultAsync(s => s.Id == id);


            model.DeletedAt = DateTime.Now;

            context.ProductIngredients.Update(model);
            await context.SaveChangesAsync();
        }  
        
        public async Task<bool> IsIngredientAlreadyAddedAsync(int productId,int stockId)
        {
            var exists = await context.ProductIngredients.WhereNotDeleted().AnyAsync(x => x.ProductId == productId && x.stockId == stockId);
            return exists;
           
            
          //  return await _dbContext.ProductIngredient.WhereNotDeleted().FirstOrDefaultAsync(p => p.stockId == stockId);

        }

        public async Task<IEnumerable<ProductIngredientModel>> GetAllAsync()
        {
            return await context.ProductIngredients.WhereNotDeleted().ToListAsync();
        }

        public async Task<IEnumerable<ProductIngredientModel>> GetAllByProductIdAsync(int productId)
        {
        

            return await context.ProductIngredients
        .WhereNotDeleted()
        .Where(pI => pI.ProductId == productId)
        .Include(pI => pI.stock) .WhereNotDeleted()
        .Include(pI => pI.Product) .WhereNotDeleted()
        .ToListAsync();

          

        }

        public async Task<ProductIngredientModel> GetByIdAsync(int id)
        {
            return await context.ProductIngredients.WhereNotDeleted().AsNoTracking().FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task UpdateAsync(ProductIngredientModel model)
        {
            context.ProductIngredients.Update(model);
            await context.SaveChangesAsync();
        }
    }
}
