import 'package:bakerieswepapp/HomePage.dart';
import 'package:bakerieswepapp/Screens/PurchasesPage.dart';
import 'package:bakerieswepapp/Screens/stockScreens.dart';
import 'package:flutter/material.dart';

class AppBarForAllBage extends StatelessWidget implements PreferredSizeWidget {
  AppBarForAllBage({
    super.key,
    required this.NamePage,
  });
  String NamePage;
  Size get preferredSize =>
      Size.fromHeight(56.0); // يمكن تغيير هذا الحجم حسب الحاجة

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('المخبز -  $NamePage',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white)),
      backgroundColor: Colors.brown,
      actions: [
        ElevatedButton(
          onPressed: () {
            //  Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                // MaterialPageRoute(
                //   builder: (context) => HomePage(),
                //   maintainState: true, // يحتفظ بحالة الصفحة السابقة
                //   fullscreenDialog: false, // لا يضيف تأثير حوار كامل الشاشة),
                // ));

                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        HomePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child; // بدون تأثيرات، فقط يتم عرض الصفحة مباشرة.
                    },
                    transitionDuration: Duration.zero) // بدون مدة انتقال
                );
          },
          child: Text(
            'الرئيسية',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                NamePage == 'الرئيسية' ? Colors.brown[200] : Colors.brown[400],
          ),
        ),
        SizedBox(
          width: 5,
        ),
        ElevatedButton(
          onPressed: () {
            //Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                // MaterialPageRoute(
                //   builder: (context) => PurchasesPage(),
                //   maintainState: true, // يحتفظ بحالة الصفحة السابقة
                //   fullscreenDialog: false, // لا يضيف تأثير حوار كامل الشاشة)),
                // ));

                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        PurchasesPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child; // بدون تأثيرات، فقط يتم عرض الصفحة مباشرة.
                    },
                    transitionDuration: Duration.zero) // بدون مدة انتقال
                );
          },
          child: Text(
            'المشتريات',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                NamePage == 'المشتريات' ? Colors.brown[200] : Colors.brown[400],
          ),
        ),
        SizedBox(
          width: 5,
        ),
        ElevatedButton(
          onPressed: () {
            //   Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                // MaterialPageRoute(
                //   builder: (context) => StockScreens(),
                //   maintainState: true, // يحتفظ بحالة الصفحة السابقة
                //   fullscreenDialog: false,
                // ) // لا يضيف تأثير حوار كامل الشاشة),
                // );

                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        StockScreens(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child; // بدون تأثيرات، فقط يتم عرض الصفحة مباشرة.
                    },
                    transitionDuration: Duration.zero) // بدون مدة انتقال
                );
          },
          child: Text(
            'المخزن',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                NamePage == 'المخزن' ? Colors.brown[200] : Colors.brown[400],
          ),
        ),
        SizedBox(
          width: 5,
        ),
        ElevatedButton(
          onPressed: () {
            //   Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                // MaterialPageRoute(
                //   builder: (context) => StockScreens(),
                //   maintainState: true, // يحتفظ بحالة الصفحة السابقة
                //   fullscreenDialog: false,
                // ) // لا يضيف تأثير حوار كامل الشاشة),
                // );

                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        StockScreens(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child; // بدون تأثيرات، فقط يتم عرض الصفحة مباشرة.
                    },
                    transitionDuration: Duration.zero) // بدون مدة انتقال
                );
          },
          child: Text(
            'المنتجات',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                NamePage == 'المنتجات' ? Colors.brown[200] : Colors.brown[400],
          ),
        ),
        SizedBox(
          width: 5,
        ),
        ElevatedButton(
          onPressed: () {
            //   Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                // MaterialPageRoute(
                //   builder: (context) => StockScreens(),
                //   maintainState: true, // يحتفظ بحالة الصفحة السابقة
                //   fullscreenDialog: false,
                // ) // لا يضيف تأثير حوار كامل الشاشة),
                // );

                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        StockScreens(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child; // بدون تأثيرات، فقط يتم عرض الصفحة مباشرة.
                    },
                    transitionDuration: Duration.zero) // بدون مدة انتقال
                );
          },
          child: Text(
            'عمليات الانتاج',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: NamePage == 'عمليات الانتاج'
                ? Colors.brown[200]
                : Colors.brown[400],
          ),
        ),
        SizedBox(
          width: 5,
        ),
      ],
    );
  }
}
