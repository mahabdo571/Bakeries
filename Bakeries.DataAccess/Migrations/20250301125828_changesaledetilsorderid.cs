using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bakeries.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class changesaledetilsorderid : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_SalesDetails_Orders_DailySalesId",
                table: "SalesDetails");

            migrationBuilder.RenameColumn(
                name: "DailySalesId",
                table: "SalesDetails",
                newName: "OrderId");

            migrationBuilder.RenameIndex(
                name: "IX_SalesDetails_DailySalesId",
                table: "SalesDetails",
                newName: "IX_SalesDetails_OrderId");

            migrationBuilder.AddForeignKey(
                name: "FK_SalesDetails_Orders_OrderId",
                table: "SalesDetails",
                column: "OrderId",
                principalTable: "Orders",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_SalesDetails_Orders_OrderId",
                table: "SalesDetails");

            migrationBuilder.RenameColumn(
                name: "OrderId",
                table: "SalesDetails",
                newName: "DailySalesId");

            migrationBuilder.RenameIndex(
                name: "IX_SalesDetails_OrderId",
                table: "SalesDetails",
                newName: "IX_SalesDetails_DailySalesId");

            migrationBuilder.AddForeignKey(
                name: "FK_SalesDetails_Orders_DailySalesId",
                table: "SalesDetails",
                column: "DailySalesId",
                principalTable: "Orders",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
