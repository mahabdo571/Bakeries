import 'package:flutter/material.dart';

class SupplierSection extends StatelessWidget {
  final TextEditingController supplierNameController;
  final TextEditingController supplierInvoiceNumberController;

  const SupplierSection({
    Key? key,
    required this.supplierNameController,
    required this.supplierInvoiceNumberController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: supplierNameController,
            decoration: const InputDecoration(labelText: 'اسم المورد - التاجر'),
            validator: (value) => value?.isEmpty ?? true ? 'يجب إدخال المورد' : null,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: supplierInvoiceNumberController,
            decoration: const InputDecoration(labelText: 'رقم الفاتورة'),
            validator: (value) => value?.isEmpty ?? true ? 'يجب إدخال رقم الفاتورة' : null,
          ),
        ),
      ],
    );
  }
}