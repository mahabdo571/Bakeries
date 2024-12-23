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
    public class StockServices : IStockServices
    {
        private readonly IStockRepo _stockRepo;
        private readonly IMapper _mapper;

        public StockServices(IStockRepo stockRepo, IMapper mapper)
        {
            _stockRepo = stockRepo;
            _mapper = mapper;
        }

        public async Task<int> AddStockAsync(StockDTO model)
        {
            var newModel = _mapper.Map<StockModel>(model);

            return await _stockRepo.AddStockAsync(newModel);
        }

        public async Task DeleteStockAsync(int id)
        {
            await _stockRepo.DeleteStockAsync(id);
        }

        public async Task<IEnumerable<StockDTO>> GetAllStockAsync()
        {
            var model = await _stockRepo.GetAllStockAsync(); ;

            var newModel = _mapper.Map<IEnumerable<StockDTO>>(model);


            return newModel;
        }

        public async Task<StockDTO> GetStockByIdAsync(int id)
        {
            return _mapper.Map<StockDTO>(await _stockRepo.GetStockByIdAsync(id));
        }

        public async Task UpdateStockAsync(StockDTO model)
        {
            await _stockRepo.UpdateStockAsync(_mapper.Map<StockModel>(model));
        }
    }
}
