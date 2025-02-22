using bakerbalzorwebassembly.Models;
using bakerbalzorwebassembly.Services;
using Business.Shared.DTOs;
using Business.Shared.Enums;
using Microsoft.AspNetCore.Components;

namespace bakerbalzorwebassembly.Pages
{
    public partial class FinishedGoodsProduct : ComponentBase
    {

        protected List<ProductDTO> MyModel;
        protected string searchText = "";
        protected ProductDTO selectedForDetails;
        protected ProductDTO selectedForEdit;
        protected ProductDTO selectedForDelete;
        protected List<ProductDTO> filteredData;
        protected bool isSaving = false;
        protected string? messageError;

        [Inject]
        protected FinishedGoodsProductService MyService { get; set; }

        [Inject]
        protected NavigationMode navigationMode { get; set; }

        protected override async Task OnInitializedAsync()
        {

             await LoadMyData();

        }

        protected async Task LoadMyData()
        {


            MyModel = await MyService.GetAllAsync();
            FilterMyModel();


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
                                                  (s?.Name != null &&
                                                  s.Name.Contains(searchText, StringComparison.OrdinalIgnoreCase))

                                                ).ToList();
            }
        }

        protected List<ProductDTO> Filtered => filteredData;

        protected void ShowDetails(ProductDTO model)
        {
            selectedForDetails = model;
        }
        protected void CloseDetails()
        {
            selectedForDetails = null;
        }

        protected void ShowEdit(ProductDTO model)
        {
            selectedForEdit = new ProductDTO
            {
                Id = model.Id,
                Notes = model.Notes,
                Description=model.Description,
                Name = model.Name,
                Price=model.Price,
                UnitOfMeasure = model.UnitOfMeasure,
                
            };
        }

        protected void ShowAddModal()
        {
            selectedForEdit = new ProductDTO();
        }
        protected void CloseEditModal()
        {
            selectedForEdit = null;
        }
        protected async Task SavePurchases()
        {
            selectedForEdit.UnitOfMeasure = (UnitOfMeasure)selectedForEdit.UnitOfMeasureId;

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

        protected void ShowDelete(ProductDTO model)
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
