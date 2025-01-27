using AutoMapper;

using Bakeries.Business.Services.IServices;
using Bakeries.DataAccess;
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
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace Bakeries.Business.Services
{
    public class ProductionServices(IUnitOfWork unitOfWork, IMapper mapper, IStockServices stockServices, ProductionEventsHelpers productionEventsHelpers) : IProductionServices
    {

        public async Task<IEnumerable<ProductionDTO>> GetAllAsync()
        {
            var model = await unitOfWork.ProductionRepository.GetAllAsync(); ;

            var newModel = mapper.Map<IEnumerable<ProductionDTO>>(model);


            return newModel;
        }

        public async Task<ProductionDTO> GetByIdAsync(int id)
        {
            return mapper.Map<ProductionDTO>(await unitOfWork.ProductionRepository.GetByIdAsync(id));
        }

        public async Task<int> AddAsync(ProductionDTO model)
        {
            await unitOfWork.BeginTransactionAsync();

            var newModel = mapper.Map<ProductionModel>(model);


            try
            {

                await unitOfWork.ProductionRepository.AddAsync(newModel);
          
                await productionEventsHelpers.RaiseProductionAddedEvent(unitOfWork, newModel);


                await unitOfWork.SaveChangesAsync();
                await unitOfWork.CommitAsync();
                return newModel.Id;
            }
            catch(Exception ex) 
            {
                await unitOfWork.RollbackAsync();
                Console.WriteLine($"Error raising event: {ex.Message}");

                throw;
            }


        }

    

        public async Task UpdateAsync(ProductionDTO model)
        {
            await unitOfWork.BeginTransactionAsync();
            try
            {
                var newModel = mapper.Map<ProductionModel>(model);

                await unitOfWork.ProductionRepository.UpdateAsync(newModel);

                newModel =await unitOfWork.ProductionRepository.GetProductionWithProductAndIngredientsAsync(model.Id);
           
                await productionEventsHelpers.RaiseProductionUpdatedEvent(unitOfWork, newModel);
         
                    await unitOfWork.SaveChangesAsync();
                    await unitOfWork.CommitAsync();
            


           
                
            }
            catch { 
                await unitOfWork.RollbackAsync();
                throw;
            }
        }

        public async Task DeleteAsync(int id)
        {
            await unitOfWork.BeginTransactionAsync();

            try
            {
                await stockServices.UpdateStockAfterDeleteProductionProcess(id);
                await unitOfWork.ProductionProcessDetailRepository.DeleteWhereProductionIdAsync(id);
                await unitOfWork.ProductionRepository.DeleteAsync(id);
                await unitOfWork.SaveChangesAsync();
                await unitOfWork.CommitAsync();
            }
            catch
            {
                await unitOfWork.RollbackAsync();
                throw;
            }
        }

    

    
        public async Task<IEnumerable<ProductionDTO>> ProductionProcessWithAssociatedProductAsync()
        {
            var model = await unitOfWork.ProductionRepository.ProductionProcessWithAssociatedProductAsync();



            var newModel = mapper.Map<IEnumerable<ProductionDTO>>(model);



            return newModel;
        }




    }
}

