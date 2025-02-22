using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Data
{
    public static class ViweSql
    {
        public static void vCombinedPurchases(clsDbContext dbContext)
        {
            dbContext.Database.ExecuteSqlRaw(@"

CREATE OR ALTER VIEW [dbo].[vCombinedPurchases] AS
SELECT 
    Id,
    SupplierName,
    SupplierInvoiceNumber,
    Quantity,
    UnitOfMeasure,
    UnitPrice,
    TotalPrice,
    PaymentMethod,
    Status,
    ItemId,
    ItemName,
    CreatedAt,
    UpdatedAt,
    DeletedAt,
    Notes,
    SourceTable
FROM (
    SELECT 
        pfp.Id,
        pfp.SupplierName,
        pfp.SupplierInvoiceNumber,
        pfp.Quantity,
        pfp.UnitOfMeasure,
        pfp.UnitPrice,
        pfp.TotalPrice,
        pfp.PaymentMethod,
        pfp.Status,
        pfp.FinishedProductInventoryId AS ItemId,
        fpi.ItemName,
        pfp.CreatedAt,
        pfp.UpdatedAt,
        pfp.DeletedAt,
        pfp.Notes,
        'PurchasesFinishedProductInventorys' AS SourceTable
    FROM bakerTest.dbo.PurchasesFinishedProductInventorys pfp
    LEFT JOIN bakerTest.dbo.FinishedProductInventorys fpi 
        ON pfp.FinishedProductInventoryId = fpi.Id
    WHERE pfp.DeletedAt IS NULL

    UNION ALL

    SELECT 
        p.Id,
        p.SupplierName,
        p.SupplierInvoiceNumber,
        p.Quantity,
        p.UnitOfMeasure,
        p.UnitPrice,
        p.TotalPrice,
        p.PaymentMethod,
        p.Status,
        p.ItemId,
        s.ItemName,
        p.CreatedAt,
        p.UpdatedAt,
        p.DeletedAt,
        p.Notes,
        'Purchases' AS SourceTable
    FROM bakerTest.dbo.Purchases p
    LEFT JOIN bakerTest.dbo.Stocks s 
        ON p.ItemId = s.Id
    WHERE p.DeletedAt IS NULL
) Combined;




        ");
        }
    }
}
