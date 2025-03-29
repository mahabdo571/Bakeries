using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;


namespace Bakeries.Business.Operations
{
    public static class GenralOperations
    {

        public static async Task<decimal> AddingTheQuantitiesConsumedInTheProductionProcess(IUnitOfWork unitOfWork, ProductionModel newModel)
        {
      
            if (newModel is null || newModel.Product is null || newModel.Product.Ingredients is null) return -1;
    
            await unitOfWork.ProductionProcessDetailRepository.AddRangeAsync(
                newModel.Product.Ingredients
                .Where(item => item.DeletedAt is null)
                .Select(item =>
                new ProductionProcessDetailModel
                {
                    Quantity = (newModel.QuantityProduced + newModel.QuantityDamaged) * item.Quantity,
                    Cost = (((newModel.QuantityProduced + newModel.QuantityDamaged) * item.Quantity) * item.stock.lastPriceCost),
                    stockId = item.stockId,
                    ProductionId = newModel.Id,
                    CreatedAt = DateTime.Now,
                    UpdatedAt = DateTime.Now ,
                })
                .ToList());
            await unitOfWork.SaveChangesAsync();
        var allProcessForthisProduction =await unitOfWork.ProductionProcessDetailRepository.GetAllWhereProductionId(newModel.Id);

           return allProcessForthisProduction.Sum(e=>e.Cost);

        }


        public static async Task UpdatingTheQuantitiesConsumedInTheProductionProcess(IUnitOfWork unitOfWork, ProductionModel newModel)
        {
            if (newModel is null || newModel.Product is null || newModel.Product.Ingredients is null) return;

            foreach (var item in newModel.Product.Ingredients)
            {
                var PPDM = await unitOfWork.ProductionProcessDetailRepository.GetByStockIdAndProductionIdAsync(newModel.Id, item.stockId);
                if(PPDM is null) return;
                await unitOfWork.ProductionProcessDetailRepository.UpdateAsync(new ProductionProcessDetailModel
                {
                    Id = PPDM.Id,
                    Quantity = ((newModel.QuantityProduced + newModel.QuantityDamaged) * item.Quantity),
                    stockId = item.stockId,
                    ProductionId = newModel.Id,
                    UpdatedAt= DateTime.Now,
                   CreatedAt= PPDM.CreatedAt,

                });
            }



        }
    }
}
