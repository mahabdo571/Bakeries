import 'package:flutter/material.dart';
import '../../../../../constants/units.dart';

class QuantitySection extends StatelessWidget {
  final double quantity;
  final String? selectedUnit;
  final Function(double) onQuantityChanged;
  final Function(String) onUnitChanged;

  const QuantitySection({
    Key? key,
    required this.quantity,
    required this.selectedUnit,
    required this.onQuantityChanged,
    required this.onUnitChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: quantity.toString(),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'الكمية'),
            onChanged: (val) => onQuantityChanged(double.tryParse(val) ?? 0),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'يجب إدخال الكمية';
              if (!RegExp(r'^\d+$').hasMatch(value!)) return 'أدخل رقم صحيح';
              return null;
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'وحدة القياس'),
            value: selectedUnit,
            items: units.map((unit) {
              return DropdownMenuItem<String>(
                value: unit,
                child: Text(unit),
              );
            }).toList(),
            onChanged: (value) => onUnitChanged(value!),
            validator: (value) => value == null ? 'يجب اختيار وحدة قياس' : null,
          ),
        ),
      ],
    );
  }
}
