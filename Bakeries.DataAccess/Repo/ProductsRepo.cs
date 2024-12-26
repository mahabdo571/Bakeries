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
            var model = await _dbContext.product.WhereNotDeleted().FirstOrDefaultAsync(s => s.Id == id);


            model.DeletedAt = DateTime.Now;

            _dbContext.product.Update(model);
            await _dbContext.SaveChangesAsync();
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
