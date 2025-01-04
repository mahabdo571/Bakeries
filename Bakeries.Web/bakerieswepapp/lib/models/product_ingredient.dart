import 'package:bakerieswepapp/models/Stock.dart';
import 'package:bakerieswepapp/models/product.dart';

class ProductIngredient {
  final int Id;
  final int Quantity;
  final String UnitOfMeasure;
  final Stock stock;
  final Product product;
  final String Notes;

  ProductIngredient({
    required this.Id,
    required this.Quantity,
    required this.UnitOfMeasure,
    required this.stock,
    required this.product,
    required this.Notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'Id': Id ?? 0,
      'Quantity': Quantity ?? 0,
      'UnitOfMeasure': UnitOfMeasure ?? '',
      'stock': stock,
      'product': product,
      'Notes': Notes ?? '',
    };
  }

  factory ProductIngredient.fromJson(Map<String, dynamic> json) {
    return ProductIngredient(
      Id: json['Id'] ?? 0,
      Quantity: json['Quantity'] ?? 0,
      UnitOfMeasure: json['UnitOfMeasure'] ?? '',
      Notes: json['Notes'] ?? '',
      stock: Stock.fromJson(json['stock']),
      product: Product.fromJson(json['product']),
    );
  }
}
