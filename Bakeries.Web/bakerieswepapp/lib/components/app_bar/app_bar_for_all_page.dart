import 'package:flutter/material.dart';

import '../../constants/navigation_items.dart';
import 'nav_button.dart';
import 'responsive_nav_menu.dart';

class AppBarForAllPage extends StatelessWidget implements PreferredSizeWidget {
  final String pageName;

  const AppBarForAllPage({
    Key? key,
    required this.pageName,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        pageName,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.brown,
      actions: [
        // For larger screens, show buttons
        LayoutBuilder(
          builder: (context, constraints) {
            if (MediaQuery.of(context).size.width > 768) {
              return Row(
                children: navigationItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: NavButton(
                      item: item,
                    
                      isSelected: pageName == item.title,
                    ),
                  );
                }).toList(),
              );
            } else {
              // For smaller screens, show menu button
              return ResponsiveNavMenu(
                currentPage: pageName,
                items: navigationItems,
              );
            }
          },
        ),
      ],
    );
  }
}
