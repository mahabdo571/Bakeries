
using Bakeries.Business.Services;
using Bakeries.Business.Services.IServices;
using Bakeries.DataAccess;
using Bakeries.DataAccess.Repo;
using Bakeries.DataAccess.Repo.IRepo;
using Microsoft.EntityFrameworkCore;




var builder = WebApplication.CreateBuilder(args);



builder.Logging.ClearProviders();  // إزالة المزودات الافتراضية
builder.Services.AddLogging(); // تأكد من إضافة خدمة ILogger
//if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
//{
//    builder.Logging.AddEventLog(); // إضافة Event Log كمزود للتسجيلات

//}
//else
//{
//  builder.Logging.AddSerilog();
//}

#if DEBUG
builder.Services.AddDbContext<clsDbContext>(options =>
    options
    .EnableSensitiveDataLogging()
    .UseSqlServer(
        builder.Configuration.GetConnectionString("ConnectionToDB-DEV")

    ), ServiceLifetime.Scoped

);

builder.WebHost.ConfigureKestrel(options =>
{
    options.ListenAnyIP(5000);  // فقط HTTP
});


#else

builder.Services.AddDbContext<clsDbContext>(options =>
    options.UseSqlServer(
        builder.Configuration.GetConnectionString("ConnectionToDB")
        //sqlServerOptions =>
        //{
        //    sqlServerOptions.EnableRetryOnFailure(
        //        maxRetryCount: 5, // عدد المحاولات قبل الفشل
        //        maxRetryDelay: TimeSpan.FromSeconds(10), // المدة بين كل محاولة وأخرى
        //        errorNumbersToAdd: null // أرقام الأخطاء الإضافية التي يجب إعادة المحاولة عند حدوثها (اختياري)

        //    );
        //}
    ),
    ServiceLifetime.Scoped
);



#endif


//builder.WebHost.ConfigureKestrel(options =>
//{
//    options.Listen(System.Net.IPAddress.Parse("0.0.0.0"), 8080); // HTTP
//    options.Listen(System.Net.IPAddress.Parse("0.0.0.0"), 8081, listenOptions =>
//    {
//        listenOptions.UseHttps(); // HTTPS
//    });
//});

builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.PropertyNamingPolicy = null;
    });

builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

//Repo
builder.Services.AddTransient<IPurchasesRepo, PurchasesRepo>();
builder.Services.AddTransient<IStockRepo, StockRepo>();
builder.Services.AddTransient<IProductsRepo, ProductsRepo>();
builder.Services.AddTransient<IProductIngredientRepo, ProductIngredientRepo>();
builder.Services.AddTransient<IProductionRepo, ProductionRepo>();
builder.Services.AddTransient<IUnitOfWork, UnitOfWork>();
builder.Services.AddTransient<IProductionProcessDetailRepo, ProductionProcessDetailRepo>();
builder.Services.AddTransient<IFinishedProductInventoryRepo, FinishedProductInventoryRepo>();
builder.Services.AddTransient<IPurchaseFinishedProductInventoryRepo, PurchaseFinishedProductInventoryRepo>();
builder.Services.AddTransient<IOrderRepo, OrderRepo>();
builder.Services.AddTransient<ISalesDetailRepo, SalesDetailRepo>();

//Services
builder.Services.AddTransient<IPurchasesServices, PurchasesServices>();
builder.Services.AddTransient<IStockServices, StockServices>();
builder.Services.AddTransient<IProductServices, ProductServices>();
builder.Services.AddTransient<IProductIngredientService, ProductIngredientService>();
builder.Services.AddTransient<IProductionServices, ProductionServices>();
builder.Services.AddTransient<IProductionProcessDetailService, ProductionProcessDetailServices>();
builder.Services.AddTransient<IFinishedProductInventoryService, FinishedProductInventoryService>();
builder.Services.AddTransient<IPurchaseFinishedProductInventoryServes, PurchaseFinishedProductInventoryServes>();
builder.Services.AddTransient<IOrderService, OrderService>();
builder.Services.AddTransient<ISalesDetailService, SalesDetailService>();


//Event
builder.Services.AddSingleton<StockEventHandler>();
builder.Services.AddSingleton<ProductionEventsHelpers>();


builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();





var app = builder.Build();

var serviceProvider = app.Services;
serviceProvider.GetRequiredService<StockEventHandler>();






// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{

    using (var scope = app.Services.CreateScope())
    {
        var context = scope.ServiceProvider.GetRequiredService<clsDbContext>();
        context.Database.Migrate(); // لتطبيق الميجريشن
        context.EnsureStoredProcedure(); // لتأكد من وجود الستورد بروسيجر
        context.EnsureViweSql();
    }

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
