using Bakeries.DataAccess;
using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;
using System;
using System.Collections;
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

                var stockUpdates = new Dictionary<int, decimal>();

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
 
            var oldModel =await unitOfWork.ProductionRepository.GetByIdAsync(model.Id);
            var oldIngredient = await unitOfWork.ProductIngredientRepository.GetAllByProductIdAsync(oldModel.ProductId);  
            var oldQuantity = new Dictionary<int, decimal>();
            var newQuantity = new Dictionary<int, decimal>();

            foreach (var item in oldIngredient)
            {
                var quantity = (item.Quantity * (oldModel.QuantityDamaged + oldModel.QuantityProduced));

                if (oldQuantity.ContainsKey(item.stockId))
                {
                    oldQuantity[item.stockId] += quantity;

                }
                else
                {
                    oldQuantity[item.stockId] = quantity;
                 
                }  
            }

            foreach (var item in model.Product.Ingredients)
            {
                var quantity = (item.Quantity * (model.QuantityDamaged + model.QuantityProduced));

                if (newQuantity.ContainsKey(item.stockId))
                {
                    newQuantity[item.stockId] += quantity;

                }
                else
                {
                    newQuantity[item.stockId] = quantity;

                }
            }
         
            var finalQuantity = oldQuantity
            .Where(kvp => newQuantity.ContainsKey(kvp.Key)) 
                .ToDictionary(
                    kvp => kvp.Key,                     
                    kvp => kvp.Value - newQuantity[kvp.Key] 
                );



            foreach (var stockUpdate in finalQuantity)
            {
                var stockItem = await unitOfWork.ProductionRepository.GetStockItemAsync(stockUpdate.Key);

                if (stockItem == null)
                    throw new Exception($"Stock item with ID {stockUpdate.Key} not found.");

                if (stockItem.AvailableQuantity < stockUpdate.Value)
                    throw new Exception($"Insufficient stock for item {stockItem.ItemName}. Required: {stockUpdate.Value}, Available: {stockItem.AvailableQuantity}");


                stockItem.AvailableQuantity += stockUpdate.Value;



                await unitOfWork.ProductionRepository.UpdateStockAsync(stockItem);
                
            }



        }
    }
}
