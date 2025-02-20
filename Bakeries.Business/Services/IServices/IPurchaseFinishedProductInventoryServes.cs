
using Business.Shared.DTOs;


namespace Bakeries.Business.Services.IServices
{
    public interface IPurchaseFinishedProductInventoryServes : IServices<PurchaseFinishedProductInventoryDTO>
    {
        Task<IEnumerable<PurchaseFinishedProductInventoryDTO>> GetAllByItemIdAsync(int itemId);
        
        }
}
