using AutoMapper;
using Bakeries.Business.Services.IServices;
using Bakeries.DataAccess;
using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo;
using Bakeries.DataAccess.Repo.IRepo;
using Business.Shared.DTOs;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Buffers.Text;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.Business.Services
{
    public class PurchasesServices : IPurchasesServices
    {
        private readonly IUnitOfWork unitOfWork;
        private readonly IServiceProvider _serviceProvider;
        private readonly IStockServices _stockServices;
        private readonly IMapper _mapper;

        public PurchasesServices(IUnitOfWork unitOfWork, IServiceProvider serviceProvider, IMapper mapper, IStockServices stockServices)
        {
            this.unitOfWork = unitOfWork;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
            _stockServices = stockServices;
        }



        public async Task<int> AddAsync(PurchasesDTO model)
        {
            var newModel = _mapper.Map<PurchasesModel>(model);
            await unitOfWork.BeginTransactionAsync();
            try
            {
                await unitOfWork.PurchasesRepository.AddAsync(newModel);




                await unitOfWork.PurchasesRepository.UpdateStockOnPurchase(model.ItemId, model.Quantity);
                await unitOfWork.SaveChangesAsync();
                await unitOfWork.CommitAsync();

                return newModel.Id;

            }
            catch
            {
                await unitOfWork.RollbackAsync();
                throw;
            }


        }

        public async Task DeleteAsync(int id)
        {
            var model = await GetByIdAsync(id);
            await unitOfWork.BeginTransactionAsync();
     
            try
            {
                // تحديث الكمية في المخزون بناءً على التغيرات في حالة الفاتورة
                await UpdateInventoryQuantityBasedOnDeleteInInvoiceStatusAsync(model);

                await unitOfWork.PurchasesRepository.DeleteAsync(id);


                // حفظ التغييرات
                await unitOfWork.SaveChangesAsync();
                await unitOfWork.CommitAsync();
            }
            catch
            {
                await unitOfWork.RollbackAsync();
                // سجل الخطأ (يمكن استخدام logging frameworks مثل Serilog أو NLog)
                throw;
            }


        }

        public async Task<IEnumerable<PurchasesDTO>> GetAllAsync()
        {
            var newModel = _mapper.Map<IEnumerable<PurchasesDTO>>(await unitOfWork.PurchasesRepository.GetAllAsync());
            return newModel;
        }

        public async Task<IEnumerable<PurchasesDTO>> GetAllPurchasesWithItemDetailsAsync()
        {
            // استرجاع بيانات الـ Purchases
            var model = await unitOfWork.PurchasesRepository.GetAllAsync();

            // استخدام AutoMapper لتحويل البيانات إلى DTO
            var newModel = _mapper.Map<IEnumerable<PurchasesDTO>>(model);

            // استخدام Task.WhenAll لتحميل بيانات العناصر بشكل متوازي
            var tasks = newModel.Select(async purchase =>
            {
                // إنشاء نطاق جديد لاستخدام DbContext منفصل لكل عملية
                using (var scope = _serviceProvider.CreateScope())
                {
                    var dbContext = scope.ServiceProvider.GetRequiredService<clsDbContext>();

                    // جلب تفاصيل العنصر باستخدام DbContext من خلال _getStockDetailsFromItemId
                    var itemDetails = await unitOfWork.PurchasesRepository.GetStockDetailsFromItemId(purchase.ItemId, dbContext);

                    purchase.ItemName = itemDetails?.ItemName;  // إضافة بيانات إضافية
                    purchase.ItemDescription = itemDetails?.Notes;
                }
            }).ToList();

            // انتظار تنفيذ كل المهام
            await Task.WhenAll(tasks);

            return newModel;
        }






        public async Task<PurchasesDTO> GetByIdAsync(int id)
        {
            return _mapper.Map<PurchasesDTO>(await unitOfWork.PurchasesRepository.GetByIdAsync(id));
        }

        public async Task UpdateAsync(PurchasesDTO model)
        {
            if (model is null)
                throw new NullReferenceException("null model");

            await unitOfWork.BeginTransactionAsync();

            try
            {
                // تحديث الكمية في المخزون بناءً على التغيرات في حالة الفاتورة

              await UpdateInventoryQuantityBasedOnChangesInInvoiceStatusAsync(model);

                // تحديث بيانات الشراء
                var purchaseModel = _mapper.Map<PurchasesModel>(model);
                await unitOfWork.PurchasesRepository.UpdateAsync(purchaseModel);

                // حفظ التغييرات
                await unitOfWork.SaveChangesAsync();
                await unitOfWork.CommitAsync();
            }
            catch 
            {
                await unitOfWork.RollbackAsync();
                throw;
            }
        }


        private async Task UpdateInventoryQuantityBasedOnChangesInInvoiceStatusAsync(PurchasesDTO model)
        {
            // جلب الفاتورة القديمة
            var oldPurchase = await this.GetByIdAsync(model.Id);
            if (oldPurchase == null)
            {
                throw new NullReferenceException("Old purchase not found.");
            }
            float quantityDifference;

            if (model.Status.Equals("ملغي") && oldPurchase.Status.Equals("ملغي"))
            {
                quantityDifference = -model.Quantity;

            }
            else if (!model.Status.Equals("ملغي") && !oldPurchase.Status.Equals("ملغي"))
            {
                quantityDifference = model.Quantity;
            }
            else
            {
                // حساب الفرق في الكمية
                quantityDifference = model.Quantity - oldPurchase.Quantity;
            }


            // جلب بيانات المخزون
            var stockModel = await _stockServices.GetByIdAsync(model.ItemId);

            if (stockModel == null)
            {

                throw new NullReferenceException("Stock item not found.");
            }

            // تعديل الكمية المتاحة
            stockModel.AvailableQuantity += quantityDifference;

            // تحديث المخزون
            await _stockServices.UpdateAsync(stockModel);
        }

        private async Task UpdateInventoryQuantityBasedOnDeleteInInvoiceStatusAsync(PurchasesDTO model)
        {

            var stockModel = await _stockServices.GetByIdAsync(model.ItemId);
            Console.WriteLine(stockModel.Id);

            if (stockModel == null)
            {

                throw new NullReferenceException("Stock item not found.");
            }

            // تعديل الكمية المتاحة
            stockModel.AvailableQuantity -= model.Quantity;

            // تحديث المخزون
            await _stockServices.UpdateAsync(stockModel);
        }

    }
}
