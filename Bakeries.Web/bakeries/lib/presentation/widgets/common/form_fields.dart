import 'package:flutter/material.dart';

class FormFields {
  static Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    bool enabled = true,
    bool filled = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: filled,
        helperText:
            keyboardType == TextInputType.number ? 'أدخل رقماً صحيحاً' : null,
      ),
      maxLines: maxLines,
      enabled: enabled,
      keyboardType: keyboardType,
      validator: (value) {
        if (validator != null) {
          final result = validator(value);
          if (result != null) return result;
        }

        if (keyboardType == TextInputType.number &&
            value != null &&
            value.isNotEmpty) {
          if (double.tryParse(value) == null) {
            return 'الرجاء إدخال رقم صحيح';
          }
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
    );
  }

  static Widget buildDropdownField<T>({
    required T value,
    required List<T> items,
    required String label,
    required IconData icon,
    required void Function(T?) onChanged,
    required Widget Function(T) itemBuilder,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: items.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: itemBuilder(value),
        );
      }).toList(),
      onChanged: onChanged,
      isExpanded: true,
    );
  }
}
