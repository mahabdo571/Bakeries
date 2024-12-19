using AutoMapper;
using Bakeries.Business.Services.IServices;
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
    public class PurchasesServices : IPurchasesServices
    {
        private readonly IPurchasesRepo _purchasesRepo;
        private readonly IMapper _mapper;

        public PurchasesServices(IPurchasesRepo purchasesRepo, IMapper mapper)
        {
            _purchasesRepo = purchasesRepo;
            _mapper = mapper;
        }



        public async Task<int> AddPurchasesAsync(PurchasesDTO model)
        {
            var newModel = _mapper.Map<PurchasesModel>(model);

            return await _purchasesRepo.AddPurchasesAsync(newModel);

        }

        public async Task DeletePurchasesAsync(int id)
        {
           await _purchasesRepo.DeletePurchasesAsync(id);
        }

        public async Task<IEnumerable<PurchasesDTO>> GetAllPurchasesAsync()
        {
            var model = await _purchasesRepo.GetAllPurchasesAsync(); ;

            var newModel = _mapper.Map<IEnumerable<PurchasesDTO>>(model);


            return newModel;
        }

        public async Task<PurchasesDTO> GetPurchasesByIdAsync(int id)
        {
            return _mapper.Map<PurchasesDTO>(await _purchasesRepo.GetPurchasesByIdAsync(id));
        }

        public async Task UpdatePurchasesAsync(PurchasesDTO model)
        {
            await _purchasesRepo.UpdatePurchasesAsync(_mapper.Map<PurchasesModel>(model));
        }
    }
}
