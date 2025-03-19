using AutoMapper;
using Bakeries.Business.Services.IServices;
using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;
using Business.Shared.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.Business.Services
{
    public class SalesDetailService(IUnitOfWork unitOfWork , IMapper mapper ) : ISalesDetailService
    {
        public async Task<int> AddAsync(SalesDetailDTO model)
        {
            await unitOfWork.BeginTransactionAsync();
            try
            {
                var newModel = mapper.Map<SalesDetailModel>(model);
                newModel.CreatedAt = DateTime.Now;
                newModel.UpdatedAt = DateTime.Now;
                await unitOfWork.SalesDetailRepository.AddAsync(newModel);


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
                await unitOfWork.SalesDetailRepository.DeleteAsync(id);
                await unitOfWork.SaveChangesAsync();
                await unitOfWork.CommitAsync();


            }
            catch
            {
                await unitOfWork.RollbackAsync();
                throw;
            }
        }

        public async Task<IEnumerable<SalesDetailDTO>> GetAllAsync()
        {
            var model = await unitOfWork.SalesDetailRepository.GetAllAsync(); ;

            var newModel = mapper.Map<IEnumerable<SalesDetailDTO>>(model);


            return newModel;
        }

        public async Task<IEnumerable<SalesDetailDTO>> GetAllByOrderIdAsync(int orderId)
        {
            var model = await unitOfWork.SalesDetailRepository.GetAllByOrderIdAsync(orderId); ;

            var newModel = mapper.Map<IEnumerable<SalesDetailDTO>>(model);


            return newModel;
        }

        public async Task<SalesDetailDTO> GetByIdAsync(int id)
        {
            return mapper.Map<SalesDetailDTO>(await unitOfWork.SalesDetailRepository.GetByIdAsync(id));
        }

        public async Task UpdateAsync(SalesDetailDTO model)
        {
            await unitOfWork.BeginTransactionAsync();
            try
            {
                var newModel = mapper.Map<SalesDetailModel>(model);
                newModel.UpdatedAt = DateTime.Now;

                var temp = await unitOfWork.SalesDetailRepository.GetByIdAsync(newModel.Id);
                newModel.CreatedAt = temp.CreatedAt;


                await unitOfWork.SalesDetailRepository.UpdateAsync(newModel);
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
