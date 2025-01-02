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
    public class ProductIngredientService : IProductIngredientService
    {

        private readonly IProductIngredientRepo _productIngredientRepo;
        private readonly IMapper _mapper;

        public ProductIngredientService(IProductIngredientRepo productIngredientRepo, IMapper mapper)
        {
            _productIngredientRepo = productIngredientRepo;
            _mapper = mapper;
        }


        public async Task<int> AddAsync(ProductIngredientDTO model)
        {
            var newModel = _mapper.Map<ProductIngredientModel>(model);

            return await _productIngredientRepo.AddAsync(newModel);
        }

        public async Task DeleteAsync(int id)
        {
            await _productIngredientRepo.DeleteAsync(id);
        }

        public async Task<IEnumerable<ProductIngredientDTO>> GetAllAsync()
        {
            var model = await _productIngredientRepo.GetAllAsync(); ;

            var newModel = _mapper.Map<IEnumerable<ProductIngredientDTO>>(model);


            return newModel;
        }

        public async Task<IEnumerable<ProductIngredientDTO>> GetAllByProductIdAsync(int productId)
        {
            var model = await _productIngredientRepo.GetAllByProductIdAsync(productId); ;

            var newModel = _mapper.Map<IEnumerable<ProductIngredientDTO>>(model);


            return newModel;
        }

        public async Task<ProductIngredientDTO> GetByIdAsync(int id)
        {
            return _mapper.Map<ProductIngredientDTO>(await _productIngredientRepo.GetByIdAsync(id));
        }

        public async Task UpdateAsync(ProductIngredientDTO model)
        {
            await _productIngredientRepo.UpdateAsync(_mapper.Map<ProductIngredientModel>(model));
        }
    }
}
