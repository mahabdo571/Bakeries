using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bakeries.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class delaySale : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "TotalSales",
                table: "DailySales",
                newName: "TotalAmount");

            migrationBuilder.AddColumn<int>(
                name: "OrderType",
                table: "DailySales",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "PaymentMethod",
                table: "DailySales",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<decimal>(
                name: "ProfitMargin",
                table: "DailySales",
                type: "decimal(18,2)",
                nullable: false,
                defaultValue: 0m);

            migrationBuilder.AddColumn<int>(
                name: "TotalItems",
                table: "DailySales",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "cashierId",
                table: "DailySales",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "OrderType",
                table: "DailySales");

            migrationBuilder.DropColumn(
                name: "PaymentMethod",
                table: "DailySales");

            migrationBuilder.DropColumn(
                name: "ProfitMargin",
                table: "DailySales");

            migrationBuilder.DropColumn(
                name: "TotalItems",
                table: "DailySales");

            migrationBuilder.DropColumn(
                name: "cashierId",
                table: "DailySales");

            migrationBuilder.RenameColumn(
                name: "TotalAmount",
                table: "DailySales",
                newName: "TotalSales");
        }
    }
}
