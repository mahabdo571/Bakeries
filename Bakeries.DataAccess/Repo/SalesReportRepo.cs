using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Repo
{
    public class SalesReportRepo(clsDbContext context) : ISalesReportRepo
    {
        public async Task<List<SalesReport>> getSalesReport(DateTime startDate, DateTime endDate)
        {


   
            

                var results = await context.SalesReports.FromSqlRaw("EXEC sp_SalesReport @p0, @p1", parameters: new object[] { startDate, endDate })
   .ToListAsync();
                return results;
      


       



        }
    }
}
