import 'package:flutter/material.dart';

import '/models/product.dart';
import '/models/purchase.dart';

class AddEditPurchaseDialog extends StatefulWidget {
  final Purchase? purchase;
  final List<Product> products;
  final Function(Purchase) onSave;

  const AddEditPurchaseDialog({
    Key? key,
    this.purchase,
    required this.products,
    required this.onSave,
  }) : super(key: key);

  @override
  _AddEditPurchaseDialogState createState() => _AddEditPurchaseDialogState();
}

class _AddEditPurchaseDialogState extends State<AddEditPurchaseDialog> {
  final _formKey = GlobalKey<FormState>();
  late Product? _selectedProduct;
  late TextEditingController _itemDescriptionController;
  late TextEditingController _notesController;
  late TextEditingController _supplierNameController;
  late TextEditingController _supplierInvoiceNumberController;
  late TextEditingController _quantityController;
  late String _selectedUnitOfMeasure;
  late TextEditingController _unitPriceController;
  late TextEditingController _totalPriceController;
  late String _selectedPaymentMethod;
  late String _selectedStatus;

  final List<String> _unitOfMeasureOptions = ['كيلو غرام', 'غرام', 'لتر'];
  final List<String> _paymentMethodOptions = ['كاش', 'شيك'];
  final List<String> _statusOptions = ['مدفوع', 'غير مدفوع', 'مؤرشف', 'ملغي'];

  @override
  void initState() {
    super.initState();
    _selectedProduct = widget.purchase != null
        ? widget.products.firstWhere((p) => p.id == widget.purchase!.itemId,
            orElse: () => widget.products.first)
        : null;
    _itemDescriptionController =
        TextEditingController(text: widget.purchase?.itemDescription ?? '');
    _notesController =
        TextEditingController(text: widget.purchase?.notes ?? '');
    _supplierNameController =
        TextEditingController(text: widget.purchase?.supplierName ?? '');
    _supplierInvoiceNumberController = TextEditingController(
        text: widget.purchase?.supplierInvoiceNumber ?? '');
    _quantityController =
        TextEditingController(text: widget.purchase?.quantity.toString() ?? '');
    _selectedUnitOfMeasure =
        widget.purchase?.unitOfMeasure ?? _unitOfMeasureOptions.first;
    _unitPriceController = TextEditingController(
        text: widget.purchase?.unitPrice.toString() ?? '');
    _totalPriceController = TextEditingController(
        text: widget.purchase?.totalPrice.toString() ?? '');
    _selectedPaymentMethod =
        widget.purchase?.paymentMethod ?? _paymentMethodOptions.first;
    _selectedStatus = widget.purchase?.status ?? _statusOptions.first;

    _quantityController.addListener(_calculateTotalPrice);
    _unitPriceController.addListener(_calculateTotalPrice);
  }

  void _calculateTotalPrice() {
    if (_quantityController.text.isNotEmpty &&
        _unitPriceController.text.isNotEmpty) {
      int quantity = int.tryParse(_quantityController.text) ?? 0;
      double unitPrice = double.tryParse(_unitPriceController.text) ?? 0;
      double totalPrice = quantity * unitPrice;
      _totalPriceController.text = totalPrice.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _quantityController.removeListener(_calculateTotalPrice);
    _unitPriceController.removeListener(_calculateTotalPrice);
    _itemDescriptionController.dispose();
    _notesController.dispose();
    _supplierNameController.dispose();
    _supplierInvoiceNumberController.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    _totalPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.purchase == null
          ? 'إضافة عملية شراء جديدة'
          : 'تعديل عملية الشراء'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<Product>(
                value: _selectedProduct,
                items: widget.products.map((Product product) {
                  return DropdownMenuItem<Product>(
                    value: product,
                    child: Text(product.itemName),
                  );
                }).toList(),
                onChanged: (Product? newValue) {
                  setState(() {
                    _selectedProduct = newValue;
                  });
                },
                decoration: InputDecoration(labelText: 'اختر المنتج'),
                validator: (value) =>
                    value == null ? 'الرجاء اختيار منتج' : null,
              ),
              TextFormField(
                controller: _itemDescriptionController,
                decoration: InputDecoration(labelText: 'وصف المنتج'),
              ),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(labelText: 'ملاحظات'),
              ),
              TextFormField(
                controller: _supplierNameController,
                decoration: InputDecoration(labelText: 'اسم المورد'),
                validator: (value) =>
                    value!.isEmpty ? 'الرجاء إدخال اسم المورد' : null,
              ),
              TextFormField(
                controller: _supplierInvoiceNumberController,
                decoration: InputDecoration(labelText: 'رقم فاتورة المورد'),
                validator: (value) =>
                    value!.isEmpty ? 'الرجاء إدخال رقم فاتورة المورد' : null,
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'الكمية'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'الرجاء إدخال الكمية' : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedUnitOfMeasure,
                items: _unitOfMeasureOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedUnitOfMeasure = newValue!;
                  });
                },
                decoration: InputDecoration(labelText: 'وحدة القياس'),
                validator: (value) =>
                    value == null ? 'الرجاء اختيار وحدة القياس' : null,
              ),
              TextFormField(
                controller: _unitPriceController,
                decoration: InputDecoration(labelText: 'سعر الوحدة'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'الرجاء إدخال سعر الوحدة' : null,
              ),
              TextFormField(
                controller: _totalPriceController,
                decoration: InputDecoration(labelText: 'السعر الإجمالي'),
                keyboardType: TextInputType.number,
                readOnly: true,
                enabled: false,
              ),
              DropdownButtonFormField<String>(
                value: _selectedPaymentMethod,
                items: _paymentMethodOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPaymentMethod = newValue!;
                  });
                },
                decoration: InputDecoration(labelText: 'طريقة الدفع'),
                validator: (value) =>
                    value == null ? 'الرجاء اختيار طريقة الدفع' : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                items: _statusOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedStatus = newValue!;
                  });
                },
                decoration: InputDecoration(labelText: 'الحالة'),
                validator: (value) =>
                    value == null ? 'الرجاء اختيار الحالة' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('إلغاء'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text(widget.purchase == null ? 'إضافة' : 'تعديل'),
          onPressed: () {
            if (_formKey.currentState!.validate() && _selectedProduct != null) {
              final purchase = Purchase(
                id: widget.purchase?.id ?? 0,
                itemName: _selectedProduct!.itemName,
                itemDescription: _itemDescriptionController.text,
                notes: _notesController.text,
                supplierName: _supplierNameController.text,
                itemId: _selectedProduct!.id,
                supplierInvoiceNumber: _supplierInvoiceNumberController.text,
                quantity: int.parse(_quantityController.text),
                unitOfMeasure: _selectedUnitOfMeasure,
                unitPrice: double.parse(_unitPriceController.text),
                totalPrice: double.parse(_totalPriceController.text),
                paymentMethod: _selectedPaymentMethod,
                status: _selectedStatus,
              );
              widget.onSave(purchase);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
