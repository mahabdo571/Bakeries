using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;
using Microsoft.EntityFrameworkCore;


namespace Bakeries.DataAccess.Repo
{
    public class OrderRepo(clsDbContext context) : IOrderRepo
    {

        public async Task AddAsync(OrderModel model)
        {
            try
            {
                if (model is  null) throw new ArgumentNullException($"error in model : {nameof(model)} is null");
                
                    await context.Orders.AddAsync(model);

                    await context.SaveChangesAsync();
                

            }
            catch
            {
                throw;

            }
        }

        public async Task DeleteAsync(int id)
        {
            var model = await context.Orders.WhereNotDeleted().AsNoTracking().FirstOrDefaultAsync(p => p.Id == id);
            if (model is null) throw new ArgumentNullException($"error in model : {nameof(model)} is null");
            

                model.DeletedAt = DateTime.Now;

                context.Update(model);

            
        }

        public async Task<IEnumerable<OrderModel>> GetAllAsync()
        {
            return await context.Orders.WhereNotDeleted().ToListAsync();

        } 
        
        public async Task<IEnumerable<OrderModel>> GetAllByDayAsync(DateTime date)
        {
            
            return await context.Orders
                .WhereNotDeleted()
               .Where(e => EF.Functions.DateDiffDay(e.CreatedAt, date) == 0)

                .ToListAsync();

        }

        public async Task<OrderModel> GetByIdAsync(int id)
        {
            try
            {
                var model = await context.Orders.AsNoTracking().WhereNotDeleted().FirstOrDefaultAsync(p => p.Id == id);

                if (model is null) throw new ArgumentNullException($"error in model : {nameof(model)} is null");

                return model;
            }
            catch
            {
                throw;
            }

        }

        public async Task UpdateAsync(OrderModel model)
        {
            if (model is null) throw new ArgumentNullException($"error in model : {nameof(model)} is null");
            context.Orders.Update(model);

        }
    }
}
