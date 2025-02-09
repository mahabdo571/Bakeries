// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import '../../../models/Purchase.dart';
// import 'purchase_detail_item.dart';

// class PurchaseCard extends StatelessWidget {
//   final Purchase purchase;
//   final VoidCallback onEdit;
//   final VoidCallback onDelete;

//   const PurchaseCard({
//     Key? key,
//     required this.purchase,
//     required this.onEdit,
//     required this.onDelete,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 5,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildHeader(),
//             const Divider(height: 24),
//             _buildDetails(),
//             const Divider(height: 24),
//             _buildActions(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Row(
//       children: [
//         const Icon(Icons.shopping_cart, color: Colors.brown, size: 24),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 purchase.ItemName,
//                 style:
//                     const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 purchase.ItemDescription,
//                 style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDetails() {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             PurchaseDetailItem(
//               icon: Icons.inventory,
//               label: 'الكمية',
//               value: purchase.Quantity.toString(),
//             ),
//             PurchaseDetailItem(
//               icon: Icons.monetization_on,
//               label: 'سعر الوحدة',
//               value: purchase.UnitPrice.toString(),
//             ),
//             PurchaseDetailItem(
//               icon: Icons.calculate,
//               label: 'السعر الكلي',
//               value: purchase.TotalPrice.toString(),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             PurchaseDetailItem(
//               icon: Icons.person,
//               label: 'المورد',
//               value: purchase.SupplierName,
//             ),
//             PurchaseDetailItem(
//               icon: Icons.person,
//               label: 'اخر تحديث',
//               value: DateFormat('dd/MM/yyyy (HH:mm)')
//                   .format(purchase.UpdatedAt ?? DateTime.now())
//                   .toString(),
//             ),
//             PurchaseDetailItem(
//               icon: Icons.receipt,
//               label: 'تاريخ الاضافة',
//               value: DateFormat('dd/MM/yyyy (HH:mm)')
//                   .format(purchase.CreatedAt ?? DateTime.now())
//                   .toString(),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildActions() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         ElevatedButton.icon(
//           onPressed: onEdit,
//           icon: const Icon(Icons.edit, color: Colors.white),
//           label: const Text('تعديل'),
//           style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//         ),
//         const SizedBox(width: 8),
//         ElevatedButton.icon(
//           onPressed: onDelete,
//           icon: const Icon(Icons.delete, color: Colors.white),
//           label: const Text('حذف'),
//           style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/Purchase.dart';
import 'purchase_detail_item.dart';

class PurchaseCard extends StatelessWidget {
  final Purchase purchase;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PurchaseCard({
    Key? key,
    required this.purchase,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // تحديد حالة الموبايل بناءً على عرض الشاشة العام
    final isMobile = MediaQuery.of(context).size.width < 630;

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
      children: [
        Icon(
          Icons.shopping_cart,
          color: Colors.brown,
          size: isMobile ? 22 : 26,
        ),
        SizedBox(width: isMobile ? 10 : 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                purchase.ItemName,
                style: TextStyle(
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                purchase.ItemDescription,
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
    // بناء قائمة من تفاصيل الشراء
    final detailItems = <Widget>[
      PurchaseDetailItem(
        icon: Icons.inventory,
        label: 'الكمية',
        value: purchase.Quantity.toString(),
        isMobile: isMobile,
      ),
      PurchaseDetailItem(
        icon: Icons.monetization_on,
        label: 'سعر الوحدة',
        value: purchase.UnitPrice.toString(),
        isMobile: isMobile,
      ),
      PurchaseDetailItem(
        icon: Icons.calculate,
        label: 'السعر الكلي',
        value: purchase.TotalPrice.toString(),
        isMobile: isMobile,
      ),
      PurchaseDetailItem(
        icon: Icons.person,
        label: 'المورد',
        value: purchase.SupplierName,
        isMobile: isMobile,
      ),
      PurchaseDetailItem(
        icon: Icons.person,
        label: 'اخر تحديث',
        value: DateFormat('dd/MM/yyyy (HH:mm)')
            .format(purchase.UpdatedAt ?? DateTime.now())
            .toString(),
        isMobile: isMobile,
      ),
      PurchaseDetailItem(
        icon: Icons.receipt,
        label: 'تاريخ الاضافة',
        value: DateFormat('dd/MM/yyyy (HH:mm)')
            .format(purchase.CreatedAt ?? DateTime.now())
            .toString(),
        isMobile: isMobile,
      ),
    ];

    // تقسيم العناصر إلى صفوف كل صف يحتوي على عمودين
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

    // إزالة الفاصل الأخير
    if (rows.isNotEmpty) {
      rows.removeLast();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }

  Widget _buildActions(bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          onPressed: onEdit,
          icon: Icon(Icons.edit, size: isMobile ? 18 : 20),
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
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: onDelete,
          icon: Icon(Icons.delete, size: isMobile ? 18 : 20),
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
      ],
    );
  }
}
