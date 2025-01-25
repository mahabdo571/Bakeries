using Business.Shared.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.Business.Services.IServices
{
    public interface IStockServices : IServices<StockDTO>
    {
         Task UpdateStockAfterDeleteProductionProcess(int productionProcessId);

    }
}
