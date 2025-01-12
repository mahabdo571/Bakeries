import 'package:bakerieswepapp/services/production_service.dart';

import '../../../../Screens/production/widgets/production_dialog/production_form.dart';
import '../../../../models/production.dart';
import 'package:flutter/material.dart';

class ProductionDialog extends StatelessWidget {
  final bool isEdit;
  final Map<String, dynamic>? ProductionData;
  final Function(Map<String, dynamic>)? onAdd;
  final Function(Map<String, dynamic>)? onEdit;

  const ProductionDialog({
    Key? key,
    this.isEdit = false,
    this.ProductionData,
    this.onAdd,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEdit ? 'تعديل العملية' : 'إضافة  عملية  جديد'),
      content: ProductionForm(
        isEdit: isEdit,
        ProductionData: ProductionData,
        onSubmit: (p) => _handleSubmit(context, p),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('إلغاء'),
        ),
      ],
    );
  }

  Future<void> _handleSubmit(BuildContext context, Production production) async {
    try {
      if (isEdit) {
        await ProductionService.updateProduction(production.Id, production);

        onEdit?.call(production.toJson());
      } else {
         final newProduct = await ProductionService.addProduction(production);
          onAdd?.call(newProduct.toJson());
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم ${isEdit ? "تعديل" : "إضافة"} عملية  بنجاح')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $e')),
      );
    }
  }
}
