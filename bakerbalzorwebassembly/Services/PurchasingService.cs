using bakerbalzorwebassembly.Models;
using Business.Shared.DTOs;
using System.Net.Http.Json;

namespace bakerbalzorwebassembly.Services
{
    public class PurchasingService
    {
        private readonly HttpClient _httpClient;

        public PurchasingService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<PurchasesDTO>> GetAllAsync()
        {
            var response = await _httpClient.GetFromJsonAsync<List<PurchasesDTO>>("api/Purchases/All");
            return response ?? new List<PurchasesDTO>();
        }      
        
        
        public async Task<List<PurchasesDTO>> GetAllByItemIdAsync(int itemId)
        {
            var response = await _httpClient.GetFromJsonAsync<List<PurchasesDTO>>($"api/Purchases/GetAllByItemId/{itemId}");
            return response ?? new List<PurchasesDTO>();
        }

  
        public async Task<PurchasesDTO> AddAsync(PurchasesDTO newModel)
        {
            Console.WriteLine(newModel);
            var response = await _httpClient.PostAsJsonAsync("api/Purchases", newModel);
          
            if (response.IsSuccessStatusCode)
            {
            
                return await response.Content.ReadFromJsonAsync<PurchasesDTO>();
            }
            return null; 
        }


        public async Task<bool> UpdateAsync(PurchasesDTO updetedModel)
        {
            var response = await _httpClient.PutAsJsonAsync($"api/Purchases/{updetedModel.Id}", updetedModel);
            return response.IsSuccessStatusCode;
        }

        
        public async Task<ApiError?> DeleteAsync(int id)
        {
            var response = await _httpClient.DeleteAsync($"api/Purchases/{id}");
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
