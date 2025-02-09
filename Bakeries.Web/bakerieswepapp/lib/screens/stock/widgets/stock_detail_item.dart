import 'package:flutter/material.dart';

class StockDetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
final bool isHorizontal;
final bool isMobile;
  const StockDetailItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.isHorizontal,
    required this.isMobile
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.brown, size: 18),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
