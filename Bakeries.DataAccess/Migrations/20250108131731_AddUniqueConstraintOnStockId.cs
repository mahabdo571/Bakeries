using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bakeries.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class AddUniqueConstraintOnStockId : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_ProductIngredient_StockId",
                table: "ProductIngredient");

            migrationBuilder.CreateIndex(
                name: "IX_ProductIngredient_StockId",
                table: "ProductIngredient",
                column: "stockId",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_ProductIngredient_StockId",
                table: "ProductIngredient");

            migrationBuilder.CreateIndex(
                name: "IX_ProductIngredient_StockId",
                table: "ProductIngredient",
                column: "stockId");
        }
    }
}
