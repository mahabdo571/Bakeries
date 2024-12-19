using Bakeries.DataAccess.Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess
{
    public class clsDbContext : DbContext
    {
        public DbSet<PurchasesModel> Purchases { get; set; }
        public clsDbContext(DbContextOptions op) : base(op)
        {

        }
    }
}
