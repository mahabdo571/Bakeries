import 'package:flutter/material.dart';

import '../../../../../models/Stock.dart';
import '../../../../../services/stock_service.dart';

class ItemSection extends StatefulWidget {
  final int? selectedItemId;
  final Function(int) onItemSelected;
  final bool isEdit;

  const ItemSection({
    Key? key,
    this.selectedItemId,
    required this.onItemSelected,
    required this.isEdit,
  }) : super(key: key);

  @override
  _ItemSectionState createState() => _ItemSectionState();
}

class _ItemSectionState extends State<ItemSection> {
  bool _isLoading = true;
  List<Stock> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      final items = await StockService.getStockItems();
      setState(() {
        _items = items;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في تحميل الأصناف: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(labelText: 'اختيار صنف'),
      value: widget.selectedItemId,
      items: _items.map((item) {
        return DropdownMenuItem<int>(
          enabled: !widget.isEdit,
          value: item.Id,
          child: Text(item.ItemName),
        );
      }).toList(),
      onChanged: (value) => widget.onItemSelected(value!),
      validator: (value) => value == null ? 'يجب اختيار صنف' : null,
    );
  }
}
