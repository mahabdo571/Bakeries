using bakerbalzorwebassembly.Models;
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

        // لإضافة بيانات جديدة
        public async Task<StockDTO> AddAsync(StockDTO newStock)
        {
            var response = await _httpClient.PostAsJsonAsync("api/Stock", newStock);
            if (response.IsSuccessStatusCode)
            {
                // قراءة الكائن المضاف (ممكن يرجع الـ DTO مع البيانات المحدثة مثل الـ Id)
                return await response.Content.ReadFromJsonAsync<StockDTO>();
            }
            return null; // أو تعالج الخطأ حسب الحاجة
        }

        // لتحديث بيانات موجودة
        public async Task<bool> UpdateAsync(StockDTO updatedStock)
        {
            var response = await _httpClient.PutAsJsonAsync($"api/Stock/{updatedStock.Id}", updatedStock);
            return response.IsSuccessStatusCode;
        }

        // لحذف بيانات بناءً على المعرف
        public async Task<ApiError?> DeleteAsync(int id)
        {
            var response = await _httpClient.DeleteAsync($"api/Stock/{id}");
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
