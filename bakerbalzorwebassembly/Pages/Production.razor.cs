using bakerbalzorwebassembly.Models;
using bakerbalzorwebassembly.Services;
using Business.Shared.DTOs;
using Business.Shared.Enums;
using Microsoft.AspNetCore.Components;

namespace bakerbalzorwebassembly.Pages
{
    public partial class Production : ComponentBase
    {
        protected List<ProductionDTO> MyModel;
        protected string searchText = "";
        protected ProductionDTO selectedForDetails;
        protected List<ProductionProcessDetailDTO> selectedForProcessDetail;
        protected ProductionDTO selectedForEdit;
        protected ProductionDTO selectedForDelete;
        protected List<ProductionDTO> filteredData;
        protected bool isSaving = false;
        protected string? messageError;

        [Inject]
        protected ProductionService MyService { get; set; }

        [Inject]
        protected NavigationMode navigationMode { get; set; }

        protected override async Task OnInitializedAsync()
        {

            await LoadMyData();
            selectedForProcessDetail = null;
        }

        protected async Task LoadMyData()
        {


            MyModel = await MyService.GetAllbyProductAsync(navigationMode.productDTO!.Id);
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
                                                  s.Notes.Contains(searchText, StringComparison.OrdinalIgnoreCase))

                                                ).ToList();
            }
        }

        protected List<ProductionDTO> Filtered => filteredData;

        protected void ShowDetails(ProductionDTO model)
        {
            selectedForDetails = model;
        }
        protected void CloseDetails()
        {
            selectedForDetails = null;
        }    
        
        protected void CloseProcessDetail()
        {
            selectedForProcessDetail = null;
        }

        protected void ShowEdit(ProductionDTO model)
        {
            selectedForEdit = new ProductionDTO
            {
                Id = model.Id,
                Notes = model.Notes,
                QuantityProduced = model.QuantityProduced,
                QuantityDamaged = model.QuantityDamaged,
                ProductId = model.ProductId,
      

            };
        }

        protected void ShowAddModal()
        {
            selectedForEdit = new ProductionDTO();
        }
        protected void CloseEditModal()
        {
            selectedForEdit = null;
        }
        protected async Task SavePurchases()
        {

            isSaving = true;
            selectedForEdit.ProductId = navigationMode.productDTO!.Id;
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

        protected void ShowDelete(ProductionDTO model)
        {
            selectedForDelete = model;
        }
              
        
        protected async Task ShowProcessDetail(int productionId)
        {
            selectedForProcessDetail =await MyService.GetbyProductionProcessDetailAsync(productionId);
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
