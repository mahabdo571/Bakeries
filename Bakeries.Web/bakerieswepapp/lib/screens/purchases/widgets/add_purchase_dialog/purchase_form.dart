import 'package:flutter/material.dart';

import '../../../../models/Purchase.dart';
import 'form_sections/item_section.dart';
import 'form_sections/price_section.dart';
import 'form_sections/quantity_section.dart';
import 'form_sections/status_section.dart';
import 'form_sections/supplier_section.dart';

class PurchaseForm extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? purchaseData;
  final Function(Purchase) onSubmit;

  const PurchaseForm({
    Key? key,
    required this.isEdit,
    this.purchaseData,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _PurchaseFormState createState() => _PurchaseFormState();
}

class _PurchaseFormState extends State<PurchaseForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _supplierNameController = TextEditingController();
  final TextEditingController _supplierInvoiceNumberController =
      TextEditingController();

  double _unitPrice = 0;
  int _quantity = 0;
  int? _selectedItemId;
  String? _selectedUnit;
  String? _selectedPaymentMethod;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    if (widget.purchaseData != null) {
      _initializeFormData();
    }
  }

  void _initializeFormData() {
    final data = widget.purchaseData!;
    _notesController.text = data['Notes'] ?? '';
    _supplierNameController.text = data['SupplierName'] ?? '';
    _supplierInvoiceNumberController.text = data['SupplierInvoiceNumber'] ?? '';
    _unitPrice = data['UnitPrice'] ?? 0.0;
    _quantity = data['Quantity'] ?? 0;
    _selectedItemId = data['ItemId'];
    _selectedUnit = data['UnitOfMeasure'];
    _selectedPaymentMethod = data['PaymentMethod'];
    _selectedStatus = data['Status'];
  }

  @override
  void dispose() {
    _notesController.dispose();
    _supplierNameController.dispose();
    _supplierInvoiceNumberController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final purchase = Purchase(
        Id: widget.isEdit ? widget.purchaseData!['Id'] : 0,
        ItemId: _selectedItemId!,
        Quantity: _quantity,
        UnitPrice: _unitPrice,
        UnitOfMeasure: _selectedUnit!,
        PaymentMethod: _selectedPaymentMethod!,
        Status: _selectedStatus!,
        Notes: _notesController.text,
        TotalPrice: _quantity * _unitPrice,
        ItemName: '',
        ItemDescription: '',
        SupplierName: _supplierNameController.text,
        SupplierInvoiceNumber: _supplierInvoiceNumberController.text,
      );

      widget.onSubmit(purchase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ItemSection(
              selectedItemId: _selectedItemId,
              onItemSelected: (id) => setState(() => _selectedItemId = id),
            ),
            const SizedBox(height: 16),
            SupplierSection(
              supplierNameController: _supplierNameController,
              supplierInvoiceNumberController: _supplierInvoiceNumberController,
            ),
            const SizedBox(height: 16),
            PriceSection(
              unitPrice: _unitPrice,
              quantity: _quantity,
              onUnitPriceChanged: (price) => setState(() => _unitPrice = price),
            ),
            const SizedBox(height: 16),
            QuantitySection(
              quantity: _quantity,
              selectedUnit: _selectedUnit,
              onQuantityChanged: (q) => setState(() => _quantity = q),
              onUnitChanged: (unit) => setState(() => _selectedUnit = unit),
            ),
            const SizedBox(height: 16),
            StatusSection(
              selectedPaymentMethod: _selectedPaymentMethod,
              selectedStatus: _selectedStatus,
              onPaymentMethodChanged: (method) =>
                  setState(() => _selectedPaymentMethod = method),
              onStatusChanged: (status) =>
                  setState(() => _selectedStatus = status),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'ملاحظات'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'يجب إدخال الملاحظات' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: Text(widget.isEdit ? 'تعديل' : 'إضافة'),
            ),
          ],
        ),
      ),
    );
  }
}
