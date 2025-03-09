using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Shared.Enums
{
    public enum OrderType
    {
        [Display(Name = "استلام من المحل")]
        PickUpFromStore = 1,
        [Display(Name = "توصيل")]
        delivery = 2,
        [Display(Name = "موزع")]
        Dealer = 3,
    
    }
}
