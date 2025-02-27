using Business.Shared.Enums;


namespace Business.Shared.DTOs
{
    public class OrderDTO
    {
        public int Id { get; set; }
        public decimal TotalAmount { get; set; }
        public int TotalItems { get; set; }
        public PaymentMethod PaymentMethod { get; set; }

        public decimal ProfitMargin { get; set; } //الربح المحقق من البيع
        public OrderType OrderType { get; set; } //من المحل - توصيل - موزع 
        public string? Notes { get; set; } = "لا يوجد ملاحظات";


        public DateTime? CreatedAt { get; set; }

        public DateTime? UpdatedAt { get; set; }

        public int OrderTypeId
        {
            get => (int)OrderType;
            set => OrderType = (OrderType)value;
        }   
        
        public int PaymentMethodId
        {
            get => (int)OrderType;
            set => PaymentMethod = (PaymentMethod)value;
        }
    }
}
