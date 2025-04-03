using Bakeries.DataAccess.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Repo.IRepo
{
    public interface IProductsRepo : IRepoBase<ProductModel>
    {
        Task<IEnumerable<ProductModel>> GetProductsWithComponents();

        Task<int> AddProduct(ProductModel product);
    }
}
