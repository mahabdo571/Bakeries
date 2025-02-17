
using Business.Shared.DTOs;
using bakerbalzorwebassembly.Services;
using Microsoft.AspNetCore.Components;
using Business.Shared.Enums;


namespace bakerbalzorwebassembly.Pages
{
    public partial class Stock : ComponentBase
    {
        // المتغيرات
        protected List<StockDTO> stockModel;
        protected string searchText = "";
        protected StockDTO selectedStockForDetails;
        protected StockDTO selectedStockForEdit;
        protected StockDTO selectedStockForDelete;
        protected List<StockDTO> filteredStocks;
        protected bool isSaving = false;
        protected string? messageError;

        [Inject]
        protected StockService stockService { get; set; }

        protected override async Task OnInitializedAsync()
        {
            await LoadStocks();
        }

        // دالة تحميل البيانات
        protected async Task LoadStocks()
        {
          
            stockModel = await stockService.GetAllAsync();
            FilterStocks(); // يتم تصفية البيانات فور تحميلها

            
        }

        // دالة البحث والتصفية حسب النص المكتوب
        protected void SearchStocks(string e)
        {
            searchText =e;
            FilterStocks(); // يتم تصفية البيانات مباشرة عند الكتابة
        }

        // دالة تصفية البيانات حسب النص
        protected void FilterStocks()
        {
            if (string.IsNullOrEmpty(searchText))
            {
                filteredStocks = stockModel;
            }
            else
            {
                filteredStocks = stockModel.Where(s => s.ItemName != null &&
                                                s.ItemName.Contains(searchText, StringComparison.OrdinalIgnoreCase)).ToList();
            }
        }

        protected List<StockDTO> FilteredStocks => filteredStocks;

        protected void ShowDetails(StockDTO stock)
        {
            selectedStockForDetails = stock;
        }
        protected void CloseDetails()
        {
            selectedStockForDetails = null;
        }

        protected void ShowEdit(StockDTO stock)
        {
            selectedStockForEdit = new StockDTO
            {
                Id = stock.Id,
                ItemName = stock.ItemName,
                AvailableQuantity = stock.AvailableQuantity,
                UnitOfMeasure = stock.UnitOfMeasure,
                ReorderLevel = stock.ReorderLevel,
                Location = stock.Location,
                Notes = stock.Notes,
                CreatedAt = stock.CreatedAt,
                UpdatedAt = stock.UpdatedAt
            };
        }

        protected void ShowAddModal()
        {
            selectedStockForEdit = new StockDTO();
        }
        protected void CloseEditModal()
        {
            selectedStockForEdit = null;
        }
        protected async Task SaveStock()
        {
            selectedStockForEdit.UnitOfMeasure = (UnitOfMeasure)selectedStockForEdit.UnitOfMeasureId;

            isSaving = true;
            if (selectedStockForEdit.Id == 0)
            {
                await stockService.AddAsync(selectedStockForEdit);

            }
            else
            {

                await stockService.UpdateAsync(selectedStockForEdit);
            }
            await LoadStocks();

            CloseEditModal();
            isSaving = false;
        }

        protected void ShowDelete(StockDTO stock)
        {
            selectedStockForDelete = stock;
        }
        protected void CloseDeleteModal()
        {
            selectedStockForDelete = null;
            messageError = null;
        }
        protected async Task ConfirmDelete()
        {
            isSaving = true;
            var checkError = await stockService.DeleteAsync(selectedStockForDelete.Id);
           if (checkError is not null)
         {

                messageError = $"{checkError.Message} {checkError.Details}";
            
            
            }

            await LoadStocks();
           if( messageError == null)
            {
                CloseDeleteModal();
            } 
            isSaving = false;

        }
    }
}
