using bakerbalzorwebassembly.Models;
using bakerbalzorwebassembly.Services;
using Business.Shared.DTOs;
using Business.Shared.Enums;
using Microsoft.AspNetCore.Components;
using System.Reflection;

namespace bakerbalzorwebassembly.Pages
{
    public partial class SalesDetail : ComponentBase
    {
        protected IQueryable<SalesDetailDTO> MyModel;
        protected List<FinishedProductInventoryDTO> FPIModel;
        protected string searchText = "";
        protected SalesDetailDTO selectedForDetails;
        protected SalesDetailDTO selectedForEdit;
        protected SalesDetailDTO selectedForDelete;
      
        protected IQueryable<SalesDetailDTO> filteredData;
        protected bool isSaving = false;
        protected string? messageError;
        protected decimal totalSum;
        private int orderId;
        private FinishedProductInventoryDTO fpiModel;
        [Inject]
        protected SalesDetailService MyService { get; set; }    
        [Inject]
        protected FinishedProductInventoryService FPIservice { get; set; }

        [Inject]
        protected NavigationMode navigationMode { get; set; }

        protected override async Task OnInitializedAsync()
        {
                     await getAllFPI();
            orderId = navigationMode.orderDTO!.Id;
            await LoadMyData();
 
    


        }
  
        protected async Task getAllFPI()
        {
            FPIModel =  await FPIservice.GetAllAsync();
        }
        protected async Task LoadMyData()
        {
     
                MyModel = await MyService.GetAllByOrderId(orderId);
       

            FilterMyModel();
            CalculateTotalSum();

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
                filteredData = MyModel.Where(s => (s.Notes != null &&
                                                  s.Notes.Contains(searchText, StringComparison.OrdinalIgnoreCase))

                                                ).AsQueryable();
            }
            CalculateTotalSum();
        }

        protected IQueryable<SalesDetailDTO> Filtered => filteredData;

        protected void ShowDetails(SalesDetailDTO model)
        {
            selectedForDetails = model;
        }
        protected void CloseDetails()
        {
            selectedForDetails = null;
        }

        protected async void ShowEdit(SalesDetailDTO model)
        {
            selectedForEdit = new SalesDetailDTO
            {
                Id = model.Id,
                Notes = model.Notes,
                OrderId = orderId,
                Discount = model.Discount,
                 Quantity = model.Quantity,
                 FinishedProductInventoryId = model.FinishedProductInventoryId

            };
        }

        protected void ShowAddModal()
        {
            selectedForEdit = new SalesDetailDTO();
        }
        protected void CloseEditModal()
        {
            selectedForEdit = null;
        }
        protected async Task Save()
        {
            fpiModel = await FPIservice.GetByIdAsync(selectedForEdit.FinishedProductInventoryId);

            selectedForEdit.OrderId = orderId;
            selectedForEdit.ProductName = fpiModel.ItemName;
            selectedForEdit.UnitPrice = fpiModel.UnitPriceForPeople;
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

        protected void ShowDelete(SalesDetailDTO model)
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
        private void CalculateTotalSum()
        {
            totalSum = MyModel.Sum(item => item.Total);
        }


    }
}
