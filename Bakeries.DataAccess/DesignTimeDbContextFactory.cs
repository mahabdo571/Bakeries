using Bakeries.DataAccess;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;

namespace DAevthERP
{
#if DEBUG
    public class DesignTimeDbContextFactory : IDesignTimeDbContextFactory<clsDbContext>
    {



        public clsDbContext CreateDbContext(string[] args)
        {


            var optionsBuilder = new DbContextOptionsBuilder<clsDbContext>();


            var configuration = new ConfigurationBuilder()

              .SetBasePath(@"C:\MyProgrammingWork\Bakeries\Bakeries.API\")//
                                                                             // .SetBasePath("C:\\devlop\\Bakeries\\Bakeries.API")//Directory.GetCurrentDirectory()
                .AddJsonFile("appsettings.json")
                .Build();

            var connectionString = configuration.GetConnectionString("ConnectionToDB-DEV");

            optionsBuilder.UseSqlServer(connectionString);

            return new clsDbContext(optionsBuilder.Options);
        }



    }
#endif
}


