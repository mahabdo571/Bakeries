using Bakeries.Business.Services;
using Bakeries.Business.Services.IServices;
using Business.Shared.DTOs;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Bakeries.API.Controllers
{
    [Route("api/Stock")]
    [ApiController]
    public class StockController : ControllerBase
    {
        private readonly IStockServices _stockServices;

        public StockController(IStockServices stockServices)
        {
            _stockServices = stockServices;
        }

        [HttpGet("All")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<IEnumerable<StockDTO>>> GetAllStock()
        {
            try
            {
                var model = await _stockServices.GetAllStockAsync();
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

        [HttpGet("{Id}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<StockDTO>> GetPurchasesById([FromRoute] int Id)
        {
            try
            {
                var model = await _stockServices.GetStockByIdAsync(Id);
                if (model is null)
                {

                    return NotFound($"model with ID {Id} not found.");
                }
                return Ok(model);
            }
            catch (Exception ex)
            {

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
                    return BadRequest("model data cannot be null.");
                }

                int newId = await _stockServices.AddStockAsync(model);
                model.Id = newId;


                return CreatedAtAction(nameof(GetPurchasesById), new { Id = newId }, model);
            }
            catch (ArgumentException ex)
            {

                return BadRequest(ex.Message);
            }
            catch (Exception ex)
            {

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
                    return BadRequest("model ID mismatch.");
                }


                await _stockServices.UpdateStockAsync(model);

                return Ok(new { message = $"model with ID {Id} has been successfully updated.", model });

            }
            catch (KeyNotFoundException ex)
            {

                return NotFound($"model with ID {Id} not found. {ex.Message}");
            }
            catch (ArgumentException ex)
            {

                return BadRequest(ex.Message);
            }
            catch (Exception ex)
            {

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
                await _stockServices.DeleteStockAsync(Id);
                return Ok(new { message = $"Purchases with ID {Id} has been successfully deleted." });
            }
            catch (KeyNotFoundException ex)
            {

                return NotFound($"Purchases with ID {Id} not found. {ex.Message}");
            }
            catch (Exception ex)
            {

                return StatusCode(StatusCodes.Status500InternalServerError, $"{ex.Message}");
            }
        }


    }
}
