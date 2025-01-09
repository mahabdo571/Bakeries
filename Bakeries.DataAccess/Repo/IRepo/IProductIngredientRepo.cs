using Bakeries.DataAccess.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Repo.IRepo
{
    public interface IProductIngredientRepo : IRepoBase<ProductIngredientModel>
    {
        Task<IEnumerable<ProductIngredientModel>> GetAllByProductIdAsync(int productId);
        Task<bool> IsIngredientAlreadyAddedAsync(int productId, int stockId);
    }
}
