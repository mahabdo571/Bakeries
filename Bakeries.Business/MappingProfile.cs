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
          
      
            CreateMap<ProductIngredientModel, ProductIngredientDTO>().ReverseMap();

            CreateMap<StockModel, StockDTO>()
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
    .ForMember(dest => dest.UnitOfMeasure, opt => opt.MapFrom(src => (UnitOfMeasure)src.UnitOfMeasure))
    .ReverseMap()
    .ForMember(dest => dest.UnitOfMeasure, opt => opt.MapFrom(src => (int)src.UnitOfMeasure!)); 
            
            
            CreateMap<PurchaseFinishedProductInventoryModel, PurchaseFinishedProductInventoryDTO>()
    .ForMember(dest => dest.UnitOfMeasure, opt => opt.MapFrom(src => (UnitOfMeasure)src.UnitOfMeasure))
    .ReverseMap()
    .ForMember(dest => dest.UnitOfMeasure, opt => opt.MapFrom(src => (int)src.UnitOfMeasure!));


            CreateMap<ProductIngredientModel,ProductIngredientAddUpdateDTO>().ReverseMap();


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
