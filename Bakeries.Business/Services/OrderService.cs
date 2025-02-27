using AutoMapper;
using Bakeries.Business.Services.IServices;
using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;
using Business.Shared.DTOs;


namespace Bakeries.Business.Services
{
    public class OrderService(IUnitOfWork unitOfWork,IMapper mapper) : IOrderService
    {
        public async Task<int> AddAsync(OrderDTO model)
        {
            await unitOfWork.BeginTransactionAsync();
            try
            {
                var newModel = mapper.Map<OrderModel>(model);
                newModel.CreatedAt = DateTime.Now;
                newModel.UpdatedAt = DateTime.Now;
                await unitOfWork.dailySaleRepository.AddAsync(newModel);


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
            await unitOfWork.BeginTransactionAsync();
            try
            {
                await unitOfWork.dailySaleRepository.DeleteAsync(id);
                await unitOfWork.SaveChangesAsync();
                await unitOfWork.CommitAsync();


            }
            catch
            {
                await unitOfWork.RollbackAsync();
                throw;
            }
        }

        public async Task<IEnumerable<OrderDTO>> GetAllAsync()
        {
            var model = await unitOfWork.dailySaleRepository.GetAllAsync(); ;

            var newModel = mapper.Map<IEnumerable<OrderDTO>>(model);


            return newModel;
        }

        public async Task<OrderDTO> GetByIdAsync(int id)
        {
            return mapper.Map<OrderDTO>(await unitOfWork.dailySaleRepository.GetByIdAsync(id));

        }

        public async Task UpdateAsync(OrderDTO model)
        {
            await unitOfWork.BeginTransactionAsync();
            try
            {
                var newModel = mapper.Map<OrderModel>(model);
                newModel.UpdatedAt = DateTime.Now;

                var temp = await unitOfWork.dailySaleRepository.GetByIdAsync(newModel.Id);
                newModel.CreatedAt = temp.CreatedAt;
             

                await unitOfWork.dailySaleRepository.UpdateAsync(newModel);
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
