using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Bakeries.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class changeUnitTypeToEnumFinishedProductInventory : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Unit",
                table: "FinishedProductInventorys");

            migrationBuilder.AddColumn<int>(
                name: "UnitOfMeasure",
                table: "FinishedProductInventorys",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "UnitOfMeasure",
                table: "FinishedProductInventorys");

            migrationBuilder.AddColumn<string>(
                name: "Unit",
                table: "FinishedProductInventorys",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                defaultValue: "");
        }
    }
}
