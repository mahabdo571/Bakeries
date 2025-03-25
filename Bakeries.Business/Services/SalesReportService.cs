using AutoMapper;
using Bakeries.Business.Services.IServices;
using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;
using Business.Shared.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Bakeries.Business.Services
{
    public class SalesReportService(IUnitOfWork unitOfWork , IMapper mapper) : ISalesReportService
    {
        public async Task<List<SalesReportDTO>?> getSalesReport(DateTime startDate, DateTime endDate)
        {
            var model = await unitOfWork.SalesReportRepository.getSalesReport(startDate, endDate);

            if(model is not null)
                return mapper.Map<List<SalesReportDTO>>(model);



            return null;
      
        }

    
    }
}
