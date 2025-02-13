import 'package:bakerieswepapp/Screens/stock/widgets/stock_detail_item.dart';
import 'package:bakerieswepapp/models/finished_product_inventory.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/Stock.dart';


class FinishedProductInventoryCard extends StatelessWidget {
  final FinishedProductInventory finishedProductInventory;
  final Function(FinishedProductInventory) onEdit;
  final Function(int) onDelete;

  const FinishedProductInventoryCard({
    Key? key,
    required this.finishedProductInventory,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // تحديد حالة الموبايل باستخدام العرض العام للشاشة
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 24,
        vertical: 8,
      ),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        // حشوة داخلية تناسب حجم الشاشة
        padding: EdgeInsets.all(isMobile ? 12 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(isMobile),
            const SizedBox(height: 8),
            const Divider(height: 1),
            const SizedBox(height: 8),
            _buildDetails(isMobile),
            const SizedBox(height: 8),
            const Divider(height: 1),
            const SizedBox(height: 8),
            _buildActions(isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.inventory,
          color: Colors.blueGrey[700],
          size: isMobile ? 22 : 28,
        ),
        SizedBox(width: isMobile ? 10 : 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                finishedProductInventory.ItemName,
                style: TextStyle(
                  fontSize: isMobile ? 18 : 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (finishedProductInventory.Notes.isNotEmpty) ...[
                SizedBox(height: isMobile ? 4 : 6),
                Text(
                  finishedProductInventory.Notes,
                  style: TextStyle(
                    fontSize: isMobile ? 13 : 15,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetails(bool isMobile) {
    return Wrap(
      spacing: isMobile ? 12 : 20,
      runSpacing: isMobile ? 12 : 16,
      children: [
        StockDetailItem(
          icon: Icons.inventory,
          label: 'الكمية',
          value: finishedProductInventory.AvailableQuantity.toString(),
          isHorizontal: true,
          isMobile: isMobile,
        ),
        StockDetailItem(
          icon: Icons.category,
          label: 'الوحدة',
          value: finishedProductInventory.Unit,
          isHorizontal: true,
          isMobile: isMobile,
        ),
        StockDetailItem(
          icon: Icons.date_range,
          label: 'تاريخ اخر تحديث',
          value: _formatDate(finishedProductInventory.UpdatedAt),
          isHorizontal: true,
          isMobile: isMobile,
        ),
        StockDetailItem(
          icon: Icons.date_range,
          label: 'تاريخ الاضافة',
          value: _formatDate(finishedProductInventory.CreatedAt),
          isHorizontal: true,
          isMobile: isMobile,
        ),
      ],
    );
  }

  String _formatDate(DateTime? date) {
    return DateFormat('dd/MM/yyyy (HH:mm)')
        .format(date ?? DateTime.now())
        .toString();
  }

  Widget _buildActions(bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.edit, size: isMobile ? 18 : 20),
          label: Text(
            'تعديل',
            style: TextStyle(fontSize: isMobile ? 14 : 16),
          ),
          onPressed: () => onEdit(finishedProductInventory),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12 : 16,
              vertical: isMobile ? 8 : 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          icon: Icon(Icons.delete, size: isMobile ? 18 : 20),
          label: Text(
            'حذف',
            style: TextStyle(fontSize: isMobile ? 14 : 16),
          ),
          onPressed: () => onDelete(finishedProductInventory.Id),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12 : 16,
              vertical: isMobile ? 8 : 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
