using Bakeries.Business.Services;
using Bakeries.Business.Services.IServices;
using Business.Shared.DTOs;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Bakeries.API.Controllers
{
    [Route("api/SalesReport")]
    [ApiController]
    public class SalesReportController(ISalesReportService service) : ControllerBase
    {
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<IEnumerable<SalesReportDTO>>> Get(DateTime strtDate,DateTime endDate)
        {

            try
            {
                var model = await service.getSalesReport(strtDate,endDate);
                if (model is null)
                {
              
                    return NotFound($" not found.");
                }
                return Ok(model);
            }
            catch (Exception ex)
            {
       
                return StatusCode(StatusCodes.Status500InternalServerError, $"{ex.Message}");
            }
        }
    }
}
