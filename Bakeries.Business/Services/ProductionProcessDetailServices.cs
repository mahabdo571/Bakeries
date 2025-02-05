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
    public class ProductionProcessDetailServices(IUnitOfWork unitOfWork, IMapper mapper) : IProductionProcessDetailService
    {
      
        public async Task<IEnumerable<ProductionProcessDetailDTO>> GetAllByProductionIdAsync(int productionId)
        {
            var model = await unitOfWork.ProductionProcessDetailRepository.GetAllWhereProductionId(productionId);
         
            return mapper.Map<IEnumerable<ProductionProcessDetailDTO>>(model);
            
             


        }
    }
}
