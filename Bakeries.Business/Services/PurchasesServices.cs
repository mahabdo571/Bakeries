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
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.Business.Services
{
    public class PurchasesServices : IPurchasesServices
    {
        private readonly IPurchasesRepo _purchasesRepo;
        private readonly IServiceProvider _serviceProvider;
        private readonly IMapper _mapper;

        public PurchasesServices(IPurchasesRepo purchasesRepo, IServiceProvider serviceProvider, IMapper mapper)
        {
            _purchasesRepo = purchasesRepo;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
        }



        public async Task<int> AddAsync(PurchasesDTO model)
        {
            var newModel = _mapper.Map<PurchasesModel>(model);

            return await _purchasesRepo.AddAsync(newModel);

        }

        public async Task DeleteAsync(int id)
        {
           await _purchasesRepo.DeleteAsync(id);
        }

        public async Task<IEnumerable<PurchasesDTO>> GetAllAsync()
        {
            var newModel = _mapper.Map<IEnumerable<PurchasesDTO>>( await _purchasesRepo.GetAllAsync());
            return newModel;
        }

        public async Task<IEnumerable<PurchasesDTO>> GetAllPurchasesWithItemDetailsAsync()
        {
            // استرجاع بيانات الـ Purchases
            var model = await _purchasesRepo.GetAllAsync();

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
                    var itemDetails = await _purchasesRepo.GetStockDetailsFromItemId(purchase.ItemId, dbContext);

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
            return _mapper.Map<PurchasesDTO>(await _purchasesRepo.GetByIdAsync(id));
        }

        public async Task UpdateAsync(PurchasesDTO model)
        {
            await _purchasesRepo.UpdateAsync(_mapper.Map<PurchasesModel>(model));
        }
    }
}
