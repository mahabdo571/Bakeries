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
    public class ProductIngredientRepo : IProductIngredientRepo
    {
        private readonly clsDbContext _dbContext;

        public ProductIngredientRepo(clsDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task<int> AddAsync(ProductIngredientModel model)
        {
            await _dbContext.ProductIngredient.AddAsync(model);
            await _dbContext.SaveChangesAsync();
            return model.Id;
        }

        public async Task DeleteAsync(int id)
        {
            var model = await _dbContext.ProductIngredient.WhereNotDeleted().FirstOrDefaultAsync(s => s.Id == id);


            model.DeletedAt = DateTime.Now;

            _dbContext.ProductIngredient.Update(model);
            await _dbContext.SaveChangesAsync();
        }  
        
        public async Task<bool> IsIngredientAlreadyAddedAsync(int productId,int stockId)
        {
            var exists = await _dbContext.ProductIngredient.WhereNotDeleted().AnyAsync(x => x.ProductId == productId && x.stockId == stockId);
            return exists;
           
            
          //  return await _dbContext.ProductIngredient.WhereNotDeleted().FirstOrDefaultAsync(p => p.stockId == stockId);

        }

        public async Task<IEnumerable<ProductIngredientModel>> GetAllAsync()
        {
            return await _dbContext.ProductIngredient.WhereNotDeleted().ToListAsync();
        }

        public async Task<IEnumerable<ProductIngredientModel>> GetAllByProductIdAsync(int productId)
        {
            //var model =  await _dbContext.ProductIngredient.WhereNotDeleted().Where((pI)=>pI.ProductId ==productId).ToListAsync();


            //return model;

            return await _dbContext.ProductIngredient
        .WhereNotDeleted()
        .Where(pI => pI.ProductId == productId)
        .Include(pI => pI.stock) 
        .Include(pI => pI.Product) 
        .ToListAsync();

          

        }

        public async Task<ProductIngredientModel> GetByIdAsync(int id)
        {
            return await _dbContext.ProductIngredient.WhereNotDeleted().FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task UpdateAsync(ProductIngredientModel model)
        {
            _dbContext.ProductIngredient.Update(model);
            await _dbContext.SaveChangesAsync();
        }
    }
}
