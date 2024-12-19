using Bakeries.Business.Services.IServices;
using Business.Shared.DTOs;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Bakeries.API.Controllers
{
    [Route("api/Purchases")]
    [ApiController]
    public class PurchasesController : ControllerBase
    {
        private readonly IPurchasesServices _purchasesServices;

        public PurchasesController(IPurchasesServices purchasesServices)
        {
            _purchasesServices = purchasesServices;
        }
        [HttpGet("All")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<IEnumerable<PurchasesDTO>>> GetAllPurchases()
        {
            try
            {
                var model = await _purchasesServices.GetAllPurchasesAsync();
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
        public async Task<ActionResult<PurchasesDTO>> GetPurchasesById([FromRoute] int Id)
        {
            try
            {
                var model = await _purchasesServices.GetPurchasesByIdAsync(Id);
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
        public async Task<ActionResult> AddPurchases([FromBody] PurchasesDTO model)
        {
            try
            {

                if (model is null)
                {
                    return BadRequest("model data cannot be null.");
                }

                int newId = await _purchasesServices.AddPurchasesAsync(model);
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
        public async Task<ActionResult> UpdatePurchases([FromRoute] int Id, [FromBody] PurchasesDTO model)
        {


            try
            {
                if (Id != model.Id)
                {
                    return BadRequest("model ID mismatch.");
                }


                await _purchasesServices.UpdatePurchasesAsync(model);

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
        public async Task<ActionResult> DeletePurchases([FromRoute] int Id)
        {
            try
            {
                await _purchasesServices.DeletePurchasesAsync(Id);
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
