using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bakeries.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class fix : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PurchasesFinishedProductInventorys_Productions_PurchaseFinishedProductInventoryId",
                table: "PurchasesFinishedProductInventorys");

            migrationBuilder.DropIndex(
                name: "IX_PurchasesFinishedProductInventorys_ProductionId",
                table: "PurchasesFinishedProductInventorys");

            migrationBuilder.DropIndex(
                name: "IX_PurchasesFinishedProductInventorys_PurchaseFinishedProductInventoryId",
                table: "PurchasesFinishedProductInventorys");

            migrationBuilder.DropColumn(
                name: "PurchaseFinishedProductInventoryId",
                table: "PurchasesFinishedProductInventorys");

            migrationBuilder.DropColumn(
                name: "PurchaseFinishedProductInventoryId",
                table: "Productions");

            migrationBuilder.CreateIndex(
                name: "IX_PurchasesFinishedProductInventorys_ProductionId",
                table: "PurchasesFinishedProductInventorys",
                column: "ProductionId",
                unique: true,
                filter: "[ProductionId] IS NOT NULL");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_PurchasesFinishedProductInventorys_ProductionId",
                table: "PurchasesFinishedProductInventorys");

            migrationBuilder.AddColumn<int>(
                name: "PurchaseFinishedProductInventoryId",
                table: "PurchasesFinishedProductInventorys",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PurchaseFinishedProductInventoryId",
                table: "Productions",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_PurchasesFinishedProductInventorys_ProductionId",
                table: "PurchasesFinishedProductInventorys",
                column: "ProductionId");

            migrationBuilder.CreateIndex(
                name: "IX_PurchasesFinishedProductInventorys_PurchaseFinishedProductInventoryId",
                table: "PurchasesFinishedProductInventorys",
                column: "PurchaseFinishedProductInventoryId");

            migrationBuilder.AddForeignKey(
                name: "FK_PurchasesFinishedProductInventorys_Productions_PurchaseFinishedProductInventoryId",
                table: "PurchasesFinishedProductInventorys",
                column: "PurchaseFinishedProductInventoryId",
                principalTable: "Productions",
                principalColumn: "Id");
        }
    }
}
