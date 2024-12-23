using Bakeries.Business.Services;
using Bakeries.Business.Services.IServices;
using Bakeries.DataAccess;
using Bakeries.DataAccess.Repo;
using Bakeries.DataAccess.Repo.IRepo;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);




builder.Services.AddDbContext<clsDbContext>(options =>
    options.UseSqlServer(
        builder.Configuration.GetConnectionString("ConnectionToDB")
    )
);

builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.PropertyNamingPolicy = null;
    });

builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

//Repo
builder.Services.AddScoped<IPurchasesRepo, PurchasesRepo>();
builder.Services.AddScoped<IStockRepo, StockRepo>();

//Services
builder.Services.AddScoped<IPurchasesServices, PurchasesServices>();
builder.Services.AddScoped<IStockServices, StockServices>();


builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();
app.UseCors(policy => policy
    .AllowAnyOrigin()
    .AllowAnyMethod()
    .AllowAnyHeader());
app.Run();
