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
        PickUpFromStore = 0,
        [Display(Name = "توصيل")]
        delivery = 1,
        [Display(Name = "موزع")]
        Dealer = 2,
    
    }
}
