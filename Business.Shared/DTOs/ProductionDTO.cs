using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Shared.DTOs
{
    public record ProductionDTO
    {
    
        public int Id { get; set; }
        [Required]
        public float QuantityProduced { get; set; }

        [Required]
        public float QuantityDamaged { get; set; }

        public string Notes { get; set; }

        [Required]
        public int ProductId { get; set; }



        public DateTime? CreatedAt { get; set; }

        public DateTime? UpdatedAt { get; set; }



    }

   


}
