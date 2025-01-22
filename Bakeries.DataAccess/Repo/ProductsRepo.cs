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

     

        public async  Task AddAsync(ProductModel model)
        {
            await context.Products.AddAsync(model);
            await context.SaveChangesAsync();
           // return model.Id;
        }

        public async Task DeleteAsync(int id)
        {
           


                var product = await context.Products
                    .WhereNotDeleted()
                    .FirstOrDefaultAsync(p => p.Id == id);

                if (product == null)
                {
                    throw new KeyNotFoundException($"Product with ID {id} not found.");
                }


                var ingredients = await context.ProductIngredients
                    .WhereNotDeleted()
                    .Where(i => i.ProductId == id)
                    .ToListAsync();

          
                product.DeletedAt = DateTime.UtcNow;

                foreach (var ingredient in ingredients)
                {
                    ingredient.DeletedAt = DateTime.UtcNow;

            }


        }

        public async Task<IEnumerable<ProductModel>> GetAllAsync()
        {
            return await context.Products.WhereNotDeleted().ToListAsync();
        }

        public async Task<ProductModel> GetByIdAsync(int id)
        {
            return await context.Products.WhereNotDeleted().FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task UpdateAsync(ProductModel model)
        {
            context.Products.Update(model);
            await context.SaveChangesAsync();
        }

        public  async Task<IEnumerable<ProductModel>> GetProductsWithComponents()
        {
            var products = await context.Products
    .FromSqlRaw("EXEC GetProductsWithComponents")
    .ToListAsync();

            return products;
        }

     

    }
}
