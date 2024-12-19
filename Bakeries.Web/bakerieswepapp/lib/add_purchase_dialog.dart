import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bakerieswepapp/Model/Purchase.dart'; // استيراد الموديل

class AddPurchaseDialog extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? purchaseData;
  final Function(Map<String, dynamic>)? onAdd;
  final Function(Map<String, dynamic>)? onEdit;

  AddPurchaseDialog({
    this.isEdit = false,
    this.purchaseData,
    this.onAdd,
    this.onEdit,
  });

  @override
  _AddPurchaseDialogState createState() => _AddPurchaseDialogState();
}

class _AddPurchaseDialogState extends State<AddPurchaseDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _itemController;
  late TextEditingController _quantityController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _itemController =
        TextEditingController(text: widget.purchaseData?['ItemName'] ?? '');
    _quantityController =
        TextEditingController(text: widget.purchaseData?['Quantity'] ?? '');
    _priceController =
        TextEditingController(text: widget.purchaseData?['UnitPrice'] ?? '');
  }

  @override
  void dispose() {
    _itemController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final purchase = Purchase(
        Id: widget.isEdit
            ? widget.purchaseData!['Id'] ?? 0
            : DateTime.now().millisecondsSinceEpoch,
        ItemName: _itemController.text,
        Quantity: int.parse(_quantityController.text),
        UnitPrice: double.parse(_priceController.text),
      );

      final url = widget.isEdit
          ? Uri.parse('http://localhost:5145/api/Purchases/${purchase.id}')
          : Uri.parse('http://localhost:5145/api/Purchases');

      final purchaseData = purchase.toJson();

      try {
        final response = widget.isEdit
            ? await http.put(
                url,
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(purchaseData),
              )
            : await http.post(
                url,
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(purchaseData),
              );

        if (response.statusCode == 200 || response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Purchase ${widget.isEdit ? "updated" : "added"} successfully!')),
          );

          widget.isEdit
              ? widget.onEdit?.call(purchase.toJson())
              : widget.onAdd?.call(purchase.toJson());
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Failed to add/update purchase: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEdit ? 'تعديل عملية شراء' : 'إضافة عملية شراء'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _itemController,
              decoration: InputDecoration(labelText: 'اسم العنصر'),
              validator: (value) =>
                  value!.isEmpty ? 'يجب إدخال اسم العنصر' : null,
            ),
            TextFormField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'الكمية'),
              validator: (value) => value!.isEmpty ? 'يجب إدخال الكمية' : null,
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'السعر'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'يجب إدخال السعر' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: submitForm,
          child: Text(widget.isEdit ? 'تعديل' : 'إضافة'),
        ),
      ],
    );
  }
}
