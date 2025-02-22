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
builder.Services.AddScoped<StockService>();
builder.Services.AddScoped<PurchasingService>();
builder.Services.AddScoped<FinishedProductInventoryService>();
builder.Services.AddScoped<PurchaseFinishedProductInventoryService>();
builder.Services.AddScoped<FinishedGoodsProductService>();
builder.Services.AddSingleton<NavigationMode>();



var app = builder.Build();
await app.RunAsync();
