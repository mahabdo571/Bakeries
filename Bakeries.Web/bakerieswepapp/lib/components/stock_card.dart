// import 'dart:convert';

import 'package:bakerieswepapp/models/Stock.dart';
import 'package:flutter/material.dart';

class StockCard extends StatelessWidget {
  final Stock stock;
  final Function(Stock) onEdit;
  final Function(int) onDelete;

  StockCard(
      {required this.stock, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.shopping_cart, color: Colors.brown, size: 24),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    stock.ItemName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              stock.Notes,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailItem(Icons.inventory, 'الكمية المتوفرة',
                    '${stock.QuantityInStock}'),
                _buildDetailItem(Icons.payment, 'الحد الادنى للطلب',
                    stock.ReorderLevel.toString()),
                _buildDetailItem(
                    Icons.person, 'الموقع في المخزن', stock.Location),
                _buildDetailItem(Icons.upcoming_outlined, 'وحدة القياس',
                    stock.UnitOfMeasure),
              ],
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.edit, color: Colors.white),
                    label: Text('تعديل'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () => onEdit(stock),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    icon: Icon(Icons.delete, color: Colors.white),
                    label: Text('حذف'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () => onDelete(stock.Id),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.brown, size: 18),
            SizedBox(width: 5),
            Text(label,
                style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          ],
        ),
        Text(value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
