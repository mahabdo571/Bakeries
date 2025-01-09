import 'package:flutter/material.dart';

import '../../../Screens/ingredients/ingredients_page.dart';
import '../../../Screens/ingredients/widgets/ingredients_card.dart';
import '../../../models/product.dart';
import '../../../models/product_ingredient.dart';
import '../../../services/ingredients_service.dart';

class ProductionList extends StatefulWidget {
  final int productId;
  final Product product;
  ProductionList({Key? key, required this.productId, required this.product})
      : super(key: key);

  @override
  _ProductionListState createState() => _ProductionListState();
}

class _ProductionListState extends State<ProductionList> {
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
        Card(
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 16, // المسافة الأفقية بين العناصر
              runSpacing: 16, // المسافة الرأسية بين الصفوف
              alignment: WrapAlignment.center, // محاذاة العناصر في الوسط
              children: [
                _buildDetailItem(
                    Icons.info, 'اسم المنتج \n ${widget.product.Name}'),
                _buildDetailItem(
                    Icons.note, 'ملاحظات  \n ${widget.product.Notes}'),
                _buildDetailItem(Icons.price_check_rounded,
                    'السعر   \n ${widget.product.Price}'),
                _buildDetailItem(Icons.upcoming_outlined,
                    'الوحدة  \n ${widget.product.Unit}'),
                _buildDetailItem(Icons.description,
                    ' تفاصيل \n ${widget.product.Description}'),
              ],
            ),
          ),
        ),
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
      builder: (context) => Text('ToDo'),
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

Widget _buildDetailItem(IconData icon, String text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(icon, color: Colors.blue, size: 32),
      const SizedBox(height: 8),
      Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14),
      ),
    ],
  );
}
