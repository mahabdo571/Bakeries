// import 'package:flutter/material.dart';

// import '../../../Screens/ingredients/ingredients_page.dart';
// import '../../../Screens/product/widgets/product_dialog/product_dialog.dart';
// import '../../../models/product.dart';
// import '../../../services/product_service.dart';
// import '../../production/production_page.dart';
// import 'product_card.dart';

// class ProductList extends StatefulWidget {
//   const ProductList({Key? key}) : super(key: key);

//   @override
//   _ProductListState createState() => _ProductListState();
// }

// class _ProductListState extends State<ProductList> {
//   late Stream<List<Product>> stockStream;

//   @override
//   void initState() {
//     super.initState();
//     stockStream = ProductService.getStockStream();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<Product>>(
//       stream: stockStream,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (snapshot.hasError) {
//           return Center(child: Text('حدث خطأ: ${snapshot.error}'));
//         }

//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text('لا توجد بيانات لعرضها'));
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: snapshot.data!.length,
//           itemBuilder: (context, index) => ProductCard(
//             product: snapshot.data![index],
//             onEdit: _handleEdit,
//             onDelete: _handleDelete,
//             onClickOnTheIngredients: _onClickOnTheIngredients,
//             onClickOnTheProduction: _onClickOnTheProduction,
//           ),
//         );
//       },
//     );
//   }

//   void _handleEdit(Product product) {
//     showDialog(
//       context: context,
//       builder: (context) => ProductDialog(
//         isEdit: true,
//         productData: product.toJson(),
//         onAdd: (newProduct) {
//           // Handle add callback
//         },
//       ),
//     );
//   }

//   void _onClickOnTheIngredients(int productId) {
//     Navigator.push(
//       context,
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) =>
//             IngredientsScreens(productId: productId),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           return child;
//         },
//         transitionDuration: Duration.zero,
//       ),
//     );
//   }

//   void _onClickOnTheProduction(Product product) {
//     Navigator.push(
//       context,
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) =>
//             ProductionScreen(product: product),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           return child;
//         },
//         transitionDuration: Duration.zero,
//       ),
//     );
//   }

//   Future<void> _handleDelete(int id) async {
//     try {
//       await ProductService.deleteProduct(id);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('تم حذف العنصر بنجاح')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('فشل في حذف العنصر: $e')),
//       );
//     }
//   }
// }



import 'package:flutter/material.dart';

import '../../../Screens/ingredients/ingredients_page.dart';
import '../../../Screens/product/widgets/product_dialog/product_dialog.dart';
import '../../../models/product.dart';
import '../../../services/product_service.dart';
import '../../production/production_page.dart';
import 'product_card.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Stream<List<Product>> stockStream;

  @override
  void initState() {
    super.initState();
    stockStream = ProductService.getStockStream();
  }

  /// تحديد عدد الأعمدة بناءً على عرض الشاشة:
  /// - >= 1024: 4 أعمدة (سطح مكتب)
  /// - >= 600: عمودان (جهاز لوحي)
  /// - أقل من 600: عمود واحد (موبايل)
  int _calculateCrossAxisCount(double width) {
    if (width >= 1240) {
      return 4;
    } else if (width >= 630) {
      return 2;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = _calculateCrossAxisCount(screenWidth);

    // إعداد الثوابت للمسافات والارتفاع الثابت لكل كرت
    const double padding = 16.0;
    const double spacing = 16.0;
    const double desiredCardHeight = 470.0;

    return StreamBuilder<List<Product>>(
      stream: stockStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('حدث خطأ: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('لا توجد بيانات لعرضها'));
        }

        return Padding(
          padding: const EdgeInsets.all(padding),
          child: GridView.builder(
            itemCount: snapshot.data!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              // استخدام mainAxisExtent لتحديد ارتفاع ثابت لكل كرت
              mainAxisExtent: desiredCardHeight,
            ),
            itemBuilder: (context, index) => ProductCard(
              product: snapshot.data![index],
              onEdit: _handleEdit,
              onDelete: _handleDelete,
              onClickOnTheIngredients: _onClickOnTheIngredients,
              onClickOnTheProduction: _onClickOnTheProduction,
            ),
          ),
        );
      },
    );
  }

  void _handleEdit(Product product) {
    showDialog(
      context: context,
      builder: (context) => ProductDialog(
        isEdit: true,
        productData: product.toJson(),
        onAdd: (newProduct) {
          // Handle add callback
        },
      ),
    );
  }

  void _onClickOnTheIngredients(int productId) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            IngredientsScreens(productId: productId),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
        transitionDuration: Duration.zero,
      ),
    );
  }

  void _onClickOnTheProduction(Product product) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ProductionScreen(product: product),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
        transitionDuration: Duration.zero,
      ),
    );
  }

  Future<void> _handleDelete(int id) async {
    try {
      await ProductService.deleteProduct(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حذف العنصر بنجاح')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل في حذف العنصر: $e')),
      );
    }
  }
}
