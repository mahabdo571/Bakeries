import 'package:flutter/material.dart';
import 'package:bakerieswepapp/constants/units.dart';

class PriceSection extends StatelessWidget {
  final double unitPrice;
  final Function(String) onUnitChanged;
  final Function(double) onUnitPriceChanged;

  final String? selectedUnit;
  const PriceSection({
    Key? key,
    required this.unitPrice,
    required this.selectedUnit,
    required this.onUnitChanged,
    required this.onUnitPriceChanged,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: unitPrice.toString(),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'سعر الوحدة'),
            onChanged: (val) => onUnitPriceChanged(double.tryParse(val) ?? 0),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'يجب إدخال السعر';
              if (!RegExp(r'^\d*\.?\d+$').hasMatch(value!))
                return 'أدخل رقم صحيح';
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
