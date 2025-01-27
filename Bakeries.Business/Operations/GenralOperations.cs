using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.Business.Operations
{
    public static class GenralOperations
    {

        public static async Task AddingTheQuantitiesConsumedInTheProductionProcess(IUnitOfWork unitOfWork, ProductionModel newModel)
        {
            foreach (var item in newModel.Product.Ingredients)
            {
                await unitOfWork.ProductionProcessDetailRepository.AddAsync(new ProductionProcessDetailModel
                {
                    Quantity = ((newModel.QuantityProduced + newModel.QuantityDamaged) * item.Quantity),
                    stockId = item.stockId,
                    ProductionId = newModel.Id,


                });
            }
        }
        
        
        public static async Task UpdatingTheQuantitiesConsumedInTheProductionProcess(IUnitOfWork unitOfWork, ProductionModel newModel)
        {
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
        }
    }
}
