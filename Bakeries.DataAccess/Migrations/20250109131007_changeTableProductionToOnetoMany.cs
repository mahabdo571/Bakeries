using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bakeries.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class changeTableProductionToOnetoMany : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProductionModel_product_ProductId",
                table: "ProductionModel");

            migrationBuilder.DropPrimaryKey(
                name: "PK_ProductionModel",
                table: "ProductionModel");

            migrationBuilder.DropIndex(
                name: "IX_ProductionModel_ProductId",
                table: "ProductionModel");

            migrationBuilder.RenameTable(
                name: "ProductionModel",
                newName: "Production");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Production",
                table: "Production",
                column: "Id");

            migrationBuilder.CreateIndex(
                name: "IX_Production_ProductId",
                table: "Production",
                column: "ProductId");

            migrationBuilder.AddForeignKey(
                name: "FK_Production_product_ProductId",
                table: "Production",
                column: "ProductId",
                principalTable: "product",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Production_product_ProductId",
                table: "Production");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Production",
                table: "Production");

            migrationBuilder.DropIndex(
                name: "IX_Production_ProductId",
                table: "Production");

            migrationBuilder.RenameTable(
                name: "Production",
                newName: "ProductionModel");

            migrationBuilder.AddPrimaryKey(
                name: "PK_ProductionModel",
                table: "ProductionModel",
                column: "Id");

            migrationBuilder.CreateIndex(
                name: "IX_ProductionModel_ProductId",
                table: "ProductionModel",
                column: "ProductId",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_ProductionModel_product_ProductId",
                table: "ProductionModel",
                column: "ProductId",
                principalTable: "product",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
