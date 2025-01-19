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
              IF EXISTS (SELECT 1 FROM Stock WHERE Id = @ItemId)
    BEGIN
        UPDATE Stock
        SET AvailableQuantity = AvailableQuantity + @Quantity,
            UpdatedAt = GETDATE()
        WHERE Id = @ItemId;
    END
    ELSE
    BEGIN

        INSERT INTO Stock (Id, ItemName, AvailableQuantity, UpdatedAt)
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
        product P
    INNER JOIN 
        ProductIngredient PC ON P.Id = PC.ProductID AND  P.DeletedAt is NULL;
            
            END;
        ");
        }
    }
}
