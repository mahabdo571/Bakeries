using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Shared.DTOs
{
    public class ProductIngredientDTO
    {
        public int Id { get; set; }

        [Required]
        [Range(0, double.MaxValue)]
        public double Quantity { get; set; } // الكمية المطلوبة من المكون لإنتاج المنتج

        [Required]
        [StringLength(50)] // تحديد الحد الأقصى لعدد الحروف
        public string UnitOfMeasure { get; set; } // وحدة القياس
    }
}
