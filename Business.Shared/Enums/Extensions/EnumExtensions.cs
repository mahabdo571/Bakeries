using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Shared.Enums.Extensions
{
    public static class EnumExtensions
    {
        public static string GetDisplayName<TEnum>(this TEnum value)
        {
            if (value == null) return "Nono";

            var field = value.GetType().GetField(value.ToString());
            var attribute = (DisplayAttribute)Attribute.GetCustomAttribute(field, typeof(DisplayAttribute));
            return attribute?.Name ?? value.ToString();
        }
    }
}
