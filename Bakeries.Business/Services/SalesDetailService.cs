using AutoMapper;
using Bakeries.Business.Services.IServices;
using Bakeries.DataAccess;
using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;
using Business.Shared.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.Business.Services
{
    public class SalesDetailService(IUnitOfWork unitOfWork, IMapper mapper) : ISalesDetailService
    {
        public async Task<int> AddAsync(SalesDetailDTO model)
        {
            await unitOfWork.BeginTransactionAsync();
            try
            {
                var newModel = mapper.Map<SalesDetailModel>(model);
                newModel.CreatedAt = DateTime.Now;
                newModel.UpdatedAt = DateTime.Now;

                var isTheItemOnTheInvoice = await unitOfWork.SalesDetailRepository.IsTheItemOnTheInvoice(model.FinishedProductInventoryId);

                if (isTheItemOnTheInvoice is not null)
                {
                    model.Id = isTheItemOnTheInvoice.Id;
                    model.Quantity += isTheItemOnTheInvoice.Quantity;
                    await  UpdateAsync(model);
                }
                else
                {

                    await UpdateInventoryAndOrderAfterAddNewAsync(unitOfWork, model, newModel);
                    await unitOfWork.SalesDetailRepository.AddAsync(newModel);
                }

                

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

        private async Task UpdateInventoryAndOrderAfterAddNewAsync(IUnitOfWork _unitOfWork, SalesDetailDTO model, SalesDetailModel newModel)
        {
            var FPImodel = await _unitOfWork.FinishedProductInventoryRepository.GetByIdAsync(newModel.FinishedProductInventoryId);
            if (FPImodel is not null)
            {

                FPImodel.AvailableQuantity -= newModel.Quantity;
                if (FPImodel.AvailableQuantity < 0)
                {
                    throw new Exception("لقد تجاوزت كمية المنتجات بالمخزن ");
                }
                await _unitOfWork.FinishedProductInventoryRepository.UpdateAsync(FPImodel);

            }
            var order = await _unitOfWork.OrderRepository.GetByIdAsync(newModel.OrderId);
            if (order is not null)
            {
                order.TotalAmount += model.Total;
                order.TotalItems += model.Quantity;
                await _unitOfWork.OrderRepository.UpdateAsync(order);
            }
        }     
        
        
        private async Task UpdateInventoryAndOrderAfterUpdateAsync(IUnitOfWork _unitOfWork, SalesDetailDTO model ,SalesDetailModel oldModel )
        {
            var FPImodel = await _unitOfWork.FinishedProductInventoryRepository.GetByIdAsync(model.FinishedProductInventoryId);
            if (FPImodel is not null)
            {
                FPImodel.AvailableQuantity += oldModel.Quantity - model.Quantity;

                if (FPImodel.AvailableQuantity < 0)
                {
                    throw new Exception("لقد تجاوزت كمية المنتجات بالمخزن ");
                }
                await _unitOfWork.FinishedProductInventoryRepository.UpdateAsync(FPImodel);

            }
            var order = await _unitOfWork.OrderRepository.GetByIdAsync(model.OrderId);
            if (order is not null)
            {

        order.TotalAmount += model.Total - getTotalAmount(oldModel);
                order.TotalItems +=  model.Quantity - oldModel.Quantity ;
                await _unitOfWork.OrderRepository.UpdateAsync(order);
            }
        }

        private decimal getTotalAmount(SalesDetailModel model)
        {
            if(model is not null)
            return ((model.UnitPrice * model.Quantity) - (model.Discount * 100));

            return -1;
        }

        private async Task UpdateInventoryAndOrderAfterDeleteAsync(IUnitOfWork _unitOfWork, int id)
        {
            var model = await _unitOfWork.SalesDetailRepository.GetByIdAsync(id);
            if(model is null)
            {
                throw new Exception("عنصر غير موجود");
            }
            var FPImodel = await _unitOfWork.FinishedProductInventoryRepository.GetByIdAsync(model.FinishedProductInventoryId);
            if (FPImodel is not null)
            {
                FPImodel.AvailableQuantity +=  model.Quantity;

         
                await _unitOfWork.FinishedProductInventoryRepository.UpdateAsync(FPImodel);

            }
            var order = await _unitOfWork.OrderRepository.GetByIdAsync(model.OrderId);
            if (order is not null)
            {

                order.TotalAmount -=  getTotalAmount(model);
                order.TotalItems -= model.Quantity ;
                await _unitOfWork.OrderRepository.UpdateAsync(order);
            }
        }

        public async Task DeleteAsync(int id)
        {
            await unitOfWork.BeginTransactionAsync();
            try
            {
                await UpdateInventoryAndOrderAfterDeleteAsync(unitOfWork, id);
                await unitOfWork.SalesDetailRepository.DeleteAsync(id);
                await unitOfWork.SaveChangesAsync();
                await unitOfWork.CommitAsync();


            }
            catch
            {
                await unitOfWork.RollbackAsync();
                throw;
            }
        }

        public async Task<IEnumerable<SalesDetailDTO>> GetAllAsync()
        {
            var model = await unitOfWork.SalesDetailRepository.GetAllAsync(); ;

            var newModel = mapper.Map<IEnumerable<SalesDetailDTO>>(model);


            return newModel;
        }

        public async Task<IEnumerable<SalesDetailDTO>> GetAllByOrderIdAsync(int orderId)
        {
            var model = await unitOfWork.SalesDetailRepository.GetAllByOrderIdAsync(orderId); ;

            var newModel = mapper.Map<IEnumerable<SalesDetailDTO>>(model);


            return newModel;
        }

        public async Task<SalesDetailDTO> GetByIdAsync(int id)
        {
            return mapper.Map<SalesDetailDTO>(await unitOfWork.SalesDetailRepository.GetByIdAsync(id));
        }

        public async Task UpdateAsync(SalesDetailDTO model)
        {
            await unitOfWork.BeginTransactionAsync();
            try
            {
                var newModel = mapper.Map<SalesDetailModel>(model);
                newModel.UpdatedAt = DateTime.Now;

                var temp = await unitOfWork.SalesDetailRepository.GetByIdAsync(newModel.Id);
                newModel.CreatedAt = temp.CreatedAt;
                await UpdateInventoryAndOrderAfterUpdateAsync(unitOfWork, model, temp);

                await unitOfWork.SalesDetailRepository.UpdateAsync(newModel);
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
