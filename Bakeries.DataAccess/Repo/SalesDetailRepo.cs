using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Query.SqlExpressions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Repo
{
    public class SalesDetailRepo(clsDbContext context) : ISalesDetailRepo
    {
        public async Task AddAsync(SalesDetailModel model)
        {
            try
            {
                if (model is null) throw new ArgumentNullException($"error in model : {nameof(model)} is null");

                await context.SalesDetails.AddAsync(model);

                await context.SaveChangesAsync();


            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.InnerException);

                throw;

            }
        }

        public async Task DeleteAsync(int id)
        {
            var model = await context.SalesDetails.WhereNotDeleted().AsNoTracking().FirstOrDefaultAsync(p => p.Id == id);
            if (model is null) throw new ArgumentNullException($"error in model : {nameof(model)} is null");


            model.DeletedAt = DateTime.Now;

            context.Update(model);
        }

        public async Task<IEnumerable<SalesDetailModel>> GetAllAsync()
        {
            return await context.SalesDetails.WhereNotDeleted().ToListAsync();
        }

        public async Task<IEnumerable<SalesDetailModel>> GetAllByOrderIdAsync(int orderId)
        {
         return   await context.SalesDetails.WhereNotDeleted().AsNoTracking().Where(e=>e.OrderId==orderId).ToListAsync();
           
        } 
        
    

        public async Task<SalesDetailModel> GetByIdAsync(int id)
        {
            try
            {
                var model = await context.SalesDetails.AsNoTracking().WhereNotDeleted().FirstOrDefaultAsync(p => p.Id == id);

                if (model is null) throw new ArgumentNullException($"error in model : {nameof(model)} is null");

                return model;
            }
            catch
            {
                throw;
            }
        }

        public async Task<SalesDetailModel?> IsTheItemOnTheInvoice(int FinishedProductInventoryId,int orderId)
        {
            try
            {
                var model = await context
                    .SalesDetails
                    .AsNoTracking()
                    .WhereNotDeleted()
                    .FirstOrDefaultAsync(p => p.FinishedProductInventoryId == FinishedProductInventoryId && p.OrderId == orderId);

                if (model is not null)
                {
                    return model;
                }

                return null;
            }
            catch
            {
                throw;
            }
        }

        public async Task UpdateAsync(SalesDetailModel model)
        {
            if (model is null) throw new ArgumentNullException($"error in model : {nameof(model)} is null");
            
            context.SalesDetails.Update(model);
        }
    }
}
