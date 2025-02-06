import '../../../models/product.dart';
import 'package:flutter/material.dart';

class ditels_prouduct extends StatelessWidget {
  const ditels_prouduct({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 16, // المسافة الأفقية بين العناصر
          runSpacing: 16, // المسافة الرأسية بين الصفوف
          alignment: WrapAlignment.center, // محاذاة العناصر في الوسط
          children: [
            _buildDetailItem(
                Icons.info, 'اسم المنتج \n ${product.Name}'),
            _buildDetailItem(
                Icons.note, 'ملاحظات  \n ${product.Notes}'),
            _buildDetailItem(Icons.price_check_rounded,
                'السعر   \n ${product.Price}'),
            _buildDetailItem(Icons.upcoming_outlined,
                'الوحدة  \n ${product.Unit}'),
            _buildDetailItem(Icons.description,
                ' تفاصيل \n ${product.Description}'),
          ],
        ),
      ),
    );
  }
}

Widget _buildDetailItem(IconData icon, String text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(icon, color: Colors.blue, size: 32),
      const SizedBox(height: 8),
      Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14),
      ),
    ],
  );
}
