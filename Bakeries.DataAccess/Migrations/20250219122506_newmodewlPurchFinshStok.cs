using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bakeries.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class newmodewlPurchFinshStok : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PurchaseFinishedProductInventoryModel_FinishedProductInventorys_FinishedProductInventoryId",
                table: "PurchaseFinishedProductInventoryModel");

            migrationBuilder.DropPrimaryKey(
                name: "PK_PurchaseFinishedProductInventoryModel",
                table: "PurchaseFinishedProductInventoryModel");

            migrationBuilder.RenameTable(
                name: "PurchaseFinishedProductInventoryModel",
                newName: "PurchasesFinishedProductInventorys");

            migrationBuilder.RenameIndex(
                name: "IX_PurchaseFinishedProductInventoryModel_FinishedProductInventoryId",
                table: "PurchasesFinishedProductInventorys",
                newName: "IX_PurchasesFinishedProductInventorys_FinishedProductInventoryId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_PurchasesFinishedProductInventorys",
                table: "PurchasesFinishedProductInventorys",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_PurchasesFinishedProductInventorys_FinishedProductInventorys_FinishedProductInventoryId",
                table: "PurchasesFinishedProductInventorys",
                column: "FinishedProductInventoryId",
                principalTable: "FinishedProductInventorys",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PurchasesFinishedProductInventorys_FinishedProductInventorys_FinishedProductInventoryId",
                table: "PurchasesFinishedProductInventorys");

            migrationBuilder.DropPrimaryKey(
                name: "PK_PurchasesFinishedProductInventorys",
                table: "PurchasesFinishedProductInventorys");

            migrationBuilder.RenameTable(
                name: "PurchasesFinishedProductInventorys",
                newName: "PurchaseFinishedProductInventoryModel");

            migrationBuilder.RenameIndex(
                name: "IX_PurchasesFinishedProductInventorys_FinishedProductInventoryId",
                table: "PurchaseFinishedProductInventoryModel",
                newName: "IX_PurchaseFinishedProductInventoryModel_FinishedProductInventoryId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_PurchaseFinishedProductInventoryModel",
                table: "PurchaseFinishedProductInventoryModel",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_PurchaseFinishedProductInventoryModel_FinishedProductInventorys_FinishedProductInventoryId",
                table: "PurchaseFinishedProductInventoryModel",
                column: "FinishedProductInventoryId",
                principalTable: "FinishedProductInventorys",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
