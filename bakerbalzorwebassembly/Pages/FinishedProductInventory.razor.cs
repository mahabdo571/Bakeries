using bakerbalzorwebassembly.Services;
using Business.Shared.DTOs;
using Business.Shared.Enums;
using Microsoft.AspNetCore.Components;

namespace bakerbalzorwebassembly.Pages
{
    public partial class FinishedProductInventory : ComponentBase
    {
       
        protected List<FinishedProductInventoryDTO> FinishedProductInventoryModel;
        protected string searchText = "";
        protected FinishedProductInventoryDTO selectedFinishedProductInventoryForDetails;
        protected FinishedProductInventoryDTO selectedFinishedProductInventoryForEdit;
        protected FinishedProductInventoryDTO selectedFinishedProductInventoryForDelete;
        protected List<FinishedProductInventoryDTO> filteredFinishedProductInventory;
        protected bool isSaving = false;
        protected string? messageError;

        [Inject]
        protected FinishedProductInventoryService finishedProductInventoryService { get; set; }

        protected override async Task OnInitializedAsync()
        {
            await LoadFinishedProductInventorys();
        }

        // دالة تحميل البيانات
        protected async Task LoadFinishedProductInventorys()
        {

            FinishedProductInventoryModel = await finishedProductInventoryService.GetAllAsync();
            FilterFinishedProductInventory(); 

        }

    
        protected void SearchFinishedProductInventory(string e)
        {
            searchText = e;
            FilterFinishedProductInventory(); 
        }


        protected void FilterFinishedProductInventory()
        {
            if (string.IsNullOrEmpty(searchText))
            {
                filteredFinishedProductInventory = FinishedProductInventoryModel;
            }
            else
            {
                filteredFinishedProductInventory = FinishedProductInventoryModel.Where(s => s.ItemName != null &&
                                                s.ItemName.Contains(searchText, StringComparison.OrdinalIgnoreCase)).ToList();
            }
        }

        protected List<FinishedProductInventoryDTO> FilteredFinishedProductInventory => filteredFinishedProductInventory;

        protected void ShowDetails(FinishedProductInventoryDTO finishedProductInventory)
        {
            selectedFinishedProductInventoryForDetails = finishedProductInventory;
        }
        protected void CloseDetails()
        {
            selectedFinishedProductInventoryForDetails = null;
        }

        protected void ShowEdit(FinishedProductInventoryDTO finishedProductInventory)
        {
            selectedFinishedProductInventoryForEdit = new FinishedProductInventoryDTO
            {
                Id = finishedProductInventory.Id,
                ItemName = finishedProductInventory.ItemName,
                AvailableQuantity = finishedProductInventory.AvailableQuantity,
                UnitOfMeasure = finishedProductInventory.UnitOfMeasure,
                ReorderLevel = finishedProductInventory.ReorderLevel,
                Location = finishedProductInventory.Location,
                Notes = finishedProductInventory.Notes,
                CreatedAt = finishedProductInventory.CreatedAt,
                UpdatedAt = finishedProductInventory.UpdatedAt,
                Code = finishedProductInventory.Code,  
                CostPrice = finishedProductInventory.CostPrice,
                Discount = finishedProductInventory.Discount,
                Tax = finishedProductInventory.Tax,
           UnitPriceForPeople = finishedProductInventory.UnitPriceForPeople,
           UnitPriceForResellers = finishedProductInventory.UnitPriceForResellers,
           UniPtriceForDealers=finishedProductInventory.UniPtriceForDealers,
           UnitOfMeasureId = finishedProductInventory.UnitOfMeasureId
          
            };
        }

        protected void ShowAddModal()
        {
            selectedFinishedProductInventoryForEdit = new FinishedProductInventoryDTO();
        }
        protected void CloseEditModal()
        {
            selectedFinishedProductInventoryForEdit = null;
        }
        protected async Task SaveStock()
        {
            selectedFinishedProductInventoryForEdit.UnitOfMeasure = (UnitOfMeasure)selectedFinishedProductInventoryForEdit.UnitOfMeasure;

            isSaving = true;
            if (selectedFinishedProductInventoryForEdit.Id == 0)
            {
                await finishedProductInventoryService.AddAsync(selectedFinishedProductInventoryForEdit);

            }
            else
            {

                await finishedProductInventoryService.UpdateAsync(selectedFinishedProductInventoryForEdit);
            }
            await LoadFinishedProductInventorys();

            CloseEditModal();
            isSaving = false;
        }

        protected void ShowDelete(FinishedProductInventoryDTO finishedProductInventory)
        {
            selectedFinishedProductInventoryForDelete = finishedProductInventory;
        }
        protected void CloseDeleteModal()
        {
            selectedFinishedProductInventoryForDelete = null;
            messageError = null;
        }
        protected async Task ConfirmDelete()
        {
            isSaving = true;
            var checkError = await finishedProductInventoryService.DeleteAsync(selectedFinishedProductInventoryForDelete.Id);
            if (checkError is not null)
            {

                messageError = $"{checkError.Message} {checkError.Details}";


            }

            await LoadFinishedProductInventorys();
            if (messageError == null)
            {
                CloseDeleteModal();
            }
            isSaving = false;

        }
    }
}
