using AutoMapper;
using Bakeries.DataAccess.Entities;
using Business.Shared.DTOs;
using Business.Shared.Enums;


namespace Bakeries.Business
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {


            CreateMap<CombinedPurchase, CombinedPurchaseDTO>().ReverseMap();
            CreateMap<SalesDetailModel, SalesDetailDTO>().ReverseMap();
            CreateMap<SalesReport, SalesReportDTO>().ReverseMap();

            CreateMap<OrderModel, OrderDTO>()
                .ForMember(dest=>dest.enOrderType , opt=>opt.MapFrom(src=>(OrderType)src.OrderType))
                .ForMember(dest => dest.enPaymentMethod, opt => opt.MapFrom(src => (PaymentMethod)src.PaymentMethod))
                .ReverseMap()
                .ForMember(dest => dest.OrderType, opt => opt.MapFrom(src => (int)src.enOrderType))
                .ForMember(dest => dest.PaymentMethod, opt => opt.MapFrom(src => (int)src.enPaymentMethod))
;

            CreateMap<StockModel, StockDTO>()
    .ForMember(dest => dest.UnitOfMeasure, opt => opt.MapFrom(src => (UnitOfMeasure)src.UnitOfMeasure))
    .ReverseMap()
    .ForMember(dest => dest.UnitOfMeasure, opt => opt.MapFrom(src => (int)src.UnitOfMeasure!));

            CreateMap<ProductIngredientModel, ProductIngredientDTO>()
    .ForMember(dest => dest.UnitOfMeasure, opt => opt.MapFrom(src => (UnitOfMeasure)src.UnitOfMeasure))
    .ReverseMap()
    .ForMember(dest => dest.UnitOfMeasure, opt => opt.MapFrom(src => (int)src.UnitOfMeasure!));


            CreateMap<ProductModel, ProductDTO>()
    .ForMember(dest => dest.UnitOfMeasure, opt => opt.MapFrom(src => (UnitOfMeasure)src.UnitOfMeasure))
    .ReverseMap()
    .ForMember(dest => dest.UnitOfMeasure, opt => opt.MapFrom(src => (int)src.UnitOfMeasure!));


            CreateMap<PurchaseModel, PurchasesDTO>()
    .ForMember(dest => dest.UnitOfMeasure, opt => opt.MapFrom(src => (UnitOfMeasure)src.UnitOfMeasure))
    .ReverseMap()
    .ForMember(dest => dest.UnitOfMeasure, opt => opt.MapFrom(src => (int)src.UnitOfMeasure!));

            CreateMap<FinishedProductInventoryModel, FinishedProductInventoryDTO>()
    .ForMember(dest => dest.enUnitOfMeasure, opt => opt.MapFrom(src => (UnitOfMeasure)src.UnitOfMeasure))
    .ReverseMap()
    .ForMember(dest => dest.UnitOfMeasure, opt => opt.MapFrom(src => (int)src.enUnitOfMeasure!));


            CreateMap<PurchaseFinishedProductInventoryModel, PurchaseFinishedProductInventoryDTO>()
    .ForMember(dest => dest.UnitOfMeasure, opt => opt.MapFrom(src => (UnitOfMeasure)src.UnitOfMeasure))
    .ReverseMap()
    .ForMember(dest => dest.UnitOfMeasure, opt => opt.MapFrom(src => (int)src.UnitOfMeasure!));




            CreateMap<ProductIngredientModel, ProductIngredientAddUpdateDTO>()
    .ForMember(dest => dest.UnitOfMeasure, opt => opt.MapFrom(src => (UnitOfMeasure)src.UnitOfMeasure))
    .ReverseMap()
    .ForMember(dest => dest.UnitOfMeasure, opt => opt.MapFrom(src => (int)src.UnitOfMeasure!));



            CreateMap<ProductionProcessDetailModel, ProductionProcessDetailDTO>()
                .ForMember(dest => dest.ItemName, opt => opt.MapFrom(src => src.Stock.ItemName))
                .ForMember(dest => dest.UnitOfMeasure, opt => opt.MapFrom(src => src.Stock.UnitOfMeasure))
            .ReverseMap();

            CreateMap<ProductionModel, ProductionDTO>()
           .ReverseMap()
           .ForMember(dest => dest.Product, opt => opt.Ignore());






        }
    }
}
