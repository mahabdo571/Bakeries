using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Shared.Enums
{
    public enum PaymentMethod
    {
        [Display(Name = "غير معرف")]
        none = 0,
        [Display(Name = "كاش")]
        cash = 1,
        [Display(Name = "شيك")]
        Acheck = 2,
        [Display(Name = "دين")]
        debt = 3,
    }
}
