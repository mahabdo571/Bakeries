using Bakeries.Business.Services;
using Bakeries.Business.Services.IServices;
using Bakeries.DataAccess;
using Bakeries.DataAccess.Repo;
using Bakeries.DataAccess.Repo.IRepo;
using Microsoft.EntityFrameworkCore;
using Serilog;
using Serilog.Events;
using Microsoft.Extensions.Hosting;
using Serilog.Sinks.Syslog;
using System.Runtime.InteropServices;


var builder = WebApplication.CreateBuilder(args);



builder.Logging.ClearProviders();  // إزالة المزودات الافتراضية
builder.Services.AddLogging(); // تأكد من إضافة خدمة ILogger
if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
{
    builder.Logging.AddEventLog(); // إضافة Event Log كمزود للتسجيلات

}
else
{
  builder.Logging.AddSerilog();
}



builder.Services.AddDbContext<clsDbContext>(options =>
    options.UseSqlServer(
        builder.Configuration.GetConnectionString("ConnectionToDB")
    ), ServiceLifetime.Scoped
);
builder.WebHost.ConfigureKestrel(options =>
{
    options.Listen(System.Net.IPAddress.Parse("0.0.0.0"), 5000); // HTTP
    options.Listen(System.Net.IPAddress.Parse("0.0.0.0"), 5001, listenOptions =>
    {
        listenOptions.UseHttps(); // HTTPS
    });
});
builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.PropertyNamingPolicy = null;
    });

builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

//Repo
builder.Services.AddScoped<IPurchasesRepo, PurchasesRepo>();
builder.Services.AddScoped<IStockRepo, StockRepo>();
builder.Services.AddScoped<IProductsRepo, ProductsRepo>();
builder.Services.AddScoped<IProductIngredientRepo, ProductIngredientRepo>();
builder.Services.AddScoped<IProductionRepo, ProductionRepo>();
builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();

//Services
builder.Services.AddScoped<IPurchasesServices, PurchasesServices>();
builder.Services.AddScoped<IStockServices, StockServices>();
builder.Services.AddScoped<IProductServices, ProductServices>();
builder.Services.AddScoped<IProductIngredientService, ProductIngredientService>();
builder.Services.AddScoped<IProductionServices, ProductionServices>();


builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();

}

     //app.UseHttpsRedirection();




app.UseAuthorization();

app.MapControllers();
app.UseCors(policy => policy
    .AllowAnyOrigin()
    .AllowAnyMethod()
    .AllowAnyHeader());
app.Run();
