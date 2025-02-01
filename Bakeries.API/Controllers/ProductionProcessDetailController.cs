using Bakeries.Business.Services;
using Bakeries.Business.Services.IServices;
using Business.Shared.DTOs;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Bakeries.API.Controllers
{
    [Route("api/ProductionProcessDetail")]
    [ApiController]
    public class ProductionProcessDetailController(IProductionProcessDetailService processDetailService
        , ILogger<ProductionController> logger) : ControllerBase
    {
        [HttpGet("{productionId}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<IEnumerable<ProductionProcessDetailDTO>>> GetAllByProductionIdAsync([FromRoute] int productionId)
        {

            try
            {
                var model = await processDetailService.GetAllByProductionIdAsync(productionId);
                if (model is null)
                {
                    logger.LogWarning("model is null  - not found.");
                    return NotFound($" not found.");
                }
                return Ok(model);
            }
            catch (Exception ex)
            {
                logger.LogError(ex.Message);
                return StatusCode(StatusCodes.Status500InternalServerError, $"{ex.Message}");
            }
        }

    }
}
