using AutoMapper;
using Bakeries.Business.Services.IServices;
using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;
using Business.Shared.DTOs;
using Microsoft.EntityFrameworkCore;


namespace Bakeries.Business.Services
{
    public class ProductionServices(IUnitOfWork unitOfWork, IMapper mapper, IStockServices stockServices, ProductionEventsHelpers productionEventsHelpers, IPurchaseFinishedProductInventoryServes purchaseFinishedProductInventoryServes) : IProductionServices
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
            model.CreatedAt = DateTime.Now;
            model.UpdatedAt = DateTime.Now;
            var newModel = mapper.Map<ProductionModel>(model);


            try
            {

                await unitOfWork.ProductionRepository.AddAsync(newModel);
              
     await AddToPurchaseFinishedProductInventory(unitOfWork, purchaseFinishedProductInventoryServes, model, newModel);
             
              

                await unitOfWork.SaveChangesAsync();
             decimal ddd=   await productionEventsHelpers.RaiseProductionAddedEvent(unitOfWork, newModel);
                newModel.TotalCost = ddd;
                await unitOfWork.ProductionRepository.UpdateAsync(newModel);
                var fpi = await unitOfWork.FinishedProductInventoryRepository.GetByProuductIdAsync(newModel.ProductId);
                fpi.CostPrice = (ddd / (newModel.QuantityProduced + newModel.QuantityDamaged));
                await unitOfWork.FinishedProductInventoryRepository.UpdateAsync(fpi);
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

        private  async Task<int> AddToPurchaseFinishedProductInventory(IUnitOfWork unitOfWork, IPurchaseFinishedProductInventoryServes purchaseFinishedProductInventoryServes, ProductionDTO model, ProductionModel newModel)
        {
            var fpi = await unitOfWork.FinishedProductInventoryRepository.GetByProuductIdAsync(newModel.ProductId);
            if (fpi == null) throw new Exception("خطأ في جلب بيانات المنتج في المعرض");
   
          return  await purchaseFinishedProductInventoryServes.AddAsync(new PurchaseFinishedProductInventoryDTO
          {
              CreatedAt = DateTime.Now,
              UpdatedAt = DateTime.Now,
              FinishedProductInventoryId = fpi.Id,
              Quantity = (decimal.Parse(model.QuantityProduced.ToString()) - decimal.Parse(model.QuantityDamaged.ToString())),
              ProductionId = newModel.Id,
              PaymentMethod = "none",
              Status = "none",
              TotalPrice = 0,
              UnitPrice = 0,
              UnitOfMeasureId = 1,
              Notes = "عملية انتاج تلقائية مسجلة من النظام ",
              SupplierName = "تصنيع",
              SupplierInvoiceNumber = "تصنيع",

          });
         
        
        } 
        
        
        private  async Task UpdateToPurchaseFinishedProductInventory(IUnitOfWork unitOfWork, IPurchaseFinishedProductInventoryServes purchaseFinishedProductInventoryServes, ProductionDTO model, ProductionModel newModel)
        {
            var fpi = await unitOfWork.FinishedProductInventoryRepository.GetByProuductIdAsync(newModel.ProductId);
            if (fpi == null) throw new Exception("خطأ في جلب بيانات المنتج في المعرض");

        
         
            await purchaseFinishedProductInventoryServes.UpdateAsync(new PurchaseFinishedProductInventoryDTO
            {
                Id = newModel.PFPIM.Id,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now,
                FinishedProductInventoryId = fpi.Id,
                Quantity = (decimal.Parse(model.QuantityProduced.ToString()) - decimal.Parse(model.QuantityDamaged.ToString())),
                ProductionId = newModel.Id,
                PaymentMethod = "none",
                Status = "none",
                TotalPrice = 0,
                UnitPrice = 0,
                UnitOfMeasureId = 1,
                Notes = "عملية انتاج تلقائية مسجلة من النظام ",
                SupplierName = "تصنيع",
                SupplierInvoiceNumber = "تصنيع",

            });
        }


        public async Task UpdateAsync(ProductionDTO model)
        {
            await unitOfWork.BeginTransactionAsync();
            try
            {
              
                var orginalModel = mapper.Map<ProductionModel>(model);
                orginalModel.UpdatedAt = DateTime.Now;
                var tempModel = await unitOfWork.ProductionRepository.GetByIdAsync(model.Id);
                orginalModel.CreatedAt = tempModel.CreatedAt;

                await unitOfWork.ProductionRepository.UpdateAsync(orginalModel);
                var  newModel = await unitOfWork.ProductionRepository.GetProductionWithProductAndIngredientsAsync(model.Id);
                var newWithPFPIM = await unitOfWork.ProductionRepository.GetProductionWithnewWithPFPIMAsync(model.Id);

                   await UpdateToPurchaseFinishedProductInventory(unitOfWork, purchaseFinishedProductInventoryServes, model, newWithPFPIM);
          
                await productionEventsHelpers.RaiseProductionUpdatedEvent(unitOfWork, newModel);
             

                await unitOfWork.SaveChangesAsync();
                    await unitOfWork.CommitAsync();
            


           
                
            }
            catch (Exception ex){ 
                await unitOfWork.RollbackAsync();
                Console.Write(ex.Message + ex.InnerException);
                throw;
            }
        }

        public async Task DeleteAsync(int id)
        {
            await unitOfWork.BeginTransactionAsync();

            try
            {
             var model = await unitOfWork.PurchaseFinishedProductInventoryRepository.GetByProductionIdAsync(id);
                await stockServices.UpdateStockAfterDeleteProductionProcess(id);
                await unitOfWork.ProductionProcessDetailRepository.DeleteWhereProductionIdAsync(id);
                await unitOfWork.ProductionRepository.DeleteAsync(id);
                await purchaseFinishedProductInventoryServes.DeleteAsync(model.Id);
                await unitOfWork.SaveChangesAsync();
                await unitOfWork.CommitAsync();
            }
            catch
            {
                await unitOfWork.RollbackAsync();
                throw;
            }
        }

    

    
        public async Task<IEnumerable<ProductionDTO>> ProductionProcessWithAssociatedProductAsync(int productId)
        {
            var model = await unitOfWork.ProductionRepository.ProductionProcessWithAssociatedProductAsync(productId);



            var newModel = mapper.Map<IEnumerable<ProductionDTO>>(model);



            return newModel;
        }




    }
}

