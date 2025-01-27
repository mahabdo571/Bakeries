using AutoMapper;
using Bakeries.Business.Services.IServices;
using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo;
using Bakeries.DataAccess.Repo.IRepo;
using Business.Shared.DTOs;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.Business.Services
{
    public class StockServices(IUnitOfWork unitOfWork, IMapper mapper) : IStockServices
    {


        public async Task<int> AddAsync(StockDTO model)
        {
            var newModel = mapper.Map<StockModel>(model);

            await unitOfWork.StockRepository.AddAsync(newModel);
            return newModel.Id;
        }

        public async Task DeleteAsync(int id)
        {
            try
            {
                await unitOfWork.StockRepository.DeleteAsync(id);
            }
            catch
            {
                throw;
            }

        }

        public async Task<IEnumerable<StockDTO>> GetAllAsync()
        {
            var model = await unitOfWork.StockRepository.GetAllAsync(); ;

            var newModel = mapper.Map<IEnumerable<StockDTO>>(model);


            return newModel;
        }

        public async Task<StockDTO> GetByIdAsync(int id)
        {
            return mapper.Map<StockDTO>(await unitOfWork.StockRepository.GetByIdAsync(id));
        }

        public async Task UpdateAsync(StockDTO model)
        {
            await unitOfWork.BeginTransactionAsync();
            try
            {
                await unitOfWork.StockRepository.UpdateAsync(mapper.Map<StockModel>(model));

                await unitOfWork.SaveChangesAsync();

                await unitOfWork.CommitAsync();
            }
            catch
            {
                await unitOfWork.RollbackAsync();
                throw;
            }
        }

        public async Task UpdateStockAfterDeleteProductionProcess(int productionProcessId)
        {


            await unitOfWork.BeginTransactionAsync();
            try
            {

                var model = await unitOfWork.ProductionProcessDetailRepository.GetAllWhereProductionId(productionProcessId);


                foreach (var item in model)
                {


                    var modelStock = await unitOfWork.StockRepository.GetByIdAsync(item.stockId); 
            

                    modelStock.AvailableQuantity += item.Quantity;

                    await unitOfWork.StockRepository.UpdateAsync(modelStock);


                }


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
