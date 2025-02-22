

using Business.Shared.DTOs;

namespace Bakeries.Business.Services.IServices
{
    public interface IPurchasesServices  :IServices<PurchasesDTO>
    {
        Task<IEnumerable<PurchasesDTO>> GetAllPurchasesWithItemDetailsAsync();
        Task<IEnumerable<PurchasesDTO>> GetAllByItemIdAsync(int itemId);
        Task<IEnumerable<CombinedPurchaseDTO>> GetAllCombinedPurchaseAsync();
    }
}
