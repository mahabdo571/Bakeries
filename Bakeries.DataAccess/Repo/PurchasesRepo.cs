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
    public class PurchasesRepo : IPurchasesRepo
    {
        private readonly clsDbContext _dbContext;

        public PurchasesRepo(clsDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task<int> AddPurchasesAsync(PurchasesModel model)
        {
           await _dbContext.AddAsync(model);
           await _dbContext.SaveChangesAsync();
            return model.Id;
        }

        public async Task DeletePurchasesAsync(int id)
        {
            var model = await _dbContext.Purchases.WhereNotDeleted().FirstOrDefaultAsync(p=>p.Id==id);

            model.DeletedAt = DateTime.Now;

            _dbContext.Update(model);
           await _dbContext.SaveChangesAsync();

          

        }

        public async Task<IEnumerable<PurchasesModel>> GetAllPurchasesAsync()
        {
            return await _dbContext.Purchases.WhereNotDeleted().ToListAsync();
        }

        public async Task<PurchasesModel> GetPurchasesByIdAsync(int id)
        {
           return await _dbContext.Purchases.WhereNotDeleted().FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task UpdatePurchasesAsync(PurchasesModel model)
        {
            _dbContext.Update(model);
            await _dbContext.SaveChangesAsync();
        }
    }
}
