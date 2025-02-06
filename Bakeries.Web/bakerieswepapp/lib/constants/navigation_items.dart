import '../screens/settings/setting_page.dart';
import '../models/navigation_item.dart';
import '../screens/Product/product_page.dart';
import '../screens/home/home_page.dart';
import '../screens/purchases/purchases_page.dart';
import '../screens/stock/stock_page.dart';

final List<NavigationItem> navigationItems = [
  NavigationItem(
    title: 'الرئيسية',
    route: const HomePage(),
  ),
  NavigationItem(
    title: 'المشتريات والفواتير',
    route: PurchasesPage(),
  ),
  NavigationItem(
    title: 'المخازن',
    subItems: [
      NavigationItem(
        title: 'إدارة المخازن',
        route: StockScreens(),
      ),
      NavigationItem(
        title: 'جرد المخازن',
        route: SettingsScreens(),
      ),
    ],
  ),
  NavigationItem(
    title: 'الانتاج',
    route: ProductScreens(),
  ),
  NavigationItem(
    title: 'المبيعات',
    route: SettingsScreens(),
  ),
  NavigationItem(
    title: 'الاعدادات',
    route: SettingsScreens(),
  ),
];

