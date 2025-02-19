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
        public DbSet<PurchaseModel> Purchases { get; set; }
        public DbSet<StockModel> Stocks { get; set; }
        public DbSet<ProductModel> Products { get; set; }
        public DbSet<ProductIngredientModel> ProductIngredients { get; set; }
        public DbSet<ProductionModel> Productions { get; set; }
        public DbSet<ProductionProcessDetailModel> ProductionProcessDetails { get; set; }
        public DbSet<FinishedProductInventoryModel> FinishedProductInventorys { get; set; }
        public DbSet<PurchaseFinishedProductInventoryModel> PurchasesFinishedProductInventorys { get; set; }
        public DbSet<SalesDetailModel> SalesDetails { get; set; }
        public DbSet<DailySaleModel> DailySales { get; set; }
        public clsDbContext(DbContextOptions op) : base(op)
        {
         

        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
      
               // optionsBuilder.EnableSensitiveDataLogging(); // تفعيل تسجيل البيانات الحساسة
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

            modelBuilder.Entity<StockModel>()
       .Property(s => s.UnitOfMeasure)
       .HasConversion<int>(); // تأكيد تخزين enum كـ int

            // إضافة فهرس على Name في جدول ProductsModel
            modelBuilder.Entity<ProductModel>()
                .HasIndex(p => p.Name)
                .HasDatabaseName("IX_Products_Name");

  
            modelBuilder.Entity<ProductionModel>()
                .HasMany(p => p.Details)
                .WithOne(s => s.Production)
                .HasForeignKey(s => s.ProductionId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<ProductionProcessDetailModel>()
      .HasOne(ps => ps.Stock)
      .WithMany(p => p.Details)
      .HasForeignKey(ps => ps.stockId)
      .OnDelete(DeleteBehavior.Restrict); // منع حذف المنتج إذا كانت هناك خطوات مرتبطة

            modelBuilder.Entity<ProductIngredientModel>().HasQueryFilter(i => i.DeletedAt == null);



        }
        public void EnsureStoredProcedure()
        {

            StoredProcedure.UpdateStockOnPurchase(this);
            StoredProcedure.GetProductsWithComponents(this);
            StoredProcedure.UpdateFinishedProductInventoryAfterPurchase(this);


       
        }

        

    }
}
