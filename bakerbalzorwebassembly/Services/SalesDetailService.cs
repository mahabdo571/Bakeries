using bakerbalzorwebassembly.Models;
using Business.Shared.DTOs;
using System.Net.Http.Json;

namespace bakerbalzorwebassembly.Services
{
    public class SalesDetailService
    {
      private readonly HttpClient _httpClient;

    public SalesDetailService(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<IQueryable<SalesDetailDTO>> GetAllByOrderId(int orderId)
    {
        var response = await _httpClient.GetFromJsonAsync<List<SalesDetailDTO>>($"api/SalesDetail/GetAllByOrderId/{orderId}");
        return response is not null ? response.AsQueryable<SalesDetailDTO>() : new List<SalesDetailDTO>().AsQueryable<SalesDetailDTO>();
    }




    public async Task<SalesDetailDTO> AddAsync(SalesDetailDTO newModel)
    {
        Console.WriteLine(newModel);
        var response = await _httpClient.PostAsJsonAsync("api/SalesDetail", newModel);

        if (response.IsSuccessStatusCode)
        {

            return await response.Content.ReadFromJsonAsync<SalesDetailDTO>();
        }
        return null;
    }


    public async Task<bool> UpdateAsync(SalesDetailDTO updetedModel)
    {
        var response = await _httpClient.PutAsJsonAsync($"api/SalesDetail/{updetedModel.Id}", updetedModel);
        return response.IsSuccessStatusCode;
    }


    public async Task<ApiError?> DeleteAsync(int id)
    {
        var response = await _httpClient.DeleteAsync($"api/SalesDetail/{id}");
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
