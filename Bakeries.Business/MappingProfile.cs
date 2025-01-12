using AutoMapper;
using Bakeries.DataAccess.Entities;
using Business.Shared.DTOs;


namespace Bakeries.Business
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<PurchasesModel, PurchasesDTO>().ReverseMap();
            CreateMap<StockModel, StockDTO>().ReverseMap();
            CreateMap<ProductsModel, ProductDTO>().ReverseMap();
            CreateMap<ProductIngredientModel, ProductIngredientDTO>().ReverseMap();
            CreateMap<ProductIngredientModel, ProductIngredientAddUpdateDTO>().ReverseMap();
            //CreateMap<ProductionModel, ProductionDTO>().ReverseMap()
            CreateMap<ProductionModel, ProductionDTO>()
           .ReverseMap()
           .ForMember(dest => dest.Product, opt => opt.Ignore());
           //.ForMember(dest => dest.Id, opt => opt.Ignore());

           

        }
    }
}
