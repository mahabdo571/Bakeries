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
        private readonly ILogger<PurchasesController> _logger;

        public PurchasesController(IPurchasesServices purchasesServices, ILogger<PurchasesController> logger)
        {
            _purchasesServices = purchasesServices;
            _logger = logger;
        }
        [HttpGet("All")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<IEnumerable<PurchasesDTO>>> GetAllPurchases()
        {
            try
            {
                var model = await _purchasesServices.GetAllPurchasesWithItemDetailsAsync();
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
        
        [HttpGet("AllCombinedPurchase")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<IEnumerable<CombinedPurchaseDTO>>> GetAllCombinedPurchaseAsync()
        {
            try
            {
                var model = await _purchasesServices.GetAllCombinedPurchaseAsync();
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
        
        
        [HttpGet("GetAllByItemId/{itemId}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<IEnumerable<PurchasesDTO>>> GetAllByItemId(int itemId)
        {
            try
            {
                var model = await _purchasesServices.GetAllByItemIdAsync(itemId);
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
        public async Task<ActionResult<PurchasesDTO>> GetPurchasesById([FromRoute] int Id)
        {
            try
            {
                var model = await _purchasesServices.GetByIdAsync(Id);
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
        public async Task<ActionResult> AddPurchases([FromBody] PurchasesDTO model)
        {
            try
            {

                if (model is null)
                {
                    _logger.LogWarning("model is null  - not found.");
                    return BadRequest("model data cannot be null.");
                }

                int newId = await _purchasesServices.AddAsync(model);
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
        public async Task<ActionResult> UpdatePurchases([FromRoute] int Id, [FromBody] PurchasesDTO model)
        {


            try
            {
                if (Id != model.Id)
                {
                 
                    _logger.LogWarning("model ID mismatch.");

                    return BadRequest("model ID mismatch.");
                }


                await _purchasesServices.UpdateAsync(model);

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
        public async Task<ActionResult> DeletePurchases([FromRoute] int Id)
        {
            try
            {
                await _purchasesServices.DeleteAsync(Id);
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
