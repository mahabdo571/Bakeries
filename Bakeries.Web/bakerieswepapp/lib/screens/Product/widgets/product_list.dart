import 'package:bakerieswepapp/models/product.dart';
import 'package:bakerieswepapp/screens/Product/widgets/product_card.dart';
import 'package:bakerieswepapp/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:bakerieswepapp/services/stock_service.dart';

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

  @override
  Widget build(BuildContext context) {
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

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) => ProductCard(
            product: snapshot.data![index],
            onEdit: _handleEdit,
            onDelete: _handleDelete,
          ),
        );
      },
    );
  }

  void _handleEdit(Product product) {
    // Handle edit logic
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