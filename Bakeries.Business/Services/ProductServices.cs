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
    public class ProductServices : IProductServices
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;

        public ProductServices(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
        }


        public async Task<int> AddAsync(ProductDTO model)
        {
            await _unitOfWork.BeginTransactionAsync();
            try
            {
                var newModel = _mapper.Map<ProductModel>(model);
            newModel.CreatedAt = DateTime.Now;
            newModel.UpdatedAt = DateTime.Now;

             await _unitOfWork.ProductRepository.AddAsync(newModel);

             await _unitOfWork.FinishedProductInventoryRepository.AddAsync(new FinishedProductInventoryModel
                {
                    CreatedAt = DateTime.Now,
                    UpdatedAt = DateTime.Now,
                    ItemName = model.Name,
                    Notes = model.Notes,
                    ProductId = newModel.Id,
                    CostPrice = model.Price,
                    UnitOfMeasure = (int)model.UnitOfMeasure,
                    Discount=0,
                    UnitPriceForPeople=0,
                    UnitPriceForResellers=0,
                    Location="-",
                    Tax=0,
                    UniPtriceForDealers=0,
                    ReorderLevel=0,
                    AvailableQuantity=0,
                    Code="-",
  
                });


                await _unitOfWork.SaveChangesAsync();
                await _unitOfWork.CommitAsync();

                return newModel.Id;
            }
            catch
            {
                await _unitOfWork.RollbackAsync();
                throw;
            }
        }

        public async Task DeleteAsync(int id)
        {
            await _unitOfWork.BeginTransactionAsync();
            try
            {
                await _unitOfWork.ProductRepository.DeleteAsync(id);
                await _unitOfWork.SaveChangesAsync();
                await _unitOfWork.CommitAsync();

           
            }
            catch
            {
                await _unitOfWork.RollbackAsync();
                throw;
            }
        }

        public async Task<IEnumerable<ProductDTO>> GetAllAsync()
        {
            var model = await _unitOfWork.ProductRepository.GetAllAsync(); ;

            var newModel = _mapper.Map<IEnumerable<ProductDTO>>(model);


            return newModel;
        }

        public async Task<ProductDTO> GetByIdAsync(int id)
        {
            return _mapper.Map<ProductDTO>(await _unitOfWork.ProductRepository.GetByIdAsync(id));

        }

        public async Task UpdateAsync(ProductDTO model)
        {
            var newModel = _mapper.Map<ProductModel>(model);
            newModel.UpdatedAt = DateTime.Now;

            var temp  =  await _unitOfWork.ProductRepository.GetByIdAsync(model.Id);
            newModel.CreatedAt = temp.CreatedAt;

            await _unitOfWork.ProductRepository.UpdateAsync(newModel);
        }
        public async Task<IEnumerable<ProductDTO>> GetProductsWithComponentsServes() {

            var model = await _unitOfWork.ProductRepository.GetProductsWithComponents(); ;

            var newModel = _mapper.Map<IEnumerable<ProductDTO>>(model);


            return newModel;
        }


        
    }
}
