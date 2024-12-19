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
        }
        }
}
