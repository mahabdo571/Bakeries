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

        public async Task<int> AddAsync(StockDTO model)
        {
            var newModel = _mapper.Map<StockModel>(model);

             await _stockRepo.AddAsync(newModel);
            return newModel.Id;
        }

        public async Task DeleteAsync(int id)
        {
            try
            {
                await _stockRepo.DeleteAsync(id);
            }catch(Exception e)
            {
                throw e;
            }

            }

        public async Task<IEnumerable<StockDTO>> GetAllAsync()
        {
            var model = await _stockRepo.GetAllAsync(); ;

            var newModel = _mapper.Map<IEnumerable<StockDTO>>(model);


            return newModel;
        }

        public async Task<StockDTO> GetByIdAsync(int id)
        {
            return _mapper.Map<StockDTO>(await _stockRepo.GetByIdAsync(id));
        }

        public async Task UpdateAsync(StockDTO model)
        {
            await _stockRepo.UpdateAsync(_mapper.Map<StockModel>(model));
        }
    }
}
