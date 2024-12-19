using Bakeries.DataAccess.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Repo.IRepo
{
    public interface IPurchasesRepo
    {
        Task<IEnumerable<PurchasesModel>> GetAllPurchasesAsync();
        Task<PurchasesModel> GetPurchasesByIdAsync(int id);
        Task<int> AddPurchasesAsync(PurchasesModel model);
        Task UpdatePurchasesAsync(PurchasesModel model);
        Task DeletePurchasesAsync(int id);
    }
}
