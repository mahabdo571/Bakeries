import 'package:flutter/material.dart';

import '/models/product.dart';
import '/utils/responsive_sizes.dart';

class AddEditProductDialog extends StatefulWidget {
  final Product? product;
  final Function(Product) onSave;

  const AddEditProductDialog({
    Key? key,
    this.product,
    required this.onSave,
  }) : super(key: key);

  @override
  _AddEditProductDialogState createState() => _AddEditProductDialogState();
}

class _AddEditProductDialogState extends State<AddEditProductDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _itemName;
  late double _availableQuantity;
  late String _unitOfMeasure;
  late int _reorderLevel;
  late String _location;
  late String _notes;

  @override
  void initState() {
    super.initState();
    _itemName = widget.product?.itemName ?? '';
    _availableQuantity = widget.product?.availableQuantity ?? 0;
    _unitOfMeasure = widget.product?.unitOfMeasure ?? 'كيلو غرام';
    _reorderLevel = widget.product?.reorderLevel ?? 0;
    _location = widget.product?.location ?? '';
    _notes = widget.product?.notes ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizes.isMobile(context)
        ? _buildMobileView()
        : _buildDesktopView();
  }

  Widget _buildMobileView() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'إضافة منتج جديد' : 'تعديل المنتج'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildDesktopView() {
    return AlertDialog(
      title: Text(widget.product == null ? 'إضافة منتج جديد' : 'تعديل المنتج'),
      content: SingleChildScrollView(
        child: Container(
          width: ResponsiveSizes.getDeviceWidth(context) * 0.3,
          child: _buildForm(),
        ),
      ),
      actions: [
        TextButton(
          child: Text('إلغاء'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text(widget.product == null ? 'إضافة' : 'تعديل'),
          onPressed: _saveProduct,
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: _itemName,
            decoration: InputDecoration(labelText: 'اسم المنتج'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال اسم المنتج';
              }
              return null;
            },
            onSaved: (value) => _itemName = value!,
          ),
          TextFormField(
            initialValue: _availableQuantity.toString(),
            decoration: InputDecoration(labelText: 'الكمية المتوفرة'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال الكمية المتوفرة';
              }
              if (double.tryParse(value) == null) {
                return 'الرجاء إدخال رقم صحيح';
              }
              return null;
            },
            onSaved: (value) => _availableQuantity = double.parse(value!),
          ),
          DropdownButtonFormField<String>(
            value: _unitOfMeasure,
            decoration: InputDecoration(labelText: 'وحدة القياس'),
            items: ['كيلو غرام', 'غرام', 'لتر'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء اختيار وحدة القياس';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _unitOfMeasure = value!;
              });
            },
            onSaved: (value) => _unitOfMeasure = value!,
          ),
          TextFormField(
            initialValue: _reorderLevel.toString(),
            decoration: InputDecoration(labelText: 'مستوى إعادة الطلب'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال مستوى إعادة الطلب';
              }
              if (int.tryParse(value) == null) {
                return 'الرجاء إدخال رقم صحيح';
              }
              return null;
            },
            onSaved: (value) => _reorderLevel = int.parse(value!),
          ),
          TextFormField(
            initialValue: _location,
            decoration: InputDecoration(labelText: 'الموقع'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال الموقع';
              }
              return null;
            },
            onSaved: (value) => _location = value!,
          ),
          TextFormField(
            initialValue: _notes,
            decoration: InputDecoration(labelText: 'ملاحظات'),
            onSaved: (value) => _notes = value ?? '',
          ),
          if (ResponsiveSizes.isMobile(context))
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text('إلغاء'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    child: Text(widget.product == null ? 'إضافة' : 'تعديل'),
                    onPressed: _saveProduct,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final product = Product(
        id: widget.product?.id ?? 0,
        itemName: _itemName,
        availableQuantity: _availableQuantity,
        unitOfMeasure: _unitOfMeasure,
        reorderLevel: _reorderLevel,
        location: _location,
        notes: _notes,
      );
      widget.onSave(product);
      Navigator.of(context).pop();
    }
  }
}

