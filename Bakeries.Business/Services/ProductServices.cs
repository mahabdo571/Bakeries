using AutoMapper;
using Bakeries.Business.Services.IServices;
using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Migrations;
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
    public class ProductServices : IProductServices
    {
        private readonly IProductsRepo _productsRepo;
        private readonly IMapper _mapper;

        public ProductServices(IProductsRepo productsRepo, IMapper mapper)
        {
            _productsRepo = productsRepo;
            _mapper = mapper;
        }


        public async Task<int> AddAsync(ProductDTO model)
        {
            var newModel = _mapper.Map<ProductsModel>(model);

            return await _productsRepo.AddAsync(newModel);
        }

        public async Task DeleteAsync(int id)
        {
         await _productsRepo.DeleteAsync(id);
        }

        public async Task<IEnumerable<ProductDTO>> GetAllAsync()
        {
            var model = await _productsRepo.GetAllAsync(); ;

            var newModel = _mapper.Map<IEnumerable<ProductDTO>>(model);


            return newModel;
        }

        public async Task<ProductDTO> GetByIdAsync(int id)
        {
            return _mapper.Map<ProductDTO>(await _productsRepo.GetByIdAsync(id));

        }

        public async Task UpdateAsync(ProductDTO model)
        {
            await _productsRepo.UpdateAsync(_mapper.Map<ProductsModel>(model));
        }
        public async Task<IEnumerable<ProductDTO>> GetProductsWithComponentsServes() {

            var model = await _productsRepo.GetProductsWithComponents(); ;

            var newModel = _mapper.Map<IEnumerable<ProductDTO>>(model);


            return newModel;
        }


        
    }
}
