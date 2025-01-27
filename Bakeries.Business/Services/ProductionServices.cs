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
    public class ProductionServices(IUnitOfWork unitOfWork, IMapper mapper, IStockServices stockServices) : IProductionServices
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
                await UpdateStockAvailabilityAfterNew(newModel.Id);
                foreach (var item in newModel.Product.Ingredients)
                {
                    await unitOfWork.ProductionProcessDetailRepository.AddAsync(new ProductionProcessDetailModel
                    {
                        Quantity = ((newModel.QuantityProduced + newModel.QuantityDamaged) * item.Quantity),
                        stockId = item.stockId,
                        ProductionId = newModel.Id,


                    });
                }
                await unitOfWork.SaveChangesAsync();
                await unitOfWork.CommitAsync();
                return newModel.Id;
            }
            catch
            {
                await unitOfWork.RollbackAsync();
                throw;// new Exception($"An error occurred while processing the production. All changes have been rolled back. {ex.Message}", ex);
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
           
                    foreach (var item in newModel.Product.Ingredients)
                    {
                    var PPDM = await unitOfWork.ProductionProcessDetailRepository.GetByStockIdAndProductionIdAsync(newModel.Id, item.stockId);

                    await unitOfWork.ProductionProcessDetailRepository.UpdateAsync(new ProductionProcessDetailModel
                        {
                            Id = PPDM.Id,
                            Quantity = ((newModel.QuantityProduced + newModel.QuantityDamaged) * item.Quantity),
                            stockId = item.stockId,
                            ProductionId = newModel.Id,


                        });
                    }
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

        public async Task UpdateStockAvailabilityAfterNew(int productionId)
        {



            try
            {
                var production = await unitOfWork.ProductionRepository.GetProductionWithProductAndIngredientsAsync(productionId);

                if (production == null)
                    throw new Exception($"Production with ID {productionId} not found.");

                var product = production.Product;

                if (product == null || product.Ingredients == null || !product.Ingredients.Any())
                    throw new Exception("Product or its ingredients not found.");

                var totalQuantity = production.QuantityProduced + production.QuantityDamaged;

                var stockUpdates = new Dictionary<int, float>();

                foreach (var ingredient in product.Ingredients)
                {
                    var requiredQuantity = ingredient.Quantity * totalQuantity;

                    if (stockUpdates.ContainsKey(ingredient.stockId))
                    {
                        stockUpdates[ingredient.stockId] += requiredQuantity;

                    }
                    else
                    {
                        stockUpdates[ingredient.stockId] = requiredQuantity;
                    }
                }

                // تحديث المخزون في المعاملة
                foreach (var stockUpdate in stockUpdates)
                {
                    var stockItem = await unitOfWork.ProductionRepository.GetStockItemAsync(stockUpdate.Key);

                    if (stockItem == null)
                        throw new Exception($"Stock item with ID {stockUpdate.Key} not found.");

                    if (stockItem.AvailableQuantity < stockUpdate.Value)
                        throw new Exception($"Insufficient stock for item {stockItem.ItemName}. Required: {stockUpdate.Value}, Available: {stockItem.AvailableQuantity}");

           
                    stockItem.AvailableQuantity -= stockUpdate.Value;
           

                    // تحديث المخزون في قاعدة البيانات
                    await unitOfWork.ProductionRepository.UpdateStockAsync(stockItem);
                }
                await unitOfWork.SaveChangesAsync();

                await unitOfWork.CommitAsync();

            }
            catch
            {
                await unitOfWork.RollbackAsync();

                throw;// new Exception($"An error occurred while processing the production. All changes have been rolled back. {ex.Message}", ex);
            }
        }

        public async Task UpdateStockAvailabilityAfterUpdate()
        {
            // TODO : 
        }
        public async Task<IEnumerable<ProductionDTO>> ProductionProcessWithAssociatedProductAsync()
        {
            var model = await unitOfWork.ProductionRepository.ProductionProcessWithAssociatedProductAsync();



            var newModel = mapper.Map<IEnumerable<ProductionDTO>>(model);



            return newModel;
        }




    }
}

