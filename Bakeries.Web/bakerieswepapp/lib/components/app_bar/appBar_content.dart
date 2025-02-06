import 'package:flutter/material.dart';
import '../../models/navigation_item.dart';
import 'responsive_nav_menu.dart';

class AppBarContent extends StatelessWidget {
  final String currentPage;
  final List<NavigationItem> items;

  const AppBarContent({
    Key? key,
    required this.currentPage,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 768) {
          // Mobile view
          return IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        } else {
          // Desktop view
          return ResponsiveNavMenu(
            currentPage: currentPage,
            items: items,
          );
        }
      },
    );
  }
}

