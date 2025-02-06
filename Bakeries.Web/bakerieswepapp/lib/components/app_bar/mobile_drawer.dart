import 'package:flutter/material.dart';
import '../../models/navigation_item.dart';

class MobileDrawer extends StatelessWidget {
  final List<NavigationItem> items;
  final String currentPage;

  const MobileDrawer({
    Key? key,
    required this.items,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.brown,
            ),
            child: Text(
              'القائمة',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ...items.map((item) => _buildDrawerItem(context, item)).toList(),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, NavigationItem item) {
    if (item.hasSubItems) {
      return ExpansionTile(
        title: Text(item.title),
        children: item.subItems!
            .map((subItem) => _buildDrawerItem(context, subItem))
            .toList(),
      );
    } else {
      return ListTile(
        title: Text(item.title),
        selected: currentPage == item.title,
        onTap: () {
          Navigator.pop(context); // Close the drawer
          if (item.route != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => item.route!),
            );
          }
        },
      );
    }
  }
}
