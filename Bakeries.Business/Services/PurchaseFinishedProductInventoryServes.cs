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
            await unitOfWork.BeginTransactionAsync();
            try
            {
                await unitOfWork.PurchaseFinishedProductInventoryRepository.DeleteAsync(id);
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

            var temp = await unitOfWork.PurchaseFinishedProductInventoryRepository.GetByIdAsync(model.Id);
            newModel.CreatedAt = temp.CreatedAt;

            await unitOfWork.PurchaseFinishedProductInventoryRepository.UpdateAsync(newModel);
        }
    }
}
