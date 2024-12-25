import 'package:flutter/material.dart';
import 'package:bakerieswepapp/models/navigation_item.dart';

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
    return PopupMenuButton<NavigationItem>(
      icon: const Icon(Icons.menu, color: Colors.white),
      itemBuilder: (BuildContext context) {
        return items.map((NavigationItem item) {
          return PopupMenuItem<NavigationItem>(
            value: item,
            child: Row(
              children: [
                if (currentPage == item.title)
                  const Icon(Icons.check, size: 18, color: Colors.brown)
                else
                  const SizedBox(width: 18),
                const SizedBox(width: 8),
                Text(item.title),
              ],
            ),
          );
        }).toList();
      },
      onSelected: (NavigationItem item) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => item.route,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return child;
            },
            transitionDuration: Duration.zero,
          ),
        );
      },
    );
  }
}