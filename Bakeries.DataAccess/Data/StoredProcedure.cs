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
        public static void UpdateStockOnPurchase(clsDbContext dbContext)
        {
            dbContext.Database.ExecuteSqlRaw(@"
            CREATE OR ALTER PROCEDURE UpdateStockOnPurchase
 @ItemId INT,
    @Quantity INT
            AS
            BEGIN
              IF EXISTS (SELECT 1 FROM Stocks WHERE Id = @ItemId)
    BEGIN
        UPDATE Stocks
        SET AvailableQuantity = AvailableQuantity + @Quantity,
            UpdatedAt = GETDATE()
        WHERE Id = @ItemId;
    END
    ELSE
    BEGIN

        INSERT INTO Stocks (Id, ItemName, AvailableQuantity, UpdatedAt)
        VALUES (@ItemId, 'Unknown Item', @Quantity, GETDATE());
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
        P.Unit,
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
    }
}
