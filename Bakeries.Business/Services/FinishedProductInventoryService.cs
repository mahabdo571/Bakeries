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
    public class FinishedProductInventoryService(IUnitOfWork unitOfWork,IMapper mapper ) : IFinishedProductInventoryService
    {
        public async Task<int> AddAsync(FinishedProductInventoryDTO model)
        {
            var newModel = mapper.Map<FinishedProductInventoryModel>(model);
            newModel.CreatedAt = DateTime.Now;
            newModel.UpdatedAt = DateTime.Now;
            await unitOfWork.FinishedProductInventoryRepo.AddAsync(newModel);
            return newModel.Id;
        }

        public async Task DeleteAsync(int id)
        {
            await unitOfWork.BeginTransactionAsync();
            try
            {
                await unitOfWork.FinishedProductInventoryRepo.DeleteAsync(id);
                await unitOfWork.SaveChangesAsync();
                await unitOfWork.CommitAsync();


            }
            catch
            {
                await unitOfWork.RollbackAsync();
                throw;
            }
        }

        public async Task<IEnumerable<FinishedProductInventoryDTO>> GetAllAsync()
        {
            var model = await unitOfWork.FinishedProductInventoryRepo.GetAllAsync(); ;

            var newModel = mapper.Map<IEnumerable<FinishedProductInventoryDTO>>(model);


            return newModel;
        }

        public async Task<FinishedProductInventoryDTO> GetByIdAsync(int id)
        {
            return mapper.Map<FinishedProductInventoryDTO>(await unitOfWork.FinishedProductInventoryRepo.GetByIdAsync(id));
        }

        public async Task UpdateAsync(FinishedProductInventoryDTO model)
        {
            await unitOfWork.BeginTransactionAsync();
            try
            {
                var newModel = mapper.Map <FinishedProductInventoryModel>(model);
            newModel.UpdatedAt = DateTime.Now;

            var temp = await unitOfWork.FinishedProductInventoryRepo.GetByIdAsync(model.Id);
            newModel.CreatedAt = temp.CreatedAt;

            await unitOfWork.FinishedProductInventoryRepo.UpdateAsync(newModel);
                await unitOfWork.SaveChangesAsync();
                await unitOfWork.CommitAsync();


            }
            catch
            {
                await unitOfWork.RollbackAsync();
                throw;
            }
        }
    }
}
