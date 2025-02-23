using bakerbalzorwebassembly.Models;
using Business.Shared.DTOs;
using System.Net.Http.Json;

namespace bakerbalzorwebassembly.Services
{
    public class ProductIngredientService
    {
        private readonly HttpClient _httpClient;

        public ProductIngredientService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<ProductIngredientDTO>> GetAllByProductIdAsync(int productId)
        {
            var response = await _httpClient.GetFromJsonAsync<List<ProductIngredientDTO>>($"api/ProductIngredient/GetAllByProductId/{productId}");
            return response ?? new List<ProductIngredientDTO>();
        }


        public async Task<ProductIngredientAddUpdateDTO> AddAsync(ProductIngredientAddUpdateDTO newStock)
        {
            var response = await _httpClient.PostAsJsonAsync("api/ProductIngredient", newStock);
            if (response.IsSuccessStatusCode)
            {

                return await response.Content.ReadFromJsonAsync<ProductIngredientAddUpdateDTO>();
            }
            return null;
        }


        public async Task<bool> UpdateAsync(ProductIngredientAddUpdateDTO updatedStock)
        {
            var response = await _httpClient.PutAsJsonAsync($"api/ProductIngredient/{updatedStock.Id}", updatedStock);
            return response.IsSuccessStatusCode;
        }


        public async Task<ApiError?> DeleteAsync(int id)
        {
            var response = await _httpClient.DeleteAsync($"api/ProductIngredient/{id}");
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
