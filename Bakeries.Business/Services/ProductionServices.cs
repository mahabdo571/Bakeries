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
               
                var fpi =await unitOfWork.FinishedProductInventoryRepository.GetByProuductIdAsync(newModel.ProductId);
                if (fpi == null) throw new Exception("خطأ في جلب بيانات المنتج في المعرض");
                await purchaseFinishedProductInventoryServes.AddAsync(new PurchaseFinishedProductInventoryDTO
                {
                    CreatedAt = DateTime.Now,
                    UpdatedAt = DateTime.Now,
                    FinishedProductInventoryId = fpi.Id,
                    Quantity = (decimal.Parse(model.QuantityProduced.ToString()) - decimal.Parse(model.QuantityDamaged.ToString())),
                    IsReceivingProduction = true,
                    PaymentMethod = "none",
                    Status = "none",
                    TotalPrice = 0,
                    UnitPrice = 0,
                    UnitOfMeasureId = 1,
                    Notes = "عملية انتاج تلقائية مسجلة من النظام ",
                    SupplierName="تصنيع",
                    SupplierInvoiceNumber="تصنيع",            

                });
                await productionEventsHelpers.RaiseProductionAddedEvent(unitOfWork, newModel);

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

    

    
        public async Task<IEnumerable<ProductionDTO>> ProductionProcessWithAssociatedProductAsync(int productId)
        {
            var model = await unitOfWork.ProductionRepository.ProductionProcessWithAssociatedProductAsync(productId);



            var newModel = mapper.Map<IEnumerable<ProductionDTO>>(model);



            return newModel;
        }




    }
}

