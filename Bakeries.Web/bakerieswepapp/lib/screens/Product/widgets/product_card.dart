import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/product.dart';
import 'product_detail_item.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function(Product) onEdit;
  final Function(int) onDelete;
  final Function(int) onClickOnTheIngredients;
  final Function(Product) onClickOnTheProduction;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
    required this.onClickOnTheIngredients,
    required this.onClickOnTheProduction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // تحديد حالة الموبايل بناءً على عرض الشاشة العام
    final isMobile = MediaQuery.of(context).size.width < 630;

    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 16, // تقليل الهوامش الأفقية لزيادة العرض
        vertical: 8,
      ),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 24), // زيادة الحشوة لارتفاع أكبر
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
      children: [
        Icon(
          Icons.inventory,
          color: Colors.brown,
          size: isMobile ? 22 : 26,
        ),
        SizedBox(width: isMobile ? 10 : 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.Name,
                style: TextStyle(
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                product.Notes,
                style: TextStyle(
                  fontSize: isMobile ? 13 : 15,
                  color: Colors.grey[600],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetails(bool isMobile) {
    // بناء قائمة من تفاصيل المنتج
    final detailItems = <Widget>[
      ProductDetailItem(
        icon: Icons.inventory,
        label: 'السعر',
        value: product.Price.toString(),
        isMobile: isMobile,
      ),
      ProductDetailItem(
        icon: Icons.inventory,
        label: 'تفاصيل اضافية',
        value: product.Description.toString(),
        isMobile: isMobile,
      ),
      ProductDetailItem(
        icon: Icons.category,
        label: 'الوحدة',
        value: product.Unit,
        isMobile: isMobile,
      ),
      ProductDetailItem(
        icon: Icons.inventory,
        label: 'تاريخ الاضافة',
        value: DateFormat('dd/MM/yyyy (HH:mm)')
            .format(product.CreatedAt ?? DateTime.now())
            .toString(),
        isMobile: isMobile,
      ),
      ProductDetailItem(
        icon: Icons.inventory,
        label: 'تاريخ التعديل',
        value: DateFormat('dd/MM/yyyy (HH:mm)')
            .format(product.UpdatedAt ?? DateTime.now())
            .toString(),
        isMobile: isMobile,
      ),
    ];

    // تقسيم العناصر إلى صفوف بحيث يحتوي كل صف على عمودين
    List<Widget> rows = [];
    for (int i = 0; i < detailItems.length; i += 2) {
      rows.add(
        Row(
          children: [
            Expanded(child: detailItems[i]),
            SizedBox(width: isMobile ? 12 : 20),
            Expanded(
              child: (i + 1) < detailItems.length
                  ? detailItems[i + 1]
                  : Container(),
            ),
          ],
        ),
      );
      rows.add(SizedBox(height: isMobile ? 12 : 16));
    }
    if (rows.isNotEmpty) {
      rows.removeLast();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }

  Widget _buildActions(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // الصف الأول: Production & Ingredients
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => onClickOnTheProduction(product),
                icon: Icon(
                  Icons.production_quantity_limits,
                  size: isMobile ? 18 : 20,
                  color: Colors.white,
                ),
                label: Text(
                  'ع الانتاج',
                  style: TextStyle(fontSize: isMobile ? 14 : 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 12 : 16,
                    vertical: isMobile ? 8 : 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => onClickOnTheIngredients(product.Id),
                icon: Icon(
                  Icons.list,
                  size: isMobile ? 18 : 20,
                  color: Colors.white,
                ),
                label: Text(
                  'المكونات',
                  style: TextStyle(fontSize: isMobile ? 14 : 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 12 : 16,
                    vertical: isMobile ? 8 : 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        // الصف الثاني: Edit & Delete
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => onEdit(product),
                icon: Icon(
                  Icons.edit,
                  size: isMobile ? 18 : 20,
                  color: Colors.white,
                ),
                label: Text(
                  'تعديل',
                  style: TextStyle(fontSize: isMobile ? 14 : 16),
                ),
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
            ),
            SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => onDelete(product.Id),
                icon: Icon(
                  Icons.delete,
                  size: isMobile ? 18 : 20,
                  color: Colors.white,
                ),
                label: Text(
                  'حذف',
                  style: TextStyle(fontSize: isMobile ? 14 : 16),
                ),
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
            ),
          ],
        ),
      ],
    );
  }
}
