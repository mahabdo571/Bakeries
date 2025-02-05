import '../../../../Screens/production/widgets/production_dialog/product_item_section.dart';
import '../../../../models/production.dart';
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
  double _quantityProduced = 0;
  double _quantityDamaged = 0;

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
    _quantityProduced = data['QuantityProduced'] ??0;;
    _quantityDamaged = data['QuantityDamaged'] ?? 0;
    _selectedItemId = data['ProductId'] ?? 0;
  }

  @override
  void dispose() {
    _notesController.dispose();

    _notesController.dispose();

    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final product = Production(
        Id: widget.isEdit ? widget.ProductionData!['Id'] : 0,
        QuantityProduced: _quantityProduced ?? 0,
        QuantityDamaged: _quantityDamaged ?? 0,
        Notes: _notesController.text,
        ProductId: _selectedItemId ?? 0,
        ProductName: null,
        CreatedAt: DateTime.now(),
        UpdatedAt: DateTime.now()
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
              initialValue: _quantityProduced.toString(),
              keyboardType: TextInputType.numberWithOptions(
                  decimal: true), // لتمكين إدخال الأرقام العشرية
              decoration: const InputDecoration(
                  labelText: '(1.4) الكمية المنتجة- بالكيلو غرام'),
              onChanged: (val) {
                _quantityProduced = double.tryParse(val) ?? 0;
              }, // استخدام double بدلاً من int
              validator: (value) {
                if (value?.isEmpty ?? true) return 'يجب إدخال الكمية';
                if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(value!))
                  return 'أدخل رقم صحيح';
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: _quantityDamaged.toString(),
              keyboardType: TextInputType.numberWithOptions(
                  decimal: true), // لتمكين إدخال الأرقام العشرية
              decoration: const InputDecoration(
                  labelText: '(1.3) الكمية التالفة- بالكيلو غرام'),
              onChanged: (val) {
                _quantityDamaged = double.tryParse(val) ?? 0;
              }, // استخدام double بدلاً من int
              validator: (value) {
                if (value?.isEmpty ?? true) return 'يجب إدخال الكمية';
                if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(value!))
                  return 'أدخل رقم صحيح';
                return null;
              },
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
