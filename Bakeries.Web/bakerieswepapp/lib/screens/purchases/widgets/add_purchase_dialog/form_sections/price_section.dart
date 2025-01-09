import 'package:flutter/material.dart';

class PriceSection extends StatelessWidget {
  final double unitPrice;
  final double quantity;
  final Function(double) onUnitPriceChanged;

  const PriceSection({
    Key? key,
    required this.unitPrice,
    required this.quantity,
    required this.onUnitPriceChanged,
  }) : super(key: key);

  double get totalPrice => unitPrice * quantity;

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
          child: TextFormField(
            enabled: false,
            key: ValueKey(totalPrice), // Force rebuild when total changes
            initialValue: totalPrice.toStringAsFixed(2),
            decoration: const InputDecoration(labelText: 'السعر الكلي'),
          ),
        ),
      ],
    );
  }
}
