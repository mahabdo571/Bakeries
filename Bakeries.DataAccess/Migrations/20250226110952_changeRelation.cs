using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bakeries.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class changeRelation : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PurchasesFinishedProductInventorys_Productions_PurchaseFinishedProductInventoryId",
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
        }
    }
}
