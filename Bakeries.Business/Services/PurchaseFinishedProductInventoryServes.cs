using AutoMapper;
using Bakeries.Business.Services.IServices;
using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess;
using Bakeries.DataAccess.Repo.IRepo;
using Business.Shared.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.Business.Services
{
    public class PurchaseFinishedProductInventoryServes(IUnitOfWork unitOfWork , IMapper mapper) : IPurchaseFinishedProductInventoryServes
    {
        public async Task<int> AddAsync(PurchaseFinishedProductInventoryDTO model)
        {
            if (model is null) throw new ArgumentNullException("model is null");

            model.CreatedAt = DateTime.Now;
            model.UpdatedAt = DateTime.Now;

            var newModel = mapper.Map<PurchaseFinishedProductInventoryModel>(model);
            await unitOfWork.BeginTransactionAsync();
            try
            {
                await unitOfWork.PurchaseFinishedProductInventoryRepository.AddAsync(newModel);

                if (model.Status.Equals("ملغي"))
                {
                    model.Quantity = 0;
                }


                await unitOfWork.PurchaseFinishedProductInventoryRepository.UpdateAvailableQuantityOnFinishedProductInventoryAfterPurchase((int)model.FinishedProductInventoryId!, model.Quantity);
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
                await unitOfWork.PurchaseFinishedProductInventoryRepository.DeleteAsync(id);


                await UpdateInventoryQuantityBasedOnDeleteInInvoiceStatusAsync(model);

                await unitOfWork.SaveChangesAsync();
                await unitOfWork.CommitAsync();
            }
            catch
            {
                await unitOfWork.RollbackAsync();
                throw;
            }
        }

        public async  Task<IEnumerable<PurchaseFinishedProductInventoryDTO>> GetAllAsync()
        {
            var model = await unitOfWork.PurchaseFinishedProductInventoryRepository.GetAllAsync(); ;

            var newModel = mapper.Map<IEnumerable<PurchaseFinishedProductInventoryDTO>>(model);


            return newModel;
        }
        public async Task<IEnumerable<PurchaseFinishedProductInventoryDTO>> GetAllByItemIdAsync(int itemId)
        {
            var newModel = mapper.Map<IEnumerable<PurchaseFinishedProductInventoryDTO>>(await unitOfWork.PurchaseFinishedProductInventoryRepository.GetAllByItemIdAsync(itemId));
            return newModel;
        }
        public async Task<PurchaseFinishedProductInventoryDTO> GetByIdAsync(int id)
        {
            return mapper.Map<PurchaseFinishedProductInventoryDTO>(await unitOfWork.PurchaseFinishedProductInventoryRepository.GetByIdAsync(id));

        }

        public async Task UpdateAsync(PurchaseFinishedProductInventoryDTO model)
        {
            var newModel = mapper.Map<PurchaseFinishedProductInventoryModel>(model);
            newModel.UpdatedAt = DateTime.Now;
            await unitOfWork.BeginTransactionAsync();
            try
            {
                var temp = await unitOfWork.PurchaseFinishedProductInventoryRepository.GetByIdAsync(model.Id);
                if (temp == null) throw new Exception(".PurchaseFinishedProductInventoryRepository.GetByIdAsync null");
                newModel.CreatedAt = temp.CreatedAt;
            await UpdateInventoryQuantityBasedOnChangesInInvoiceStatusAsync(model);
            await unitOfWork.PurchaseFinishedProductInventoryRepository.UpdateAsync(newModel);

                await unitOfWork.SaveChangesAsync();
                await unitOfWork.CommitAsync();
            }
            catch
            {
                await unitOfWork.RollbackAsync();
                throw;
            }
        }

        private async Task UpdateInventoryQuantityBasedOnDeleteInInvoiceStatusAsync(PurchaseFinishedProductInventoryDTO model)
        {
            if (model is null) throw new ArgumentNullException(nameof(model));



            var temp = await unitOfWork.FinishedProductInventoryRepository.GetByIdAsync((int)model.FinishedProductInventoryId!);

         


            if (temp == null)
            {

                throw new NullReferenceException("Stock item not found.");
            }

            // تعديل الكمية المتاحة
            temp.AvailableQuantity -= model.Quantity;

            // تحديث المخزون
            await unitOfWork.FinishedProductInventoryRepository.UpdateAsync(temp);
        }

        private async Task UpdateInventoryQuantityBasedOnChangesInInvoiceStatusAsync(PurchaseFinishedProductInventoryDTO model)
        {
            // جلب الفاتورة القديمة
            var oldPurchase = await this.GetByIdAsync(model.Id);
            if (oldPurchase == null)
            {
                throw new NullReferenceException("Old purchase not found.");
            }
            decimal quantityDifference = 0;

            if (model.Status.Equals("ملغي") && !oldPurchase.Status.Equals("ملغي"))
            {
                quantityDifference = -model.Quantity;

            }

            else if (!model.Status.Equals("ملغي"))
            {
                if (oldPurchase.Status.Equals("ملغي"))
                {
                    quantityDifference = model.Quantity;
                }
                else
                {
                    quantityDifference = model.Quantity - oldPurchase.Quantity;
                }

            }


            // جلب بيانات المخزون
            var stockModel = await unitOfWork.FinishedProductInventoryRepository.GetByIdAsync((int)model.FinishedProductInventoryId!);

            if (stockModel == null)
            {

                throw new NullReferenceException("Stock item not found.");
            }

            // تعديل الكمية المتاحة
            stockModel.AvailableQuantity += quantityDifference;


            // تحديث المخزون
            await unitOfWork.FinishedProductInventoryRepository.UpdateAsync(stockModel);
        }

   
    }
}
