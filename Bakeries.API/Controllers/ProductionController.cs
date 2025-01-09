using Bakeries.Business.Services;
using Bakeries.Business.Services.IServices;
using Business.Shared.DTOs;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Bakeries.API.Controllers
{
    [Route("api/Production")]
    [ApiController]
    public class ProductionController(IProductionServices _productionServices
        , ILogger<ProductionController> _logger) : ControllerBase
    {

        [HttpGet("All")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<IEnumerable<ProductionDTO>>> GetAllProduct()
        {

            try
            {
                var model = await _productionServices.GetAllAsync();
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
        public async Task<ActionResult<ProductionDTO>>  GetProductionById([FromRoute] int Id)
        {
            try
            {
                var model = await _productionServices.GetByIdAsync(Id);
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
        public async Task<ActionResult> AddProduction([FromBody] ProductionDTO model)
        {
            try
            {

                if (model is null)
                {
                    _logger.LogWarning("model is null  - not found.");
                    return BadRequest("model data cannot be null.");
                }

                int newId = await _productionServices.AddAsync(model);
                model.Id = newId;


                return CreatedAtAction(nameof( GetProductionById), new { Id = newId }, model);
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
        public async Task<ActionResult> UpdateProduction([FromRoute] int Id, [FromBody] ProductionDTO model)
        {


            try
            {
                if (Id != model.Id)
                {
                    _logger.LogWarning("model is null  - not found.");

                    return BadRequest("model ID mismatch.");
                }


                await _productionServices.UpdateAsync(model);

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
        public async Task<ActionResult> DeleteProductin([FromRoute] int Id)
        {
            try
            {
                await _productionServices.DeleteAsync(Id);
                return Ok(new { message = $"Purchases with ID {Id} has been successfully deleted." });
            }
            catch (KeyNotFoundException ex)
            {
                _logger.LogError(ex.Message);
                return NotFound($"Purchases with ID {Id} not found. {ex.Message}");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return StatusCode(StatusCodes.Status500InternalServerError, $"{ex.Message}");
            }
        }

    }
}
