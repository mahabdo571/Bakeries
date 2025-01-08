using Business.Shared.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.Business.Services.IServices
{
    public interface IProductIngredientService : IServices<ProductIngredientDTO>
    {
        Task<IEnumerable<ProductIngredientDTO>> GetAllByProductIdAsync(int productId);

        Task<int> add(ProductIngredientAddUpdateDTO model);
        Task Update(ProductIngredientAddUpdateDTO model);

    }
}
