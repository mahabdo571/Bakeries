using AutoMapper;
using Bakeries.DataAccess.Entities;
using Business.Shared.DTOs;


namespace Bakeries.Business
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<PurchaseModel, PurchasesDTO>().ReverseMap();
            CreateMap<StockModel, StockDTO>().ReverseMap();
            CreateMap<ProductModel, ProductDTO>().ReverseMap();
            CreateMap<ProductIngredientModel, ProductIngredientDTO>().ReverseMap();



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
