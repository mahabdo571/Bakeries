using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;
using Microsoft.EntityFrameworkCore;
using System;


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
            //var model = await context.Orders.WhereNotDeleted().AsNoTracking().FirstOrDefaultAsync(p => p.Id == id);
            //if (model is null) throw new ArgumentNullException($"error in model : {nameof(model)} is null");


            //    model.DeletedAt = DateTime.Now;

            //    context.Update(model);

         
                using (var transaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        // تحميل الطلب مع العناصر المرتبطة
                        var order = context.Orders
                            .Include(o => o.SalesDetails)
                            .FirstOrDefault(o => o.Id == id);

                        if (order != null)
                        {
                            // تعليم الطلب بأنه محذوف
                            order.DeletedAt = DateTime.Now;

                            // تكرار العناصر المرتبطة وتعليمها محذوفة وإعادة الكميات للمخزن
                            foreach (var item in order.SalesDetails)
                            {
                                item.DeletedAt = DateTime.Now;

                                // مثال: استرجاع الكمية للمخزن
                                var product = context.FinishedProductInventorys.FirstOrDefault(p => p.Id == item.FinishedProductInventoryId);
                                if (product != null)
                                {
                                    product.AvailableQuantity += item.Quantity;
                                }
                            }

                            // حفظ التغييرات
                            context.SaveChanges();

                            // تأكيد المعاملة
                            transaction.Commit();
                        }
                    }
                    catch (Exception ex)
                    {
                        // في حال حدوث خطأ، الرجوع عن المعاملة
                        transaction.Rollback();
                        // هنا ممكن التعامل مع الخطأ مثلاً بتسجيله أو إظهار رسالة مناسبة
                    }
                
            }



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
