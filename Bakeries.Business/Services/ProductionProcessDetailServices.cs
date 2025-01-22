using AutoMapper;
using Bakeries.Business.Services.IServices;
using Bakeries.DataAccess;
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
    public class ProductionProcessDetailServices(IUnitOfWork unitOfWork , IMapper mapper) : IProductionProcessDetailService
    {
        public async Task<int> AddAsync(ProductionProcessDetailDTO model)
        {
            if (model is null) throw new ArgumentNullException("model is null");

            var newModel = mapper.Map<ProductionProcessDetailModel>(model);

            await unitOfWork.BeginTransactionAsync();
            try
            {

               await unitOfWork.ProductionProcessDetailRepository.AddAsync(newModel);

                      await unitOfWork.SaveChangesAsync();
                await unitOfWork.CommitAsync();

                return model.Id;

            }
            catch
            {
                await unitOfWork.RollbackAsync();
                throw;
            }
        }

        public Task DeleteAsync(int id)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<ProductionProcessDetailDTO>> GetAllAsync()
        {
            throw new NotImplementedException();
        }

        public Task<ProductionProcessDetailDTO> GetByIdAsync(int id)
        {
            throw new NotImplementedException();
        }

        public Task UpdateAsync(ProductionProcessDetailDTO model)
        {
            throw new NotImplementedException();
        }
    }
}
