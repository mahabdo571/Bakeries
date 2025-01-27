


using Bakeries.Business.Operations;
using Bakeries.Business.Services.IServices;
using Bakeries.DataAccess;
using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;

public class StockEventHandler
{

    private readonly ProductionEventsHelpers _productionEventsHelpers;
    public StockEventHandler(ProductionEventsHelpers productionEventsHelpers)
    {
        _productionEventsHelpers = productionEventsHelpers;
        productionEventsHelpers.OnProductionAdded += HandleProductionAdded;
        productionEventsHelpers.OnProductionUpdated += HandleProductionUpdated;
    }

    private async Task HandleProductionAdded(IUnitOfWork unitOfWork, ProductionModel model)
    {
        await StockOperation.UpdateStockAvailabilityAfterNew(unitOfWork, model.Id);
       await GenralOperations.AddingTheQuantitiesConsumedInTheProductionProcess(unitOfWork, model);
    }

    private async Task HandleProductionUpdated(IUnitOfWork unitOfWork, ProductionModel model)
    {
        await GenralOperations.UpdatingTheQuantitiesConsumedInTheProductionProcess(unitOfWork, model);

        await StockOperation.UpdateStockAvailabilityAfterUpdate(unitOfWork, model);
    }

  


}
