using Business.Shared.DTOs;
using System.Net.Http.Json;

namespace bakerbalzorwebassembly.Services
{
    public class StockService
    {

        private readonly HttpClient _httpClient;

        public StockService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<StockDTO>> GetAllAsync()
        {
            var response = await _httpClient.GetFromJsonAsync<List<StockDTO>>("api/Stock/All");
            return response ?? new List<StockDTO>();
        }


    }
}
