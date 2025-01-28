import 'package:flutter/material.dart';

import '/utils/responsive_sizes.dart';

class Sidebar extends StatelessWidget {
  final Function(int) onItemSelected;

  Sidebar({required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    if (ResponsiveSizes.isDesktop(context)) {
      return _buildDesktopSidebar(context);
    } else if (ResponsiveSizes.isTablet(context)) {
      return _buildTabletSidebar(context);
    } else {
      return _buildMobileSidebar(context);
    }
  }

  Widget _buildDesktopSidebar(BuildContext context) {
    return Drawer(
 shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, 
          ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(context),
          ..._buildNavItems(context),
        ],
      ),
    );
  }

  Widget _buildTabletSidebar(BuildContext context) {
    return Container(
      width: 80,
      child: Drawer(
         shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, 
          ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildDrawerHeader(context, isCompact: true),
            ..._buildNavItems(context, isCompact: true),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileSidebar(BuildContext context) {
    return Drawer(
       shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, 
          ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(context),
          ..._buildNavItems(context),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context, {bool isCompact = false}) {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: isCompact
          ? Icon(
              Icons.dashboard,
              color: Colors.white,
              size: 32,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'لوحة التحكم',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
    );
  }

  List<Widget> _buildNavItems(BuildContext context, {bool isCompact = false}) {
    final navItems = [
      {'title': 'الرئيسية', 'icon': Icons.dashboard, 'index': 0},
      {'title': 'المخزن', 'icon': Icons.inventory, 'index': 1},
      {'title': 'المشتريات', 'icon': Icons.shopping_cart, 'index': 2},
      {'title': 'المنتجات', 'icon': Icons.category, 'index': 3},
      {'title': 'عمليات الإنتاج', 'icon': Icons.build, 'index': 4},
      {'title': 'الإعدادات', 'icon': Icons.settings, 'index': 5},
      {'title': 'المستخدمين', 'icon': Icons.people, 'index': 6},
    ];

    return navItems.map((item) {
      Widget listTile = ListTile(
        leading: Icon(item['icon'] as IconData),
        title: isCompact ? null : Text(item['title'] as String),
        onTap: () => onItemSelected(item['index'] as int),
      );

      if (isCompact) {
        return Tooltip(
          message: item['title'] as String,
          child: listTile,
        );
      } else {
        return listTile;
      }
    }).toList();
  }
}
