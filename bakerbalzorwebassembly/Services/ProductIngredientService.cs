using bakerbalzorwebassembly.Models;
using Business.Shared.DTOs;
using System.Net.Http.Json;

namespace bakerbalzorwebassembly.Services
{
    public class ProductIngredientService
    {
        //private readonly HttpClient _httpClient;

        //public ProductIngredientService(HttpClient httpClient)
        //{
        //    _httpClient = httpClient;
        //}

        //public async Task<List<StockDTO>> GetAllAsync()
        //{
        //    var response = await _httpClient.GetFromJsonAsync<List<StockDTO>>("api/Stock/All");
        //    return response ?? new List<StockDTO>();
        //}


        //public async Task<StockDTO> AddAsync(StockDTO newStock)
        //{
        //    var response = await _httpClient.PostAsJsonAsync("api/Stock", newStock);
        //    if (response.IsSuccessStatusCode)
        //    {

        //        return await response.Content.ReadFromJsonAsync<StockDTO>();
        //    }
        //    return null;
        //}


        //public async Task<bool> UpdateAsync(StockDTO updatedStock)
        //{
        //    var response = await _httpClient.PutAsJsonAsync($"api/Stock/{updatedStock.Id}", updatedStock);
        //    return response.IsSuccessStatusCode;
        //}


        //public async Task<ApiError?> DeleteAsync(int id)
        //{
        //    var response = await _httpClient.DeleteAsync($"api/Stock/{id}");
        //    if (!response.IsSuccessStatusCode)
        //    {
        //        var apiError = await response.Content.ReadFromJsonAsync<ApiError>();
        //        if (apiError != null)
        //        {
        //            return apiError;
        //        }
        //    }

        //    return null;
        //}

    }
}
