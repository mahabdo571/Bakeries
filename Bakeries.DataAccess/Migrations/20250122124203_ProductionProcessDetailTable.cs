using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bakeries.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class ProductionProcessDetailTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ProductionProcessDetails",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Quantity = table.Column<float>(type: "real", nullable: false),
                    stockId = table.Column<int>(type: "int", nullable: false),
                    ProductionId = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    DeletedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Notes = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductionProcessDetails", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProductionProcessDetails_Productions_ProductionId",
                        column: x => x.ProductionId,
                        principalTable: "Productions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ProductionProcessDetails_Stocks_stockId",
                        column: x => x.stockId,
                        principalTable: "Stocks",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ProductionProcessDetails_ProductionId",
                table: "ProductionProcessDetails",
                column: "ProductionId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductionProcessDetails_stockId",
                table: "ProductionProcessDetails",
                column: "stockId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ProductionProcessDetails");
        }
    }
}
