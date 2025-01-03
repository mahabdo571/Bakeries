import 'package:bakerieswepapp/Screens/ingredients/ingredients_page.dart';
import 'package:bakerieswepapp/Screens/ingredients/widgets/ingredients_card.dart';
import 'package:bakerieswepapp/Screens/product/widgets/product_dialog/product_dialog.dart';
import 'package:bakerieswepapp/models/product.dart';
import 'package:bakerieswepapp/models/product_ingredient.dart';
import 'package:bakerieswepapp/services/ingredients_service.dart';
import 'package:bakerieswepapp/services/product_service.dart';
import 'package:flutter/material.dart';

class IngredientsList extends StatefulWidget {
  final int productId;
  IngredientsList({Key? key, required this.productId, })
      : super(key: key);

  @override
  _IngredientsListState createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
  late Stream<List<ProductIngredient>> stockStream;
  @override
  void initState() {
    super.initState();
    stockStream =
        IngredientsService.getProductIngredientStream(widget.productId);
  }



     
     
  @override
  Widget build(BuildContext context) {
    
  
    return StreamBuilder<List<ProductIngredient>>(
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
       
        
       
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) => IngredientsCard(
            productIngredient: snapshot.data![index],
            onEdit: _handleEdit,
            onDelete: _handleDelete,
            onClickOnTheIngredients: _onClickOnTheIngredients,
          ),
        );
      },
    );
  }

  void _handleEdit(ProductIngredient product) {
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
