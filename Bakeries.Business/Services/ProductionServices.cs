using AutoMapper;
using Bakeries.Business.Services.IServices;
using Bakeries.DataAccess;
using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo;
using Bakeries.DataAccess.Repo.IRepo;
using Business.Shared.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.Business.Services
{
    public class ProductionServices(IProductionRepo _productionRepo, IMapper _mapper) : IProductionServices
    {

        public async Task<IEnumerable<ProductionDTO>> GetAllAsync()
        {
            var model = await _productionRepo.GetAllAsync(); ;

            var newModel = _mapper.Map<IEnumerable<ProductionDTO>>(model);


            return newModel;
        }

        public async Task<ProductionDTO> GetByIdAsync(int id)
        {
            return _mapper.Map<ProductionDTO>(await _productionRepo.GetByIdAsync(id));
        }

        public async Task<int> AddAsync(ProductionDTO model)
        {
           
                var newModel = _mapper.Map<ProductionModel>(model);

                var newId = await _productionRepo.AddAsync(newModel);

                await DeductStockForProductionAsync(newId);
                return newId;
            
         

        }

        public async Task UpdateAsync(ProductionDTO model)
        {
            await _productionRepo.UpdateAsync(_mapper.Map<ProductionModel>(model));
        }

        public async Task DeleteAsync(int id)
        {
            await _productionRepo.DeleteAsync(id);
        }


        //public async Task DeductStockForProductionAsync(int productionId)
        //{
        //    var production = await _productionRepo.GetProductionWithProductAndIngredientsAsync(productionId);

        //    if (production == null)
        //        throw new Exception($"Production with ID {productionId} not found.");

        //    var product = production.Product;

        //    if (product == null || product.Ingredients == null || !product.Ingredients.Any())
        //        throw new Exception("Product or its ingredients not found.");

        //    var totalQuantity = production.QuantityProduced + production.QuantityDamaged;

        //    // استخدام Dictionary لتخزين الكميات المطلوبة لكل مكون
        //    var stockUpdates = new Dictionary<int, float>();

        //    // جمع التغييرات المطلوبة للمخزون لكل مكون
        //    foreach (var ingredient in product.Ingredients)
        //    {
        //        var requiredQuantity = ingredient.Quantity * totalQuantity;

        //        if (stockUpdates.ContainsKey(ingredient.stockId))
        //        {
        //            stockUpdates[ingredient.stockId] += requiredQuantity;
        //        }
        //        else
        //        {
        //            stockUpdates[ingredient.stockId] = requiredQuantity;

        //        }

        //        // تحديث المخزون بعد جمع كل التغييرات
        //        foreach (var stockUpdate in stockUpdates)
        //        {
        //            var stockItem = await _productionRepo.GetStockItemAsync(stockUpdate.Key);

        //            if (stockItem == null)
        //                throw new Exception($"Stock item with ID {stockUpdate.Key} not found.");

        //            if (stockItem.AvailableQuantity < stockUpdate.Value)
        //                throw new Exception($"Insufficient stock for item {stockItem.ItemName}. Required: {stockUpdate.Value}, Available: {stockItem.AvailableQuantity}");

        //            // خصم الكمية
        //            stockItem.AvailableQuantity -= stockUpdate.Value;

        //            // تحديث المخزون في قاعدة البيانات
        //            await _productionRepo.UpdateStockAsync(stockItem);
        //        }
        //    }



        public async Task DeductStockForProductionAsync(int productionId)
        {
            // بدء المعاملة
            using (var transaction = await _productionRepo.BeginTransactionAsync())
            {
                try
                {
                    var production = await _productionRepo.GetProductionWithProductAndIngredientsAsync(productionId);

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
                        var stockItem = await _productionRepo.GetStockItemAsync(stockUpdate.Key);

                        if (stockItem == null)
                            throw new Exception($"Stock item with ID {stockUpdate.Key} not found.");

                        if (stockItem.AvailableQuantity < stockUpdate.Value)
                            throw new Exception($"Insufficient stock for item {stockItem.ItemName}. Required: {stockUpdate.Value}, Available: {stockItem.AvailableQuantity}");

                        // خصم الكمية
                        stockItem.AvailableQuantity -= stockUpdate.Value;

                        // تحديث المخزون في قاعدة البيانات
                        await _productionRepo.UpdateStockAsync(stockItem);
                    }

                    // إذا تمت العملية بنجاح، قم بعمل Commit للمعاملة
                    await transaction.CommitAsync();
                }
                catch (Exception ex)
                {
                    // في حالة حدوث خطأ، قم بعمل Rollback للمعاملة
                    await transaction.RollbackAsync();
                    Console.WriteLine($"33333 {ex.Message}");

                  // await DeleteAsync(productionId);
                    // إلقاء الاستثناء مرة أخرى ليتعامل معه الكود في الطبقات الأعلى
                    throw new Exception($"An error occurred while processing the production. All changes have been rolled back. {ex.Message}", ex);
                }
            }
        }


        public async Task<IEnumerable<ProductionDTO>> ProductionProcessWithAssociatedProductAsync()
        {
            var model = await _productionRepo.ProductionProcessWithAssociatedProductAsync();



            var newModel = _mapper.Map<IEnumerable<ProductionDTO>>(model);



            return newModel;
        }




    }
}

