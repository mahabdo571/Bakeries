
using Bakeries.Business.Services;
using Bakeries.Business.Services.IServices;
using Business.Shared.DTOs;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;

namespace Bakeries.API.Controllers
{
    [Route("api/Stock")]
    [ApiController]
    public class StockController : ControllerBase
    {
        private readonly IStockServices _stockServices;
        private readonly ILogger<StockController> _logger;
   

        public StockController(IStockServices stockServices, ILogger<StockController> logger)
        {
            _stockServices = stockServices;
            _logger = logger;
    
        }

        [HttpGet("All")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<IEnumerable<StockDTO>>> GetAllStock()
        {
            
            try
            {
                var model = await _stockServices.GetAllAsync();
                if (model is null)
                {
                    _logger.LogWarning("model is null  - not found.");

                    return NotFound($" not found.");
                }
                return Ok(model);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return StatusCode(StatusCodes.Status500InternalServerError, $"{ex.Message}");
            }
        }

        [HttpGet("{Id}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<StockDTO>> GetPurchasesById([FromRoute] int Id)
        {
            try
            {
                var model = await _stockServices.GetByIdAsync(Id);
                if (model is null)
                {
                    _logger.LogWarning("model is null  - not found.");
                    return NotFound($"model with ID {Id} not found.");
                }
                return Ok(model);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return StatusCode(StatusCodes.Status500InternalServerError, $"{ex.Message}");
            }
        }


        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult> AddStock([FromBody] StockDTO model)
        {
            try
            {

                if (model is null)
                {
                    _logger.LogWarning("model is null  - not found.");
                    return BadRequest("model data cannot be null.");
                }

                int newId = await _stockServices.AddAsync(model);
                model.Id = newId;

              

                return CreatedAtAction(nameof(GetPurchasesById), new { Id = newId }, model);
            }
            catch (ArgumentException ex)
            {
                _logger.LogError(ex.Message);
                return BadRequest(ex.Message);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return StatusCode(StatusCodes.Status500InternalServerError, $"{ex.Message}");
            }
        }

        [HttpPut("{Id}")]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult> UpdateStock([FromRoute] int Id, [FromBody] StockDTO model)
        {
  

            try
            {
                if (Id != model.Id)
                {
                    _logger.LogWarning("model ID mismatch.");
                    return BadRequest("model ID mismatch.");
                }


                await _stockServices.UpdateAsync(model);

                return Ok(new { message = $"model with ID {Id} has been successfully updated.", model });

            }
            catch (KeyNotFoundException ex)
            {
                _logger.LogError(ex.Message);
                return NotFound($"model with ID {Id} not found. {ex.Message}");
            }
            catch (ArgumentException ex)
            {
                _logger.LogError(ex.Message);
                return BadRequest(ex.Message);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return StatusCode(StatusCodes.Status500InternalServerError, $"{ex.Message}");
            }
        }

        [HttpDelete("{Id}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult> DeleteStock([FromRoute] int Id)
        {
            try
            {
                await _stockServices.DeleteAsync(Id);
                return Ok(new { Message = $"تم الحذف بنجاح" });
            }
            catch (KeyNotFoundException ex)
            {
                _logger.LogError(ex.Message);
                return NotFound(new { Message = $"خطأ في عملية الحذف", Details = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);

                return StatusCode(StatusCodes.Status500InternalServerError, new { Message = $"خطأ في عملية الحذف" , Details = ex.Message});
            }
        }


    }
}
