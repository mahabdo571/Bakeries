import 'package:flutter/material.dart';
import 'package:bakerieswepapp/constants/purchase_status.dart';
import 'package:bakerieswepapp/constants/payment_methods.dart';

class StatusSection extends StatelessWidget {
  final String? selectedPaymentMethod;
  final String? selectedStatus;
  final Function(String) onPaymentMethodChanged;
  final Function(String) onStatusChanged;

  const StatusSection({
    Key? key,
    required this.selectedPaymentMethod,
    required this.selectedStatus,
    required this.onPaymentMethodChanged,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'طريقة الدفع'),
            value: selectedPaymentMethod,
            items: paymentMethods.map((method) {
              return DropdownMenuItem<String>(
                value: method,
                child: Text(method),
              );
            }).toList(),
            onChanged: (value) => onPaymentMethodChanged(value!),
            validator: (value) => value == null ? 'يجب اختيار طريقة دفع' : null,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'حالة الفاتورة'),
            value: selectedStatus,
            items: purchaseStatuses.map((status) {
              return DropdownMenuItem<String>(
                value: status,
                child: Text(status),
              );
            }).toList(),
            onChanged: (value) => onStatusChanged(value!),
            validator: (value) => value == null ? 'يجب اختيار حالة الفاتورة' : null,
          ),
        ),
      ],
    );
  }
}