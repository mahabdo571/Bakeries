using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bakeries.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class removeFinishedProductInventoryIdFK : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_FinishedProductInventorys_FinishedProductInventoryId",
                table: "Products");

            migrationBuilder.DropIndex(
                name: "IX_Products_FinishedProductInventoryId",
                table: "Products");

            migrationBuilder.DropColumn(
                name: "FinishedProductInventoryId",
                table: "Products");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "FinishedProductInventoryId",
                table: "Products",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Products_FinishedProductInventoryId",
                table: "Products",
                column: "FinishedProductInventoryId");

            migrationBuilder.AddForeignKey(
                name: "FK_Products_FinishedProductInventorys_FinishedProductInventoryId",
                table: "Products",
                column: "FinishedProductInventoryId",
                principalTable: "FinishedProductInventorys",
                principalColumn: "Id");
        }
    }
}
