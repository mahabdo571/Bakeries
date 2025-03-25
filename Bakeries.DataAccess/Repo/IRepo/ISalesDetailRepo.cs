using Bakeries.DataAccess.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Repo.IRepo
{
    public interface ISalesDetailRepo : IRepoBase<SalesDetailModel>
    {
        Task<IEnumerable<SalesDetailModel>> GetAllByOrderIdAsync(int orderId);
        Task<SalesDetailModel> IsTheItemOnTheInvoice(int FinishedProductInventoryId);
        
    }
}
