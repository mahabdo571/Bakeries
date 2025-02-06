import 'package:flutter/material.dart';
import '../../models/navigation_item.dart';

class NavButton extends StatelessWidget {
  final NavigationItem item;
  final bool isSelected;

  const NavButton({
    Key? key,
    required this.item,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item.hasSubItems) {
      return PopupMenuButton<NavigationItem>(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            item.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        itemBuilder: (BuildContext context) {
          return item.subItems!.map((subItem) {
            return PopupMenuItem<NavigationItem>(
              value: subItem,
              child: Text(subItem.title),
            );
          }).toList();
        },
        onSelected: (selectedItem) {
          _navigateToPage(context, selectedItem);
        },
      );
    } else {
      return ElevatedButton(
        onPressed: () => _navigateToPage(context, item),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.brown[200] : Colors.brown[400],
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          item.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
  }

  void _navigateToPage(BuildContext context, NavigationItem item) {
    if (item.route != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => item.route!),
      );
    }
  }
}

