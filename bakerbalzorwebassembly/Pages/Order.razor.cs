using bakerbalzorwebassembly.Models;
using bakerbalzorwebassembly.Services;
using Business.Shared.DTOs;
using Business.Shared.Enums;
using Microsoft.AspNetCore.Components;

namespace bakerbalzorwebassembly.Pages
{
    public partial class Order : ComponentBase
    {
        protected List<OrderDTO> MyModel;
        protected string searchText = "";
        protected OrderDTO selectedForDetails;
        protected OrderDTO selectedForEdit;
        protected OrderDTO selectedForDelete;
        protected List<OrderDTO> filteredData;
        protected bool isSaving = false;
        protected string? messageError;

        [Inject]
        protected OrderService MyService { get; set; }

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
                                                  s.Notes.Contains(searchText, StringComparison.OrdinalIgnoreCase))

                                                ).ToList();
            }
        }

        protected List<OrderDTO> Filtered => filteredData;

        protected void ShowDetails(OrderDTO model)
        {
            selectedForDetails = model;
        }
        protected void CloseDetails()
        {
            selectedForDetails = null;
        }

        protected void ShowEdit(OrderDTO model)
        {
            selectedForEdit = new OrderDTO
            {
                Id = model.Id,
                Notes = model.Notes,
         ProfitMargin = model.ProfitMargin,
         TotalAmount = model.TotalAmount,
         TotalItems = model.TotalItems,
         PaymentMethod = model.PaymentMethod,
         OrderType = model.OrderType,
         
            };
        }

        protected void ShowAddModal()
        {
            selectedForEdit = new OrderDTO();
        }
        protected void CloseEditModal()
        {
            selectedForEdit = null;
        }
        protected async Task SavePurchases()
        {
            selectedForEdit.OrderType = (OrderType)selectedForEdit.OrderTypeId;
            selectedForEdit.PaymentMethod = (PaymentMethod)selectedForEdit.PaymentMethodId;

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

        protected void ShowDelete(OrderDTO model)
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
