using Bakeries.DataAccess;
using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.Business.Operations
{
    public static class StockOperation
    {
        public static async Task UpdateStockAvailabilityAfterNew(IUnitOfWork unitOfWork, int productionId)
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

               
                foreach (var stockUpdate in stockUpdates)
                {
                    var stockItem = await unitOfWork.ProductionRepository.GetStockItemAsync(stockUpdate.Key);

                    if (stockItem == null)
                        throw new Exception($"Stock item with ID {stockUpdate.Key} not found.");

                    if (stockItem.AvailableQuantity < stockUpdate.Value)
                        throw new Exception($"Insufficient stock for item {stockItem.ItemName}. Required: {stockUpdate.Value}, Available: {stockItem.AvailableQuantity}");


                    stockItem.AvailableQuantity -= stockUpdate.Value;


                   
                    await unitOfWork.ProductionRepository.UpdateStockAsync(stockItem);
                    await unitOfWork.SaveChangesAsync();
                }
         

            }
            catch
            {
              
                throw;
            }
        }

        public static async Task UpdateStockAvailabilityAfterUpdate(IUnitOfWork unitOfWork, ProductionModel model)
        {
            // TODO not finsh 

            if (model == null)
                throw new ArgumentNullException(nameof(model), "Production model cannot be null.");

            var product = model.Product;

            if (product?.Ingredients == null || !product.Ingredients.Any())
                throw new InvalidOperationException("Product or its ingredients not found.");

            var totalQuantity = model.QuantityProduced + model.QuantityDamaged;

            var stockUpdates = new Dictionary<int, float>();

            foreach (var ingredient in product.Ingredients)
            {
                var requiredQuantity = ingredient.Quantity * totalQuantity;

                if (!stockUpdates.ContainsKey(ingredient.stockId))
                {
                    stockUpdates[ingredient.stockId] = 0;
                }
                stockUpdates[ingredient.stockId] -= requiredQuantity;
            }

            foreach (var stockUpdate in stockUpdates)
            {
                var stockItem = await unitOfWork.StockRepository.GetByIdAsync(stockUpdate.Key);

                if (stockItem == null)
                    throw new InvalidOperationException($"Stock item with ID {stockUpdate.Key} not found.");

                if (stockItem.AvailableQuantity + stockUpdate.Value < 0)
                    throw new InvalidOperationException($"Insufficient stock for item {stockItem.ItemName}. Required: {-stockUpdate.Value}, Available: {stockItem.AvailableQuantity}");

                stockItem.AvailableQuantity += stockUpdate.Value;

                await unitOfWork.StockRepository.UpdateAsync(stockItem);
                await unitOfWork.SaveChangesAsync();
            }


        }
    }
}
