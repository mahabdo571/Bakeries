using bakerbalzorwebassembly;
using bakerbalzorwebassembly.Models;
using bakerbalzorwebassembly.Services;
using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;

var builder = WebAssemblyHostBuilder.CreateDefault(args);
builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");

//builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri("https://rahaftec.runasp.net/") });
builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri("http://localhost:5000/") });
builder.Services.AddTransient<SalesDetailService>();
builder.Services.AddTransient<StockService>();
builder.Services.AddTransient<PurchasingService>();
builder.Services.AddTransient<FinishedProductInventoryService>();
builder.Services.AddTransient<PurchaseFinishedProductInventoryService>();
builder.Services.AddTransient<FinishedGoodsProductService>();
builder.Services.AddTransient<ProductIngredientService>();
builder.Services.AddTransient<ProductionService>();
builder.Services.AddTransient<OrderService>();
builder.Services.AddTransient<SalesReportService>();
builder.Services.AddSingleton<NavigationMode>();



var app = builder.Build();
await app.RunAsync();
