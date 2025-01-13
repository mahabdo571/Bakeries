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

    public class ProductsRepo(clsDbContext context) : IProductsRepo
    {

     

        public async  Task AddAsync(ProductsModel model)
        {
            await context.product.AddAsync(model);
            await context.SaveChangesAsync();
           // return model.Id;
        }

        public async Task DeleteAsync(int id)
        {
           


                var product = await context.product
                    .WhereNotDeleted()
                    .FirstOrDefaultAsync(p => p.Id == id);

                if (product == null)
                {
                    throw new KeyNotFoundException($"Product with ID {id} not found.");
                }


                var ingredients = await context.ProductIngredient
                    .WhereNotDeleted()
                    .Where(i => i.ProductId == id)
                    .ToListAsync();

          
                product.DeletedAt = DateTime.UtcNow;

                foreach (var ingredient in ingredients)
                {
                    ingredient.DeletedAt = DateTime.UtcNow;

            }


        }

        public async Task<IEnumerable<ProductsModel>> GetAllAsync()
        {
            return await context.product.WhereNotDeleted().ToListAsync();
        }

        public async Task<ProductsModel> GetByIdAsync(int id)
        {
            return await context.product.WhereNotDeleted().FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task UpdateAsync(ProductsModel model)
        {
            context.product.Update(model);
            await context.SaveChangesAsync();
        }

        public  async Task<IEnumerable<ProductsModel>> GetProductsWithComponents()
        {
            var products = await context.product
    .FromSqlRaw("EXEC GetProductsWithComponents")
    .ToListAsync();

            return products;
        }

     

    }
}
