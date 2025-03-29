using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bakeries.DataAccess.Data
{
    public static class StoredProcedure
    {
      //  SELECT DATEADD(HOUR, 2, GETUTCDATE()) AS CurrentTime_GMT_Plus2;

        public static void UpdateStockOnPurchase(clsDbContext dbContext)
        {
            dbContext.Database.ExecuteSqlRaw(@"
            CREATE OR ALTER PROCEDURE UpdateStockOnPurchase
 @ItemId INT,
    @Quantity INT,
@lastPriceCost decimal(18,5)
            AS
            BEGIN
              IF EXISTS (SELECT 1 FROM Stocks WHERE Id = @ItemId)
    BEGIN
        UPDATE Stocks
        SET 
AvailableQuantity = AvailableQuantity + @Quantity,
lastPriceCost =  @lastPriceCost ,
            UpdatedAt =DATEADD(HOUR, 2, GETUTCDATE())
        WHERE Id = @ItemId;
    END
    ELSE
    BEGIN

        INSERT INTO Stocks (Id, ItemName, AvailableQuantity, UpdatedAt)
        VALUES (@ItemId, 'Unknown Item', @Quantity, DATEADD(HOUR, 2, GETUTCDATE()));
    END

            END;
        ");
        }     
        
        
        public static void UpdateFinishedProductInventoryAfterPurchase(clsDbContext dbContext)
        {
            dbContext.Database.ExecuteSqlRaw(@"
            CREATE OR ALTER PROCEDURE UpdateFinishedProductInventoryAfterPurchase
 @finishedProductInventoryId INT,
    @Quantity INT
            AS
            BEGIN
              IF EXISTS (SELECT 1 FROM FinishedProductInventorys WHERE Id = @finishedProductInventoryId)
    BEGIN
        UPDATE FinishedProductInventorys
        SET AvailableQuantity = AvailableQuantity + @Quantity,
            UpdatedAt =DATEADD(HOUR, 2, GETUTCDATE())
        WHERE Id = @finishedProductInventoryId;
    END
    ELSE
    BEGIN

        INSERT INTO FinishedProductInventorys (Id, ItemName, AvailableQuantity, UpdatedAt)
        VALUES (@finishedProductInventoryId, 'Unknown Item', @Quantity, DATEADD(HOUR, 2, GETUTCDATE()));
    END

            END;
        ");
        }

        public static void GetProductsWithComponents(clsDbContext dbContext)
        {
            dbContext.Database.ExecuteSqlRaw(@"
            CREATE OR ALTER PROCEDURE GetProductsWithComponents

            AS
            BEGIN
 SELECT DISTINCT 
        P.Id, 
        P.Name,
        P.Description,
        P.Price,
        P.UnitOfMeasure,
        P.CreatedAt,
        P.UpdatedAt,
        P.DeletedAt,
        P.Notes
    FROM 
        Products P
    INNER JOIN 
        ProductIngredients PC ON P.Id = PC.ProductID AND  P.DeletedAt is NULL;
            
            END;
        ");
        }     
        
        
        public static void sp_SalesReport(clsDbContext dbContext)
        {
            dbContext.Database.ExecuteSqlRaw(@"
           
CREATE OR ALTER PROCEDURE dbo.sp_SalesReport
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    
SELECT 
    T.SaleDate,
    FORMAT(T.SaleDate, 'dddd', 'ar-SA') AS DayName,  
    T.TotalSales,
    T.TotalItems,
    ISNULL(P.TotalCost, 0) AS TotalCost,
    T.TotalSales - ISNULL(P.TotalCost, 0) AS FinalResult
FROM
(
    SELECT 
         CAST(CreatedAt AS DATE) AS SaleDate,
         SUM(TotalAmount) AS TotalSales,
         SUM(TotalItems) AS TotalItems
    FROM [dbo].[Orders]
    WHERE CAST(CreatedAt AS DATE) BETWEEN @StartDate  AND @EndDate
          AND DeletedAt IS NULL
    GROUP BY CAST(CreatedAt AS DATE)
) AS T
LEFT JOIN
(
    SELECT
         CAST(CreatedAt AS DATE) AS CostDate,
         SUM(Cost) AS TotalCost
    FROM ProductionProcessDetails
    WHERE CAST(CreatedAt AS DATE) BETWEEN @StartDate AND @EndDate
          AND DeletedAt IS NULL
    GROUP BY CAST(CreatedAt AS DATE)
) AS P ON T.SaleDate = P.CostDate
ORDER BY T.SaleDate;

END;

        ");
        }
    }
}
