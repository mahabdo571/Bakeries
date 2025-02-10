using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bakeries.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class addreltionForSale : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_SalesDetails_FinishedProductInventoryId",
                table: "SalesDetails",
                column: "FinishedProductInventoryId");

            migrationBuilder.AddForeignKey(
                name: "FK_SalesDetails_FinishedProductInventorys_FinishedProductInventoryId",
                table: "SalesDetails",
                column: "FinishedProductInventoryId",
                principalTable: "FinishedProductInventorys",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_SalesDetails_FinishedProductInventorys_FinishedProductInventoryId",
                table: "SalesDetails");

            migrationBuilder.DropIndex(
                name: "IX_SalesDetails_FinishedProductInventoryId",
                table: "SalesDetails");
        }
    }
}
