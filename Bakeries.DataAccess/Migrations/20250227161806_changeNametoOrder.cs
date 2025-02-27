using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bakeries.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class changeNametoOrder : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_SalesDetails_DailySales_DailySalesId",
                table: "SalesDetails");

            migrationBuilder.DropTable(
                name: "DailySales");

            migrationBuilder.CreateTable(
                name: "Orders",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    TotalAmount = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    TotalItems = table.Column<int>(type: "int", nullable: false),
                    PaymentMethod = table.Column<int>(type: "int", nullable: false),
                    cashierId = table.Column<int>(type: "int", nullable: false),
                    ProfitMargin = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    OrderType = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    DeletedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Notes = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Orders", x => x.Id);
                });

            migrationBuilder.AddForeignKey(
                name: "FK_SalesDetails_Orders_DailySalesId",
                table: "SalesDetails",
                column: "DailySalesId",
                principalTable: "Orders",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_SalesDetails_Orders_DailySalesId",
                table: "SalesDetails");

            migrationBuilder.DropTable(
                name: "Orders");

            migrationBuilder.CreateTable(
                name: "DailySales",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DeletedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Notes = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    OrderType = table.Column<int>(type: "int", nullable: false),
                    PaymentMethod = table.Column<int>(type: "int", nullable: false),
                    ProfitMargin = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    TotalAmount = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    TotalItems = table.Column<int>(type: "int", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    cashierId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DailySales", x => x.Id);
                });

            migrationBuilder.AddForeignKey(
                name: "FK_SalesDetails_DailySales_DailySalesId",
                table: "SalesDetails",
                column: "DailySalesId",
                principalTable: "DailySales",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
