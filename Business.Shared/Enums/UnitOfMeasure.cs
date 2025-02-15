

using System.ComponentModel.DataAnnotations;

namespace Business.Shared.Enums
{
    public enum UnitOfMeasure
    {
        [Display(Name = "كيلو غرام")]
        Kilogram = 1,
        [Display(Name = "غرام")]
        Gram = 2,
        [Display(Name = "لتر")]
        Liter = 3
    }
}
