using Bakeries.DataAccess.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Repo.IRepo
{
    public  interface IFinishedProductInventoryRepo : IRepoBase<FinishedProductInventoryModel>
    {
        Task<FinishedProductInventoryModel> GetByProuductIdAsync(int productId);
    }
}
