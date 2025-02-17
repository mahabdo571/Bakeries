using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bakeries.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class oneToOneProductAndFinshedStock : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "FinishedProductInventoryId",
                table: "Products",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ProductId",
                table: "FinishedProductInventorys",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Products_FinishedProductInventoryId",
                table: "Products",
                column: "FinishedProductInventoryId");

            migrationBuilder.CreateIndex(
                name: "IX_FinishedProductInventorys_ProductId",
                table: "FinishedProductInventorys",
                column: "ProductId");

            migrationBuilder.AddForeignKey(
                name: "FK_FinishedProductInventorys_Products_ProductId",
                table: "FinishedProductInventorys",
                column: "ProductId",
                principalTable: "Products",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Products_FinishedProductInventorys_FinishedProductInventoryId",
                table: "Products",
                column: "FinishedProductInventoryId",
                principalTable: "FinishedProductInventorys",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_FinishedProductInventorys_Products_ProductId",
                table: "FinishedProductInventorys");

            migrationBuilder.DropForeignKey(
                name: "FK_Products_FinishedProductInventorys_FinishedProductInventoryId",
                table: "Products");

            migrationBuilder.DropIndex(
                name: "IX_Products_FinishedProductInventoryId",
                table: "Products");

            migrationBuilder.DropIndex(
                name: "IX_FinishedProductInventorys_ProductId",
                table: "FinishedProductInventorys");

            migrationBuilder.DropColumn(
                name: "FinishedProductInventoryId",
                table: "Products");

            migrationBuilder.DropColumn(
                name: "ProductId",
                table: "FinishedProductInventorys");
        }
    }
}
