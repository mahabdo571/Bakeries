import 'package:bakerieswepapp/models/product_ingredient.dart';
import 'package:flutter/material.dart';

class AddUpdateForm extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? productIngredientData;
  final Function(ProductIngredient) onSubmit;

  const AddUpdateForm({
    Key? key,
    required this.isEdit,
    this.productIngredientData,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _AddUpdateFormState createState() => _AddUpdateFormState();
}

class _AddUpdateFormState extends State<AddUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _reorderLevelController = TextEditingController();

  int _availableQuantity = 0;
  String? _unitOfMeasure;

  @override
  void initState() {
    super.initState();
    if (widget.productIngredientData != null) {
      _initializeFormData();
    }
  }

  void _initializeFormData() {
    final data = widget.productIngredientData!;
    _notesController.text = data['Notes'] ?? '';
    _itemNameController.text = data['ItemName'] ?? '';
    _unitOfMeasure = data['UnitOfMeasure'];
    _locationController.text = data['Location'] ?? '';
    _reorderLevelController.text = data['ReorderLevel'].toString();

    _availableQuantity = data['AvailableQuantity'] ?? 0;
  }

  @override
  void dispose() {
    _notesController.dispose();
    _itemNameController.dispose();
    _locationController.dispose();
    _reorderLevelController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final productIngredient = ProductIngredient(
        Id: widget.isEdit ? widget.productIngredientData!['Id'] : 0,

      );

      widget.onSubmit(productIngredient);
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
              controller: _itemNameController,
              decoration: const InputDecoration(labelText: 'اسم الصنف'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'يجب إدخال الاسم ' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'الموقع في المخزن'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'يجب إدخال الموقع ' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _reorderLevelController,
              decoration: const InputDecoration(labelText: 'ادنى كمية للطلب'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'يجب إدخال ادنى كمية  ' : null,
            ),
            const SizedBox(height: 16),
            QuantitySection(
              quantity: _availableQuantity,
              selectedUnit: _unitOfMeasure,
              onQuantityChanged: (q) => setState(() => _availableQuantity = q),
              onUnitChanged: (unit) => setState(() => _unitOfMeasure = unit),
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
