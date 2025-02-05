using AutoMapper;
using Bakeries.Business.Services.IServices;
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
    public class ProductIngredientService(IUnitOfWork unitOfWork, IMapper mapper) : IProductIngredientService
    {



        public async Task<int> add(ProductIngredientAddUpdateDTO model)
        {
           
            var newModel = mapper.Map<ProductIngredientModel>(model);
            newModel.CreatedAt = DateTime.Now;
            newModel.UpdatedAt = DateTime.Now;
            if (await CheckTheProductComponentIfItExists(model))
            {
                return -2;
            }
            await unitOfWork.ProductIngredientRepository.AddAsync(newModel);
            return newModel.Id;

        }

        private async Task<bool> CheckTheProductComponentIfItExists(ProductIngredientAddUpdateDTO model)
        {

            return await unitOfWork.ProductIngredientRepository.IsIngredientAlreadyAddedAsync(model.ProductId, model.stockId);


        }

        public Task<int> AddAsync(ProductIngredientDTO model)
        {
            return null;
        }

        public async Task DeleteAsync(int id)
        {
            await unitOfWork.ProductIngredientRepository.DeleteAsync(id);
        }

        public async Task<IEnumerable<ProductIngredientDTO>> GetAllAsync()
        {
            var model = await unitOfWork.ProductIngredientRepository.GetAllAsync(); ;

            var newModel = mapper.Map<IEnumerable<ProductIngredientDTO>>(model);


            return newModel;
        }

        public async Task<IEnumerable<ProductIngredientDTO>> GetAllByProductIdAsync(int productId)
        {
            var model = await unitOfWork.ProductIngredientRepository.GetAllByProductIdAsync(productId);



            var newModel = mapper.Map<IEnumerable<ProductIngredientDTO>>(model);



            return newModel;
        }

        public async Task<ProductIngredientDTO> GetByIdAsync(int id)
        {
            return mapper.Map<ProductIngredientDTO>(await unitOfWork.ProductIngredientRepository.GetByIdAsync(id));
        }

        public async Task Update(ProductIngredientAddUpdateDTO model)
        {

            await unitOfWork.BeginTransactionAsync();
            try
            {
           

        
                var mod = mapper.Map<ProductIngredientModel>(model);
                mod.UpdatedAt = DateTime.Now;

                var temp = await unitOfWork.ProductIngredientRepository.GetByIdAsync(model.Id);
                mod.CreatedAt = temp.CreatedAt ;

                await unitOfWork.ProductIngredientRepository.UpdateAsync(mod);

                await unitOfWork.SaveChangesAsync();
                await unitOfWork.CommitAsync();


            }
            catch
            {
                await unitOfWork.RollbackAsync();
                throw;
            }

 

        }

        public async Task UpdateAsync(ProductIngredientDTO model)
        {
  
        
           
            var mod = mapper.Map<ProductIngredientModel>(model);
            mod.UpdatedAt = DateTime.Now;
            await unitOfWork.ProductIngredientRepository.UpdateAsync(mod);
        }
    }
}
