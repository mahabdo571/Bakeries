import 'package:flutter/material.dart';
import '/presentation/widgets/sidebar.dart';
import '/presentation/pages/dashboard_page.dart';
import '/presentation/pages/inventory_page.dart';
import '/presentation/pages/purchases_page.dart';
import '/presentation/pages/products_page.dart';
import '/presentation/pages/production_page.dart';
import '/presentation/pages/settings_page.dart';
import '/presentation/pages/users_page.dart';
import '/utils/responsive_sizes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    DashboardPage(),
    InventoryPage(),
    PurchasesPage(),
    ProductsPage(),
    ProductionPage(),
    SettingsPage(),
    UsersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: ResponsiveSizes.isMobile(context)
          ? AppBar(
              elevation: 0,
              title: Text('لوحة التحكم'),
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            )
          : PreferredSize(
              preferredSize: Size.zero,
              child: Container(),
            ),
      drawer: ResponsiveSizes.isMobile(context)
          ? Sidebar(
              onItemSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                Navigator.pop(context);
              },
            )
          : null,
      body: Row(
        children: [
          if (!ResponsiveSizes.isMobile(context))
            Sidebar(
              onItemSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}

