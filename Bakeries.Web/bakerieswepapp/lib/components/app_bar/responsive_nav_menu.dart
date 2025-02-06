import 'package:flutter/material.dart';
import '../../models/navigation_item.dart';
import 'nav_button.dart';

class ResponsiveNavMenu extends StatelessWidget {
  final String currentPage;
  final List<NavigationItem> items;

  const ResponsiveNavMenu({
    Key? key,
    required this.currentPage,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items.map((item) {
        return NavButton(
          item: item,
          isSelected: currentPage == item.title,
        );
      }).toList(),
    );
  }
}

