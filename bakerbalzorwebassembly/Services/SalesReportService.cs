using Business.Shared.DTOs;
using System.Linq;
using System.Net.Http.Json;

namespace bakerbalzorwebassembly.Services
{
    public class SalesReportService
    {
        private readonly HttpClient _httpClient;

        public SalesReportService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<SalesReportDTO>> GetAsync(DateTime start ,DateTime end)
        {
            var response = await _httpClient.GetFromJsonAsync<List<SalesReportDTO>>($"api/SalesReport?strtDate={start}&endDate={end}");
            return response is not null ? response : new List<SalesReportDTO>();
        }

    }
}
