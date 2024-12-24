using Bakeries.DataAccess;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;

namespace DAevthERP
{
    public class DesignTimeDbContextFactory : IDesignTimeDbContextFactory<clsDbContext>
    {
        public clsDbContext CreateDbContext(string[] args)
        {
            var optionsBuilder = new DbContextOptionsBuilder<clsDbContext>();


            var configuration = new ConfigurationBuilder()
                //.SetBasePath("C:\\devlop\\backend\\evthERP\\evthERP\\bin\\Debug\\net9.0")//Directory.GetCurrentDirectory()
               // .SetBasePath("C:\\Programming works\\Bakeries\\Bakeries.API\\")//Directory.GetCurrentDirectory()
                .SetBasePath("C:\\devlop\\Bakeries\\Bakeries.API")//Directory.GetCurrentDirectory()
                .AddJsonFile("appsettings.json")
                .Build();

            var connectionString = configuration.GetConnectionString("ConnectionToDB");

            optionsBuilder.UseSqlServer(connectionString);

            return new clsDbContext(optionsBuilder.Options);
        }
    }
}


