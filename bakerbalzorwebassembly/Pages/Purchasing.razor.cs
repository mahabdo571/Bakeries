using Business.Shared.DTOs;
using bakerbalzorwebassembly.Services;
using Microsoft.AspNetCore.Components;
using Business.Shared.Enums;
using Microsoft.AspNetCore.Components.Web;


namespace bakerbalzorwebassembly.Pages
{
    public partial class Purchasing : ComponentBase
    {

        protected List<PurchasesDTO> PurchasingModel;
        protected string searchText = "";
        protected PurchasesDTO selectedPurchasingForDetails;
        protected PurchasesDTO selectedPurchasingForEdit;
        protected PurchasesDTO selectedPurchasingForDelete;
        protected List<PurchasesDTO> filteredPurchasing;
        protected List<StockDTO> stockItem; 
        protected bool isSaving = false;
        protected string? messageError;

        [Inject]
        protected PurchasingService PurchasingService { get; set; }
        [Inject]
        protected StockService stockService { get; set; }

        protected override async Task OnInitializedAsync()
        {
            await LoadPurchasing();
            stockItem =await stockService.GetAllAsync();
        }

        protected async Task LoadPurchasing()
        {

            PurchasingModel = await PurchasingService.GetAllAsync();
            FilterPurchasing();


        }


        protected Task SearchPurchasing(string e)
        {
            searchText = e;
            FilterPurchasing();
            return Task.CompletedTask;
        }


        protected void FilterPurchasing()
        {
            if (string.IsNullOrEmpty(searchText))
            {
                filteredPurchasing = PurchasingModel;
            }
            else
            {
                filteredPurchasing = PurchasingModel.Where(s => s.ItemName != null &&
                                                s.ItemName.Contains(searchText, StringComparison.OrdinalIgnoreCase)).ToList();
            }
        }

        protected List<PurchasesDTO> FilteredPurchases => filteredPurchasing;

        protected void ShowDetails(PurchasesDTO model)
        {
            selectedPurchasingForDetails = model;
        }
        protected void CloseDetails()
        {
            selectedPurchasingForDetails = null;
        }

        protected void ShowEdit(PurchasesDTO model)
        {
            selectedPurchasingForEdit = new PurchasesDTO
            {
                 Id = model.Id,
                SupplierName = model.SupplierName,
                 ItemId = model.ItemId,
                 Notes = model.Notes,
                SupplierInvoiceNumber = model.SupplierInvoiceNumber,
                Quantity = model.Quantity,
                UnitOfMeasure = model.UnitOfMeasure,
                UnitPrice = model.UnitPrice,
                TotalPrice= model.TotalPrice,
                PaymentMethod =model.PaymentMethod,
                Status = model.Status,
            };
        }

        protected void ShowAddModal()
        {
            selectedPurchasingForEdit = new PurchasesDTO();
        }
        protected void CloseEditModal()
        {
            selectedPurchasingForEdit = null;
        }
        protected async Task SavePurchases()
        {
            selectedPurchasingForEdit.UnitOfMeasure = (UnitOfMeasure)selectedPurchasingForEdit.UnitOfMeasure;

            isSaving = true;
            if (selectedPurchasingForEdit.Id == 0)
            {
                await PurchasingService.AddAsync(selectedPurchasingForEdit);

            }
            else
            {

                await PurchasingService.UpdateAsync(selectedPurchasingForEdit);
            }
            await LoadPurchasing();

            CloseEditModal();
            isSaving = false;
        }

        protected void ShowDelete(PurchasesDTO model)
        {
            selectedPurchasingForDelete = model;
        }   
        
        private void CalculateTheTotalPrice()
        {
            if (selectedPurchasingForEdit == null) return;
             selectedPurchasingForEdit.TotalPrice = selectedPurchasingForEdit.UnitPrice * selectedPurchasingForEdit.Quantity;
            
        }
        private Task OnUnitPriceChanged(string e)
        {
            if (decimal.TryParse(e, out var unitPrice))
            {
                selectedPurchasingForEdit.UnitPrice = unitPrice;
            }
            CalculateTheTotalPrice();
            return Task.CompletedTask;
        }
        private Task OnQuantityChanged(string e)
        {
            if (decimal.TryParse(e, out var quantity))
            {
                selectedPurchasingForEdit.Quantity = quantity;
            }
            CalculateTheTotalPrice();
           return Task.CompletedTask;
        }
   
        protected void CloseDeleteModal()
        {
            selectedPurchasingForDelete = null;
            messageError = null;
        }
        protected async Task ConfirmDelete()
        {
            isSaving = true;
            var checkError = await PurchasingService.DeleteAsync(selectedPurchasingForDelete.Id);
            if (checkError is not null)
            {

                messageError = $"{checkError.Message} {checkError.Details}";


            }

            await LoadPurchasing();
            if (messageError == null)
            {
                CloseDeleteModal();
            }
            isSaving = false;

        }
    }
}
