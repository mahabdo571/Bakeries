import 'ditels_prouduct.dart';
import 'package:flutter/material.dart';

import '../../../Screens/ingredients/ingredients_page.dart';
import '../../../Screens/ingredients/widgets/ingredients_card.dart';
import '../../../models/product.dart';
import '../../../models/product_ingredient.dart';
import '../../../services/ingredients_service.dart';
import 'add_update_dialog/add_update_dialog.dart';

class IngredientsList extends StatefulWidget {
  final int productId;
  final Product product;
  IngredientsList({Key? key, required this.productId, required this.product})
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
    return Column(
      children: [
        ditels_prouduct(product: widget.product),
        SizedBox(
          height: 16,
        ),
        Expanded(
          child: StreamBuilder<List<ProductIngredient>>(
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
                  onEdit: () => _handleEdit(snapshot.data![index]),
                  onDelete: () => _handleDelete(snapshot.data![index].Id),
                  onClickOnTheIngredients: _onClickOnTheIngredients,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _handleEdit(ProductIngredient productIngredient) {
    showDialog(
      context: context,
      builder: (context) => AddUpdateDialog(
        isEdit: true,
        stockData: productIngredient.toJson(),
        productId: widget.productId,
        onEdit: (productEdited) {
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
      await IngredientsService.deleteProductIngredient(id);
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
