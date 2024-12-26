import 'dart:convert';
import 'package:bakerieswepapp/models/Stock.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api_config.dart';

class AddStockDialog extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? stockData;
  final Function(Map<String, dynamic>)? onAdd;
  final Function(Map<String, dynamic>)? onEdit;

  AddStockDialog({
    this.isEdit = false,
    this.stockData,
    this.onAdd,
    this.onEdit,
  });

  @override
  _AddStockDialogState createState() => _AddStockDialogState();
}

class _AddStockDialogState extends State<AddStockDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _itemDescriptionController;
  late TextEditingController _itemNameController;
  late TextEditingController _quantityController;
  late TextEditingController _locationController;
  late TextEditingController _reorderLevelController;

  bool _isLoading = true; // حالة التحميل

  final List<String> _units = [
    'غرام',
    'كيلو غرام',
    'طن',
    'لتر',
    'كيلو وات',
    'شيكل'
  ];

  String? _selectedUnit;

  @override
  void initState() {
    super.initState();

    _itemDescriptionController = TextEditingController(
        text: widget.stockData?['Notes'].toString() ?? '');

    _locationController = TextEditingController(
        text: widget.stockData?['Location'].toString() ?? '');

    _reorderLevelController = TextEditingController(
        text: widget.stockData?['ReorderLevel'].toString() ?? '');

    _itemNameController =
        TextEditingController(text: widget.stockData?['ItemName'] ?? '');

    _quantityController = TextEditingController(
        text: widget.stockData?['QuantityInStock'].toString() ?? '');

    _selectedUnit = widget.stockData?['UnitOfMeasure'];
  }

  @override
  void dispose() {
    _itemDescriptionController.dispose();
    _itemNameController.dispose();
    _reorderLevelController.dispose();
    _locationController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final stock = Stock(
        Id: widget.isEdit ? widget.stockData!['Id'] ?? 0 : 0,
        ItemName: _itemNameController.text,
        Notes: _itemDescriptionController.text,
        AvailableQuantity: int.tryParse(_quantityController.text) ?? 0,
        UnitOfMeasure: _selectedUnit.toString(),
        Location: _locationController.text,
        ReorderLevel: int.tryParse(_reorderLevelController.text) ?? 0,
      );

      final url = widget.isEdit
          ? Uri.parse('${ApiConfig.StockById}${stock.Id}')
          : Uri.parse(ApiConfig.stock);

      final stockTojson = stock.toJson();

      try {
        final response = widget.isEdit
            ? await http.put(
                url,
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(stockTojson),
              )
            : await http.post(
                url,
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(stockTojson),
              );

        if (response.statusCode == 200 || response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Item ${widget.isEdit ? "updated" : "added"} successfully!')),
          );

          widget.isEdit
              ? widget.onEdit?.call(stock.toJson())
              : widget.onAdd?.call(stock.toJson());
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to add/update Item: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double fieldWidth =
        MediaQuery.of(context).size.width * 0.4; // تحديد العرض النسبي للحقول

    return AlertDialog(
      title: Text(widget.isEdit ? 'تعديل عملية شراء' : 'إضافة عملية شراء'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          // للتأكد من دعم التمرير إذا زاد المحتوى
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // صف يحتوي على الحقلين "اسم الصنف" و "اسم المورد"
              Row(
                children: [
                  Container(
                    width: fieldWidth,
                    child: TextFormField(
                      controller: _itemNameController,
                      decoration: InputDecoration(labelText: 'اسم الصنف '),
                      validator: (value) =>
                          value!.isEmpty ? 'يجب إدخال اسم الصنف ' : null,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: fieldWidth,
                    child: TextFormField(
                      controller: _locationController,
                      decoration:
                          InputDecoration(labelText: 'الموقع في المخزن'),
                      validator: (value) =>
                          value!.isEmpty ? 'يجب إدخال الموقع ' : null,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),
              // صف يحتوي على الحقلين "الكمية" و "وحدة القياس"
              Row(
                children: [
                  Container(
                    width: fieldWidth,
                    child: TextFormField(
                      controller: _quantityController,
                      keyboardType:
                          TextInputType.numberWithOptions(signed: true),
                      decoration: InputDecoration(labelText: 'الكمية'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يجب إدخال الكمية';
                        } else if (!RegExp(r'^[+-]?\d+$').hasMatch(value)) {
                          return 'أدخل رقم صحيح';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: fieldWidth,
                    child: TextFormField(
                      controller: _reorderLevelController,
                      keyboardType:
                          TextInputType.numberWithOptions(signed: true),
                      decoration: InputDecoration(labelText: 'ادنى كمية للطلب'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يجب إدخال الحد الادنى';
                        } else if (!RegExp(r'^[+-]?\d+$').hasMatch(value)) {
                          return 'أدخل رقم صحيح';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: fieldWidth,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'وحدة القياس'),
                      value: _selectedUnit,
                      items: _units.map((unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _selectedUnit = value;
                      },
                      validator: (value) =>
                          value == null ? 'يجب اختيار وحدة قياس' : null,
                    ),
                  ),
                ],
              ),
              // صف يحتوي على الحقلين "طريقة الدفع" و "حالة الفاتورة"

              TextFormField(
                controller: _itemDescriptionController,
                maxLines: 3,
                decoration: InputDecoration(labelText: 'ملاحظات'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'يجب إدخال الملاحظات' : null,
              ),
            ],
          ),
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
