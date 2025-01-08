import '../../../../models/product_ingredient.dart';
import '../../../../screens/purchases/widgets/add_purchase_dialog/form_sections/item_section.dart';
import '../../../../screens/purchases/widgets/add_purchase_dialog/form_sections/quantity_section.dart';
import 'package:flutter/material.dart';

class AddUpdateForm extends StatefulWidget {
  final bool isEdit;
  final int productId;
  final Map<String, dynamic>? productIngredientData;
  final Function(ProductIngredient) onSubmit;

  const AddUpdateForm({
    Key? key,
    required this.isEdit,
    required this.productId,
    this.productIngredientData,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _AddUpdateFormState createState() => _AddUpdateFormState();
}

class _AddUpdateFormState extends State<AddUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _notesController = TextEditingController();

  int _quantity = 0;
  String? _unitOfMeasure;
  int? _itemSelected;

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

    _unitOfMeasure = data['UnitOfMeasure'] ?? '';
    _itemSelected = data['stockId'] ?? 0;
    _quantity = data['Quantity'] ?? 0;
  }

  @override
  void dispose() {
    _notesController.dispose();

    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final productIngredient = ProductIngredient(
          Id: widget.isEdit ? widget.productIngredientData!['Id'] : 0,
          Notes: _notesController.text,
          Quantity: _quantity,
          UnitOfMeasure: _unitOfMeasure ?? '',
          product: null,
          stock: null,
          ProductId: widget.productId,
          stockId: _itemSelected ?? 0);

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
            ItemSection(
              selectedItemId: _itemSelected,
              onItemSelected: (itemId) {
                setState(() => _itemSelected = itemId);
              },
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            QuantitySection(
              quantity: _quantity,
              selectedUnit: _unitOfMeasure,
              onQuantityChanged: (q) => setState(() => _quantity = q),
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
