using bakerbalzorwebassembly.Models;
using bakerbalzorwebassembly.Services;
using Business.Shared.DTOs;
using Business.Shared.Enums;
using Microsoft.AspNetCore.Components;

namespace bakerbalzorwebassembly.Pages
{
    public partial class PurchaseFinishedProductInventory: ComponentBase
    {
        protected List<PurchaseFinishedProductInventoryDTO> MyModel;
        protected string searchText = "";
        protected PurchaseFinishedProductInventoryDTO selectedForDetails;
        protected PurchaseFinishedProductInventoryDTO selectedForEdit;
        protected PurchaseFinishedProductInventoryDTO selectedForDelete;
        protected List<PurchaseFinishedProductInventoryDTO> filteredData;
        protected bool isSaving = false;
        protected string? messageError;

        [Inject]
        protected PurchaseFinishedProductInventoryService MyService { get; set; }

        [Inject]
        protected NavigationMode navigationMode { get; set; }

        protected override async Task OnInitializedAsync()
        {

            await LoadMyData(navigationMode?.FPIDTO?.Id ?? -1);
    
        }

        protected async Task LoadMyData(int? itemId)
        {
            if (itemId == null) return;

            MyModel = await MyService.GetAllByItemIdAsync((int)itemId!);
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
                filteredData = MyModel.Where(s => s?.Notes != null &&
                                                s.Notes.Contains(searchText, StringComparison.OrdinalIgnoreCase)).ToList();
            }
        }

        protected List<PurchaseFinishedProductInventoryDTO> FilteredPurchases => filteredData;

        protected void ShowDetails(PurchaseFinishedProductInventoryDTO model)
        {
            selectedForDetails = model;
        }
        protected void CloseDetails()
        {
            selectedForDetails = null;
        }

        protected void ShowEdit(PurchaseFinishedProductInventoryDTO model)
        {
            selectedForEdit = new PurchaseFinishedProductInventoryDTO
            {
                Id = model.Id,
                SupplierName = model.SupplierName,
                Notes = model.Notes,
                SupplierInvoiceNumber = model.SupplierInvoiceNumber,
                Quantity = model.Quantity,
                UnitOfMeasure = model.UnitOfMeasure,
                UnitPrice = model.UnitPrice,
                TotalPrice = model.TotalPrice,
                PaymentMethod = model.PaymentMethod,
                FinishedProductInventoryId = model.FinishedProductInventoryId,
                UnitOfMeasureId = model.UnitOfMeasureId,
                Status = model.Status,
                
            };
        }

        protected void ShowAddModal()
        {
            selectedForEdit = new PurchaseFinishedProductInventoryDTO();
        }
        protected void CloseEditModal()
        {
            selectedForEdit = null;
        }
        protected async Task SavePurchases()
        {
            selectedForEdit.UnitOfMeasure = (UnitOfMeasure)selectedForEdit.UnitOfMeasure;
            selectedForEdit.FinishedProductInventoryId = navigationMode?.FPIDTO?.Id ?? -1;
           
            isSaving = true;
            if (selectedForEdit.Id == 0)
            {
                await MyService.AddAsync(selectedForEdit);

            }
            else
            {

                await MyService.UpdateAsync(selectedForEdit);
            }
            await LoadMyData(selectedForEdit.FinishedProductInventoryId);

            CloseEditModal();
            isSaving = false;
        }

        protected void ShowDelete(PurchaseFinishedProductInventoryDTO model)
        {
            selectedForDelete = model;
        }

        private void CalculateTheTotalPrice()
        {
            if (selectedForEdit == null) return;
            selectedForEdit.TotalPrice = selectedForEdit.UnitPrice * selectedForEdit.Quantity;

        }
        private Task OnUnitPriceChanged(string e)
        {
            if (decimal.TryParse(e, out var unitPrice))
            {
                selectedForEdit.UnitPrice = unitPrice;
            }
            CalculateTheTotalPrice();
            return Task.CompletedTask;
        }
        private Task OnQuantityChanged(string e)
        {
            if (decimal.TryParse(e, out var quantity))
            {
                selectedForEdit.Quantity = quantity;
            }
            CalculateTheTotalPrice();
            return Task.CompletedTask;
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

            await LoadMyData(selectedForDelete.FinishedProductInventoryId);
            if (messageError == null)
            {
                CloseDeleteModal();
            }
            isSaving = false;

        }
    }
}
