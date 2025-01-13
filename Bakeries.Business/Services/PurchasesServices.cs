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

        public PurchasesServices(IUnitOfWork unitOfWork, IServiceProvider serviceProvider, IMapper mapper,IStockServices stockServices)
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

           

             

                await unitOfWork.PurchasesRepository.UpdateStockOnPurchase(model.ItemId,model.Quantity);
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
           await unitOfWork.PurchasesRepository.DeleteAsync(id);
        }

        public async Task<IEnumerable<PurchasesDTO>> GetAllAsync()
        {
            var newModel = _mapper.Map<IEnumerable<PurchasesDTO>>( await unitOfWork.PurchasesRepository.GetAllAsync());
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
            try
            {
                await updateInventoryQuantityBasedOnChangesInInvoiceStatus(model);
                await unitOfWork.PurchasesRepository.UpdateAsync(_mapper.Map<PurchasesModel>(model));

            }catch(Exception ex)
            {
                throw;
            }
        }

        private async Task updateInventoryQuantityBasedOnChangesInInvoiceStatus (PurchasesDTO model)
        {
           var oldInventory = await GetByIdAsync(model.Id);

            float oldQuantity = oldInventory is not null ? oldInventory.Quantity: throw new NullReferenceException("oldInventory is not Found") ;

            float quantityDifference = model.Quantity - oldQuantity;

            var stockModel =await _stockServices.GetByIdAsync(model.ItemId);

            if (stockModel is null) {
                throw new NullReferenceException("Stock id is not fuond");
            }
            stockModel.AvailableQuantity = quantityDifference;

            await _stockServices.UpdateAsync(stockModel);







        }


    }
}
