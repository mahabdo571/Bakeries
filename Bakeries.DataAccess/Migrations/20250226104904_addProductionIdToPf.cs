using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bakeries.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class addProductionIdToPf : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ProductionId",
                table: "PurchasesFinishedProductInventorys",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_PurchasesFinishedProductInventorys_ProductionId",
                table: "PurchasesFinishedProductInventorys",
                column: "ProductionId");

            migrationBuilder.AddForeignKey(
                name: "FK_PurchasesFinishedProductInventorys_Productions_ProductionId",
                table: "PurchasesFinishedProductInventorys",
                column: "ProductionId",
                principalTable: "Productions",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PurchasesFinishedProductInventorys_Productions_ProductionId",
                table: "PurchasesFinishedProductInventorys");

            migrationBuilder.DropIndex(
                name: "IX_PurchasesFinishedProductInventorys_ProductionId",
                table: "PurchasesFinishedProductInventorys");

            migrationBuilder.DropColumn(
                name: "ProductionId",
                table: "PurchasesFinishedProductInventorys");
        }
    }
}
