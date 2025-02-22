using Bakeries.Business.Services;
using Bakeries.Business.Services.IServices;
using Business.Shared.DTOs;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Bakeries.API.Controllers
{
    [Route("api/Product")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly IProductServices _productServices;
        private readonly ILogger<ProductController> _logger;

        public ProductController(IProductServices productServices, ILogger<ProductController> logger)
        {
            _productServices = productServices;
            _logger = logger;
        }


        [HttpGet("All")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<IEnumerable<ProductDTO>>> GetAllProduct()
        {

            try
            {
                var model = await _productServices.GetAllAsync();
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
        
        
        [HttpGet("GetProductsWithComponents")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<IEnumerable<ProductDTO>>> GetProductsWithComponents()
        {

            try
            {
                var model = await _productServices.GetProductsWithComponentsServes();
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
        public async Task<ActionResult<ProductDTO>> GetProductById([FromRoute] int Id)
        {
            try
            {
                var model = await _productServices.GetByIdAsync(Id);
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
        public async Task<ActionResult> AddStock([FromBody] ProductDTO model)
        {
            try
            {

                if (model is null)
                {
                    _logger.LogWarning("model is null  - not found.");
                    return BadRequest("model data cannot be null.");
                }

                int newId = await _productServices.AddAsync(model);
                model.Id = newId;


                return CreatedAtAction(nameof(GetProductById), new { Id = newId }, model);
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
        public async Task<ActionResult> UpdateProduct([FromRoute] int Id, [FromBody] ProductDTO model)
        {


            try
            {
                if (Id != model.Id)
                {
                    _logger.LogWarning("model is null  - not found.");

                    return BadRequest("model ID mismatch.");
                }


                await _productServices.UpdateAsync(model);

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
                await _productServices.DeleteAsync(Id);
                return Ok(new { Message = $"تم بنجاح", Details = "" });
            }
            catch (KeyNotFoundException ex)
            {
                _logger.LogError(ex.Message);
                return NotFound(new { Message = $"خطأ في عملية الحذف", Details = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return StatusCode(StatusCodes.Status500InternalServerError, new { Message = $"خطأ في عملية الحذف", Details = ex.Message });
            }
        }


    }
}
