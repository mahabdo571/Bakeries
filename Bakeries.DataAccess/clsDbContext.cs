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
        public DbSet<StockModel> Stock { get; set; }
        public clsDbContext(DbContextOptions op) : base(op)
        {

        }

        //protected override void OnModelCreating(ModelBuilder modelBuilder)
        //{
        //    modelBuilder.Entity<PurchasesModel>()
        //        .ToTable("Purchases")
        //        .HasInsertTrigger("trg_UpdateIStockAfterInsert"); // إن كنت تحتاج تعيينه
        //}

    }
}
