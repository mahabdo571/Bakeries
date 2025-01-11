import 'package:bakerieswepapp/Screens/production/widgets/production_dialog/product_item_section.dart';
import 'package:bakerieswepapp/models/production.dart';
import 'package:flutter/material.dart';

class ProductionForm extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? ProductionData;
  final Function(Production) onSubmit;

  const ProductionForm({
    Key? key,
    required this.isEdit,
    this.ProductionData,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _ProductionFormState createState() => _ProductionFormState();
}

class _ProductionFormState extends State<ProductionForm> {
  final _formKey = GlobalKey<FormState>();
  int? _selectedItemId;

  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.ProductionData != null) {
      _initializeFormData();
    }
  }

  void _initializeFormData() {
    final data = widget.ProductionData!;
    _notesController.text = data['Notes'] ?? '';
  }

  @override
  void dispose() {
    _notesController.dispose();

    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final product = Production(
        Id: widget.isEdit ? widget.ProductionData!['Id'] : 0,
        QuantityProduced: 11,
        QuantityDamaged: 12,
        Notes: _notesController.text,
        ProductId: 8,
        ProductName: '',
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
            ProductItemSection(
              selectedItemId: _selectedItemId,
              onItemSelected: (id) => setState(() => _selectedItemId = id),
            ),
            SizedBox(
              height: 10,
            ),
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
