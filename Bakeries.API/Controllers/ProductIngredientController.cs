using Bakeries.Business.Services;
using Bakeries.Business.Services.IServices;
using Business.Shared.DTOs;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Bakeries.API.Controllers
{
    [Route("api/ProductIngredient")]
    [ApiController]
    public class ProductIngredientController : ControllerBase
    {
        private readonly IProductIngredientService _productIngredientService;
        private readonly ILogger<ProductIngredientController> _logger;

        public ProductIngredientController(IProductIngredientService productIngredientService, ILogger<ProductIngredientController> logger)
        {
            _productIngredientService = productIngredientService;
            _logger = logger;
        }


        [HttpGet("All")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<IEnumerable<ProductIngredientDTO>>> GetAllProductIngredient()
        {

            try
            {
                var model = await _productIngredientService.GetAllAsync();
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
        public async Task<ActionResult<ProductIngredientDTO>> GetProductIngredientById([FromRoute] int Id)
        {
            try
            {
                var model = await _productIngredientService.GetByIdAsync(Id);
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
        public async Task<ActionResult> AddProductIngredient([FromBody] ProductIngredientDTO model)
        {
            try
            {

                if (model is null)
                {
                    _logger.LogWarning("model is null  - not found.");
                    return BadRequest("model data cannot be null.");
                }

                int newId = await _productIngredientService.AddAsync(model);
                model.Id = newId;


                return CreatedAtAction(nameof(GetProductIngredientById), new { Id = newId }, model);
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
        public async Task<ActionResult> UpdateProductIngredient([FromRoute] int Id, [FromBody] ProductIngredientDTO model)
        {


            try
            {
                if (Id != model.Id)
                {
                    _logger.LogWarning("model is null  - not found.");

                    return BadRequest("model ID mismatch.");
                }


                await _productIngredientService.UpdateAsync(model);

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
        public async Task<ActionResult> DeleteProduct([FromRoute] int Id)
        {
            try
            {
                await _productIngredientService.DeleteAsync(Id);
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
