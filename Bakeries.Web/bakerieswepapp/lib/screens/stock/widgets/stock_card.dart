import 'package:flutter/material.dart';
import 'package:bakerieswepapp/models/Stock.dart';
import 'package:bakerieswepapp/screens/stock/widgets/stock_detail_item.dart';

class StockCard extends StatelessWidget {
  final Stock stock;
  final Function(Stock) onEdit;
  final Function(int) onDelete;

  const StockCard({
    Key? key,
    required this.stock,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const Divider(height: 24),
            _buildDetails(),
            const Divider(height: 24),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(Icons.inventory, color: Colors.brown, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stock.ItemName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                stock.Notes,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetails() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StockDetailItem(
              icon: Icons.inventory,
              label: 'الكمية',
              value: stock.AvailableQuantity.toString(),
            ),
            StockDetailItem(
              icon: Icons.category,
              label: 'الوحدة',
              value: stock.UnitOfMeasure,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          onPressed: () => onEdit(stock),
          icon: const Icon(Icons.edit, color: Colors.white),
          label: const Text('تعديل'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: () => onDelete(stock.Id),
          icon: const Icon(Icons.delete, color: Colors.white),
          label: const Text('حذف'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
      ],
    );
  }
}
