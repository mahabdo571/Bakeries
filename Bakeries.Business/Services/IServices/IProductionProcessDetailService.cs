using Bakeries.DataAccess.Entities;
using Business.Shared.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.Business.Services.IServices
{
    public  interface IProductionProcessDetailService 
    {
        Task<IEnumerable<ProductionProcessDetailDTO>> GetAllByProductionIdAsync(int productionId);


    }
}
