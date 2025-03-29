

using Bakeries.DataAccess;
using Bakeries.DataAccess.Entities;
using Bakeries.DataAccess.Repo.IRepo;
using System;
using System;
using System.Collections.Generic;
using System.Collections.Generic;
using System.Linq;
using System.Linq;
using System.Text;

using System.Threading.Tasks;
using System.Threading.Tasks;

public class ProductionEventsHelpers
{
    public event Func<IUnitOfWork, ProductionModel, Task<decimal>> OnProductionAdded;
    public event Func<IUnitOfWork, ProductionModel, Task> OnProductionUpdated;
    public async Task<decimal> RaiseProductionAddedEvent(IUnitOfWork unitOfWork, ProductionModel model)
    {

     return await OnProductionAdded?.Invoke(unitOfWork, model);



    }

    public async Task RaiseProductionUpdatedEvent(IUnitOfWork unitOfWork, ProductionModel NewModel)
    {
        await (OnProductionUpdated?.Invoke(unitOfWork, NewModel) ?? Task.CompletedTask);


    }
}