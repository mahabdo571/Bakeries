using bakerbalzorwebassembly.Models;
using Business.Shared.DTOs;
using System.Net.Http.Json;

namespace bakerbalzorwebassembly.Services
{
    public class FinishedGoodsProductService
    {
        private readonly HttpClient _httpClient;

        public FinishedGoodsProductService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<ProductDTO>> GetAllAsync()
        {
            var response = await _httpClient.GetFromJsonAsync<List<ProductDTO>>("api/Product/All");
            return response ?? new List<ProductDTO>();
        }




        public async Task<ProductDTO> AddAsync(ProductDTO newModel)
        {
            Console.WriteLine(newModel);
            var response = await _httpClient.PostAsJsonAsync("api/Product", newModel);

            if (response.IsSuccessStatusCode)
            {

                return await response.Content.ReadFromJsonAsync<ProductDTO>();
            }
            return null;
        }


        public async Task<bool> UpdateAsync(ProductDTO updetedModel)
        {
            var response = await _httpClient.PutAsJsonAsync($"api/Product/{updetedModel.Id}", updetedModel);
            return response.IsSuccessStatusCode;
        }


        public async Task<ApiError?> DeleteAsync(int id)
        {
            var response = await _httpClient.DeleteAsync($"api/Product/{id}");
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
