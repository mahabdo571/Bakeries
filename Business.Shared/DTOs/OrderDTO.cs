using Business.Shared.Enums;


namespace Business.Shared.DTOs
{
    public class OrderDTO
    {
        public int Id { get; set; }
        public decimal TotalAmount { get; set; }
        public int TotalItems { get; set; }
        public PaymentMethod enPaymentMethod { get; set; }

        public decimal ProfitMargin { get; set; } //الربح المحقق من البيع
        public OrderType enOrderType { get; set; } //من المحل - توصيل - موزع 
        public string? Notes { get; set; } = "لا يوجد ملاحظات";


        public DateTime? CreatedAt { get; set; }

        public DateTime? UpdatedAt { get; set; }

        public int OrderTypeId
        {
            get => (int)enOrderType;
            set => enOrderType = (OrderType)value;
        }
       
        public int PaymentMethodId
        {
            get => (int)enPaymentMethod;
            set => enPaymentMethod = (PaymentMethod)value;
        }
    }
}
