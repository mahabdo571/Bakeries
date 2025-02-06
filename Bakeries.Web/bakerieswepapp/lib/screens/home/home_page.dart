import 'package:flutter/material.dart';

import '../../constants/navigation_items.dart';
import '../../models/navigation_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _currentRoute = Center(child: Text('الرئيسية'));

  void _navigateTo(Widget route, bool isMobile) {
    setState(() => _currentRoute = route);
    if (isMobile) Navigator.of(context).pop();
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
            ),
            child: Text(
              'مخبز التوفيق',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ...navigationItems.map((item) => _buildMobileNavItem(item)),
        ],
      ),
    );
  }

  Widget _buildMobileNavItem(NavigationItem item) {
    return item.hasSubItems
        ? ExpansionTile(
            leading: Icon(item.icon),
            title: Text(item.title),
            children: item.subItems!
                .map((subItem) => _buildMobileSubItem(subItem, true))
                .toList(),
          )
        : ListTile(
            leading: Icon(item.icon),
            title: Text(item.title),
            onTap: () =>
                item.route != null ? _navigateTo(item.route!, true) : null,
          );
  }

  ListTile _buildMobileSubItem(NavigationItem subItem, bool isMobile) {
    return ListTile(
      leading: Icon(subItem.icon),
      title: Text(subItem.title),
      onTap: () => _navigateTo(subItem.route!, isMobile),
    );
  }

  List<Widget> _buildDesktopNavItems() {
    return navigationItems.map((item) {
      if (item.hasSubItems) {
        return MenuAnchor(
          menuChildren: item.subItems!.map((subItem) {
            return MenuItemButton(
              child: Row(
                children: [
                  Icon(subItem.icon, size: 20),
                  SizedBox(width: 8),
                  Text(subItem.title),
                ],
              ),
              onPressed: () => _navigateTo(subItem.route!, false),
            );
          }).toList(),
          builder: (context, controller, child) {
            return TextButton(
              onPressed: () => controller.open(),
              child: Row(
                children: [
                  Icon(item.icon),
                  SizedBox(width: 8),
                  Text(item.title),
                ],
              ),
            );
          },
        );
      }
      return TextButton(
        child: Row(
          children: [
            Icon(item.icon),
            SizedBox(width: 8),
            Text(item.title),
          ],
        ),
        onPressed: () => _navigateTo(item.route!, false),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 600;

        return Scaffold(
          appBar: AppBar(
            title: isMobile
                ? Text('مخبز التوفيق')
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: _buildDesktopNavItems()),
                  ),
          ),
          drawer: isMobile ? _buildMobileDrawer() : null,
          body: _currentRoute,
        );
      },
    );
  }
}
