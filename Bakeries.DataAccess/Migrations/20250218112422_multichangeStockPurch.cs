using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bakeries.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class multichangeStockPurch : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Purchases_FinishedProductInventorys_FinishedProductInventoryId",
                table: "Purchases");

            migrationBuilder.DropIndex(
                name: "IX_Purchases_FinishedProductInventoryId",
                table: "Purchases");

            migrationBuilder.DropColumn(
                name: "FinishedProductInventoryId",
                table: "Purchases");

            migrationBuilder.DropColumn(
                name: "WarehouseSelection",
                table: "Purchases");

            migrationBuilder.CreateTable(
                name: "PurchaseFinishedProductInventoryModel",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    SupplierName = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    SupplierInvoiceNumber = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Quantity = table.Column<decimal>(type: "decimal(18,4)", nullable: false),
                    UnitOfMeasure = table.Column<int>(type: "int", nullable: false),
                    UnitPrice = table.Column<decimal>(type: "decimal(18,4)", nullable: false),
                    TotalPrice = table.Column<decimal>(type: "decimal(18,4)", nullable: false),
                    PaymentMethod = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Status = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    FinishedProductInventoryId = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    DeletedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Notes = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PurchaseFinishedProductInventoryModel", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PurchaseFinishedProductInventoryModel_FinishedProductInventorys_FinishedProductInventoryId",
                        column: x => x.FinishedProductInventoryId,
                        principalTable: "FinishedProductInventorys",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_PurchaseFinishedProductInventoryModel_FinishedProductInventoryId",
                table: "PurchaseFinishedProductInventoryModel",
                column: "FinishedProductInventoryId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "PurchaseFinishedProductInventoryModel");

            migrationBuilder.AddColumn<int>(
                name: "FinishedProductInventoryId",
                table: "Purchases",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "WarehouseSelection",
                table: "Purchases",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Purchases_FinishedProductInventoryId",
                table: "Purchases",
                column: "FinishedProductInventoryId");

            migrationBuilder.AddForeignKey(
                name: "FK_Purchases_FinishedProductInventorys_FinishedProductInventoryId",
                table: "Purchases",
                column: "FinishedProductInventoryId",
                principalTable: "FinishedProductInventorys",
                principalColumn: "Id");
        }
    }
}
