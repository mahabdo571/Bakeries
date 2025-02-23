using bakerbalzorwebassembly.Models;
using bakerbalzorwebassembly.Services;
using Business.Shared.DTOs;
using Business.Shared.Enums;
using Microsoft.AspNetCore.Components;

namespace bakerbalzorwebassembly.Pages
{
    public partial class ProductComponents : ComponentBase
    {
        protected List<ProductIngredientDTO> MyModel;
        protected List<StockDTO> StockModel;
        protected string searchText = "";
        protected ProductIngredientDTO selectedForDetails;
        protected ProductIngredientAddUpdateDTO selectedForEdit;
        protected ProductIngredientDTO selectedForDelete;
        protected List<ProductIngredientDTO> filteredData;
        protected bool isSaving = false;
        protected string? messageError;

        [Inject]
        protected ProductIngredientService MyService { get; set; }   
        
        [Inject]
        protected StockService stockService { get; set; }

        [Inject]
        protected NavigationMode navigationMode { get; set; }

        protected override async Task OnInitializedAsync()
        {

            await LoadMyData();
            await LoadStock();
        }

        protected async Task LoadMyData()
        {


            MyModel = await MyService.GetAllByProductIdAsync(navigationMode!.productDTO!.Id);
            FilterMyModel();


        }    
        
        protected async Task LoadStock()
        {


            StockModel = await stockService.GetAllAsync();
          


        }


        protected Task Search(string e)
        {
            searchText = e;
            FilterMyModel();
            return Task.CompletedTask;
        }


        protected void FilterMyModel()
        {
            if (string.IsNullOrEmpty(searchText))
            {
                filteredData = MyModel;
            }
            else
            {
                filteredData = MyModel.Where(s => (s?.Notes != null &&
                                                  s.Notes.Contains(searchText, StringComparison.OrdinalIgnoreCase)) ||
                                                  (s?.product.Name != null &&
                                                  s.product.Name.Contains(searchText, StringComparison.OrdinalIgnoreCase))


                                                ).ToList();
            }
        }

        protected List<ProductIngredientDTO> Filtered => filteredData;

        protected void ShowDetails(ProductIngredientDTO model)
        {
            selectedForDetails = model;
        }
        protected void CloseDetails()
        {
            selectedForDetails = null;
        }

        protected void ShowEdit(ProductIngredientDTO model)
        {
            selectedForEdit = new ProductIngredientAddUpdateDTO
            {
                Id = model.Id,
                Notes = model.Notes,
                Quantity=model.Quantity,
                stockId=model.stock!.Id,
                UnitOfMeasure = model.UnitOfMeasure,
                UnitOfMeasureId = model.UnitOfMeasureId,
                

            };
        }

        protected void ShowAddModal()
        {
            selectedForEdit = new ProductIngredientAddUpdateDTO();
        }
        protected void CloseEditModal()
        {
            selectedForEdit = null;
        }
        protected async Task SavePurchases()
        {
            selectedForEdit.UnitOfMeasure = (UnitOfMeasure)selectedForEdit.UnitOfMeasureId;
            selectedForEdit.ProductId = navigationMode.productDTO!.Id;
 
            isSaving = true;
            if (selectedForEdit.Id == 0)
            {
                await MyService.AddAsync(selectedForEdit);

            }
            else
            {

                await MyService.UpdateAsync(selectedForEdit);
            }
            await LoadMyData();

            CloseEditModal();
            isSaving = false;
        }

        protected void ShowDelete(ProductIngredientDTO model)
        {
            selectedForDelete = model;
        }




        protected void CloseDeleteModal()
        {
            selectedForDelete = null;
            messageError = null;
        }
        protected async Task ConfirmDelete()
        {
            isSaving = true;
            var checkError = await MyService.DeleteAsync(selectedForDelete.Id);
            if (checkError is not null)
            {

                messageError = $"{checkError.Message} {checkError.Details}";


            }

            await LoadMyData();
            if (messageError == null)
            {
                CloseDeleteModal();
            }
            isSaving = false;

        }
    }
}
