

using System.ComponentModel.DataAnnotations;

namespace Business.Shared.Enums
{
    public enum UnitOfMeasure
    {
        [Display(Name = "غير معرف")]
        none = 0,
        [Display(Name = "كيلو غرام")]
        Kilogram = 1,
        [Display(Name = "غرام")]
        Gram = 2,
        [Display(Name = "لتر")]
        Liter = 3,     
        [Display(Name = "حبة")]
        Unit = 4
    }
}
