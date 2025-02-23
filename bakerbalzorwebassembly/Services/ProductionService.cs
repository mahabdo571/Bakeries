using bakerbalzorwebassembly.Models;
using Business.Shared.DTOs;
using System.Net.Http.Json;

namespace bakerbalzorwebassembly.Services
{
    public class ProductionService
    {
        private readonly HttpClient _httpClient;

        public ProductionService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<ProductionDTO>> GetAllbyProductAsync(int productId)
        {
            var response = await _httpClient.GetFromJsonAsync<List<ProductionDTO>>($"api/ProductionProcessWithAssociatedProduct/{productId}");
            return response ?? new List<ProductionDTO>();
        }


        public async Task<ProductionDTO> AddAsync(ProductionDTO newProduction)
        {
            var response = await _httpClient.PostAsJsonAsync("api/Production", newProduction);
            if (response.IsSuccessStatusCode)
            {

                return await response.Content.ReadFromJsonAsync<ProductionDTO>();
            }
            return null;
        }


        public async Task<bool> UpdateAsync(ProductionDTO updatedProduction)
        {
            var response = await _httpClient.PutAsJsonAsync($"api/Production/{updatedProduction.Id}", updatedProduction);
            return response.IsSuccessStatusCode;
        }


        public async Task<ApiError?> DeleteAsync(int id)
        {
            var response = await _httpClient.DeleteAsync($"api/Production/{id}");
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
