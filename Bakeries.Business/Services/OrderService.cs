using AutoMapper;
using Bakeries.Business.Services.IServices;
using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;
using Business.Shared.DTOs;


namespace Bakeries.Business.Services
{
    public class OrderService(IUnitOfWork unitOfWork,IMapper mapper ) : IOrderService
    {
        public async Task<int> AddAsync(OrderDTO model)
        {
            await unitOfWork.BeginTransactionAsync();
            try
            {
                var newModel = mapper.Map<OrderModel>(model);
                newModel.CreatedAt = DateTime.Now;
                newModel.UpdatedAt = DateTime.Now;
                await unitOfWork.OrderRepository.AddAsync(newModel);


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

        public async Task DeleteAsync(int id)
        {
     
            try
            {
             
                
     
                await unitOfWork.OrderRepository.DeleteAsync(id);
         


            }
            catch
            {
              
                throw;
            }
        }

        public async Task<IEnumerable<OrderDTO>> GetAllAsync()
        {
            var model = await unitOfWork.OrderRepository.GetAllAsync(); 

            var newModel = mapper.Map<IEnumerable<OrderDTO>>(model);


            return newModel;
        }    
        
        public async Task<IEnumerable<OrderDTO>> GetAllByDayAsync(DateTime date)
        {
            var model = await unitOfWork.OrderRepository.GetAllByDayAsync(date); 

            var newModel = mapper.Map<IEnumerable<OrderDTO>>(model);


            return newModel;
        }

        public async Task<OrderDTO> GetByIdAsync(int id)
        {
            return mapper.Map<OrderDTO>(await unitOfWork.OrderRepository.GetByIdAsync(id));

        }

        public async Task UpdateAsync(OrderDTO model)
        {
            await unitOfWork.BeginTransactionAsync();
            try
            {
                var newModel = mapper.Map<OrderModel>(model);
                newModel.UpdatedAt = DateTime.Now;

                var temp = await unitOfWork.OrderRepository.GetByIdAsync(newModel.Id);
                newModel.CreatedAt = temp.CreatedAt;
             

                await unitOfWork.OrderRepository.UpdateAsync(newModel);
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
