using Bakeries.DataAccess.Data;
using Bakeries.DataAccess.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
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
        public DbSet<ProductsModel> product { get; set; }
        public DbSet<ProductIngredientModel> ProductIngredient { get; set; }
        public DbSet<ProductionModel> Production { get; set; }
        public clsDbContext(DbContextOptions op) : base(op)
        {
         

        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
      
                optionsBuilder.EnableSensitiveDataLogging(); // تفعيل تسجيل البيانات الحساسة
            }
        }


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

          //  modelBuilder.Entity<ProductIngredientModel>()
          //.HasIndex(e => e.stockId)
          //.IsUnique()
          //.HasDatabaseName("IX_ProductIngredient_StockId");

            // إضافة فهرس على ProductId في جدول ProductIngredientModel
            modelBuilder.Entity<ProductIngredientModel>()
                .HasIndex(pi => pi.ProductId)
                .HasDatabaseName("IX_ProductIngredient_ProductId");

            // إضافة فهرس على StockId في جدول ProductIngredientModel
            modelBuilder.Entity<ProductIngredientModel>()
                .HasIndex(pi => pi.stockId)
                .HasDatabaseName("IX_ProductIngredient_StockId");

            // إضافة فهرس على ItemName في جدول StockModel
            modelBuilder.Entity<StockModel>()
                .HasIndex(s => s.ItemName)
                .HasDatabaseName("IX_Stock_ItemName");

            // إضافة فهرس على Name في جدول ProductsModel
            modelBuilder.Entity<ProductsModel>()
                .HasIndex(p => p.Name)
                .HasDatabaseName("IX_Products_Name");
        }
        public void EnsureStoredProcedure()
        {

            StoredProcedure.UpdateStockOnPurchase(this);
            StoredProcedure.GetProductsWithComponents(this);


       
        }

        

    }
}
