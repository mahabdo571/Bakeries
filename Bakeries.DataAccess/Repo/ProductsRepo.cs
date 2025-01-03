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

    public class ProductsRepo : IProductsRepo
    {

        private readonly clsDbContext _dbContext;

        public ProductsRepo(clsDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async  Task<int> AddAsync(ProductsModel model)
        {
            await _dbContext.product.AddAsync(model);
            await _dbContext.SaveChangesAsync();
            return model.Id;
        }

        public async Task DeleteAsync(int id)
        {
            // Start a database transaction
            using var transaction = await _dbContext.Database.BeginTransactionAsync();

            try
            {
                // Fetch the product to be deleted
                var product = await _dbContext.product
                    .WhereNotDeleted()
                    .FirstOrDefaultAsync(p => p.Id == id);

                if (product == null)
                {
                    throw new KeyNotFoundException($"Product with ID {id} not found.");
                }

                // Fetch all related ingredients
                var ingredients = await _dbContext.ProductIngredient
                    .WhereNotDeleted()
                    .Where(i => i.ProductId == id)
                    .ToListAsync();

                // Mark the product as deleted
                product.DeletedAt = DateTime.UtcNow;

                // Mark all related ingredients as deleted
                foreach (var ingredient in ingredients)
                {
                    ingredient.DeletedAt = DateTime.UtcNow;
                }

                // Save changes in a single transaction
                await _dbContext.SaveChangesAsync();

                // Commit the transaction
                await transaction.CommitAsync();
            }
            catch (Exception ex)
            {
                // Rollback the transaction in case of an error
                await transaction.RollbackAsync();
                throw new Exception("Error occurred while deleting the product and its ingredients.", ex);
            }
        }

        public async Task<IEnumerable<ProductsModel>> GetAllAsync()
        {
            return await _dbContext.product.WhereNotDeleted().ToListAsync();
        }

        public async Task<ProductsModel> GetByIdAsync(int id)
        {
            return await _dbContext.product.WhereNotDeleted().FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task UpdateAsync(ProductsModel model)
        {
            _dbContext.product.Update(model);
            await _dbContext.SaveChangesAsync();
        }
    }
}
