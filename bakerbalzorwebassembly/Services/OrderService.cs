using bakerbalzorwebassembly.Models;
using Business.Shared.DTOs;
using System.Net.Http.Json;

namespace bakerbalzorwebassembly.Services
{
    public class OrderService
    {

        private readonly HttpClient _httpClient;

        public OrderService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<OrderDTO>> GetAllAsync()
        {
            var response = await _httpClient.GetFromJsonAsync<List<OrderDTO>>("api/Order/All");
            return response ?? new List<OrderDTO>();
        }




        public async Task<OrderDTO> AddAsync(OrderDTO newModel)
        {
            Console.WriteLine(newModel);
            var response = await _httpClient.PostAsJsonAsync("api/Order", newModel);

            if (response.IsSuccessStatusCode)
            {

                return await response.Content.ReadFromJsonAsync<OrderDTO>();
            }
            return null;
        }


        public async Task<bool> UpdateAsync(OrderDTO updetedModel)
        {
            var response = await _httpClient.PutAsJsonAsync($"api/Order/{updetedModel.Id}", updetedModel);
            return response.IsSuccessStatusCode;
        }


        public async Task<ApiError?> DeleteAsync(int id)
        {
            var response = await _httpClient.DeleteAsync($"api/Order/{id}");
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

