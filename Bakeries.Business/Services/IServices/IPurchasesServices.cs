

using Business.Shared.DTOs;

namespace Bakeries.Business.Services.IServices
{
    public interface IPurchasesServices
    {
        Task<IEnumerable<PurchasesDTO>> GetAllPurchasesWithItemDetailsAsync();
        Task<PurchasesDTO> GetPurchasesByIdAsync(int id);
        Task<int> AddPurchasesAsync(PurchasesDTO model);
        Task UpdatePurchasesAsync(PurchasesDTO model);
        Task DeletePurchasesAsync(int id);
    }
}
