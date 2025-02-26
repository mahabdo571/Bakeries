using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bakeries.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class fix5 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PurchasesFinishedProductInventorys_Productions_ProductionId",
                table: "PurchasesFinishedProductInventorys");

            migrationBuilder.DropColumn(
                name: "PurchaseFinishedProductInventoryId",
                table: "Productions");

            migrationBuilder.AddForeignKey(
                name: "FK_PurchasesFinishedProductInventorys_Productions_ProductionId",
                table: "PurchasesFinishedProductInventorys",
                column: "ProductionId",
                principalTable: "Productions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PurchasesFinishedProductInventorys_Productions_ProductionId",
                table: "PurchasesFinishedProductInventorys");

            migrationBuilder.AddColumn<int>(
                name: "PurchaseFinishedProductInventoryId",
                table: "Productions",
                type: "int",
                nullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_PurchasesFinishedProductInventorys_Productions_ProductionId",
                table: "PurchasesFinishedProductInventorys",
                column: "ProductionId",
                principalTable: "Productions",
                principalColumn: "Id");
        }
    }
}
