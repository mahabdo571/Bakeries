import '../../../../models/Stock.dart';
import '../../../../models/product.dart';
import '../../../../models/production.dart';
import '../../../../services/product_service.dart';
import '../../../../services/production_service.dart';
import '../../../../services/stock_service.dart';

import 'package:flutter/material.dart';

class ProductItemSection extends StatefulWidget {
  final int? selectedItemId;
  final Function(int) onItemSelected;

  const ProductItemSection({
    Key? key,
    this.selectedItemId,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  _ItemSectionState createState() => _ItemSectionState();
}

class _ItemSectionState extends State<ProductItemSection> {
  bool _isLoading = true;
  List<Product> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      final items = await ProductService.GetProductsWithComponents();
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
      decoration: const InputDecoration(labelText: 'اختيار منتج'),
      value: widget.selectedItemId,
      items: _items.map((item) {
        return DropdownMenuItem<int>(
          value: item.Id,
          child: Text(item.Name.toString()),
        );
      }).toList(),
      onChanged: (value) => widget.onItemSelected(value!),
      validator: (value) => value == null ? 'يجب اختيار المنتج' : null,
    );
  }
}
