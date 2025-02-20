using bakerbalzorwebassembly.Models;
using Business.Shared.DTOs;
using System.Net.Http.Json;

namespace bakerbalzorwebassembly.Services
{
    public class PurchaseFinishedProductInventoryService
    {
        private readonly HttpClient _httpClient;

        public PurchaseFinishedProductInventoryService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<PurchaseFinishedProductInventoryDTO>> GetAllAsync()
        {
            var response = await _httpClient.GetFromJsonAsync<List<PurchaseFinishedProductInventoryDTO>>("api/PurchaseFinishedProductInventory/All");
            return response ?? new List<PurchaseFinishedProductInventoryDTO>();
        }

        public async Task<PurchaseFinishedProductInventoryDTO> AddAsync(PurchaseFinishedProductInventoryDTO newStock)
        {
            var response = await _httpClient.PostAsJsonAsync("api/PurchaseFinishedProductInventory", newStock);
            if (response.IsSuccessStatusCode)
            {

                return await response.Content.ReadFromJsonAsync<PurchaseFinishedProductInventoryDTO>();
            }
            return null;
        }
        public async Task<List<PurchaseFinishedProductInventoryDTO>> GetAllByItemIdAsync(int itemId)
        {
            var response = await _httpClient.GetFromJsonAsync<List<PurchaseFinishedProductInventoryDTO>>($"api/PurchaseFinishedProductInventory/GetAllByItemId/{itemId}");
            return response ?? new List<PurchaseFinishedProductInventoryDTO>();
        }
        public async Task<bool> UpdateAsync(PurchaseFinishedProductInventoryDTO updatedStock)
        {
            var response = await _httpClient.PutAsJsonAsync($"api/PurchaseFinishedProductInventory/{updatedStock.Id}", updatedStock);
            return response.IsSuccessStatusCode;
        }


        public async Task<ApiError?> DeleteAsync(int id)
        {
            var response = await _httpClient.DeleteAsync($"api/PurchaseFinishedProductInventory/{id}");
            if (!response.IsSuccessStatusCode)
            {
                var apiError = await response.Content.ReadFromJsonAsync<ApiError>();
                if (apiError != null)
                {
                    return apiError;
                }
            }

            return null;
        }

    }
}
