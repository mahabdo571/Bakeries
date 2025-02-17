using bakerbalzorwebassembly.Models;
using Business.Shared.DTOs;
using System.Net.Http.Json;

namespace bakerbalzorwebassembly.Services
{
    public class FinishedProductInventoryService
    {
        private readonly HttpClient _httpClient;

        public FinishedProductInventoryService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<FinishedProductInventoryDTO>> GetAllAsync()
        {
            var response = await _httpClient.GetFromJsonAsync<List<FinishedProductInventoryDTO>>("api/FinishedProductInventory/All");
            return response ?? new List<FinishedProductInventoryDTO>();
        }


        public async Task<FinishedProductInventoryDTO> AddAsync(FinishedProductInventoryDTO newFinishedProductInventory)
        {
            var response = await _httpClient.PostAsJsonAsync("api/FinishedProductInventory", newFinishedProductInventory);
            if (response.IsSuccessStatusCode)
            {

                return await response.Content.ReadFromJsonAsync<FinishedProductInventoryDTO>();
            }
            return null;
        }


        public async Task<bool> UpdateAsync(FinishedProductInventoryDTO updatedFinishedProductInventory)
        {
            var response = await _httpClient.PutAsJsonAsync($"api/FinishedProductInventory/{updatedFinishedProductInventory.Id}", updatedFinishedProductInventory);
            return response.IsSuccessStatusCode;
        }


        public async Task<ApiError?> DeleteAsync(int id)
        {
            var response = await _httpClient.DeleteAsync($"api/FinishedProductInventory/{id}");
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
