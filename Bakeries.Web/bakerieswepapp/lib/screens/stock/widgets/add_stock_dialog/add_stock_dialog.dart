import 'package:bakerieswepapp/models/Stock.dart';
import 'package:bakerieswepapp/screens/stock/widgets/add_stock_dialog/stock_form.dart';
import 'package:bakerieswepapp/services/stock_service.dart';
import 'package:flutter/material.dart';

class AddStockDialog extends StatelessWidget {
  final bool isEdit;
  final Map<String, dynamic>? stockData;
  final Function(Map<String, dynamic>)? onAdd;
  final Function(Map<String, dynamic>)? onEdit;

  const AddStockDialog({
    Key? key,
    this.isEdit = false,
    this.stockData,
    this.onAdd,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEdit ? 'تعديل عملية شراء' : 'إضافة عملية شراء'),
      content: StockForm(
        isEdit: isEdit,
        stockData: stockData,
        onSubmit: (purchase) => _handleSubmit(context, purchase),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('إلغاء'),
        ),
      ],
    );
  }

  Future<void> _handleSubmit(BuildContext context, Stock stock) async {
    try {
      if (isEdit) {
        await StockService.updateStock(stock.Id, stock);

        onEdit?.call(stock.toJson());
      } else {
        final newstock = await StockService.addStock(stock);
        onAdd?.call(newstock.toJson());
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('تم ${isEdit ? "تعديل" : "إضافة"} عملية الشراء بنجاح')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $e')),
      );
    }
  }
}
