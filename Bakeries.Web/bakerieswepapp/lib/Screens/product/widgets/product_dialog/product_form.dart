import 'package:flutter/material.dart';

import '../../../../Screens/product/widgets/product_dialog/form_sections/price_section.dart';
import '../../../../models/product.dart';

class ProductForm extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? productData;
  final Function(Product) onSubmit;

  const ProductForm({
    Key? key,
    required this.isEdit,
    this.productData,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  double _unitPrice = 0;
  String? _selectedUnit;

  @override
  void initState() {
    super.initState();
    if (widget.productData != null) {
      _initializeFormData();
    }
  }

  void _initializeFormData() {
    final data = widget.productData!;
    _notesController.text = data['Notes'] ?? '';
    _nameController.text = data['Name'] ?? '';
    _descriptionController.text = data['Description'] ?? '';
    _unitPrice = data['Price'];

    _selectedUnit = data['Unit'];
  }

  @override
  void dispose() {
    _notesController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final product = Product(
        Id: widget.isEdit ? widget.productData!['Id'] : 0,
        Name: _nameController.text,
        Description: _descriptionController.text,
        Notes: _notesController.text,
        Price: _unitPrice,
        Unit: _selectedUnit ?? '',
      );

      widget.onSubmit(product);
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
            TextFormField(
              controller: _nameController,
              maxLines: 1,
              decoration: const InputDecoration(labelText: 'الاسم'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'يجب إدخال الاسم' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'تفاصيل'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'يجب إدخال التفاصيل' : null,
            ),
            const SizedBox(height: 16),
            PriceSection(
              unitPrice: _unitPrice,
              selectedUnit: _selectedUnit,
              onUnitChanged: (q) => setState(() => _selectedUnit = q),
              onUnitPriceChanged: (p) => setState(() => _unitPrice = p),
            ),
            SizedBox(height: 16),
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
