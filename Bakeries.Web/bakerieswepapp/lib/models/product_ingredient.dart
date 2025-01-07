import 'Stock.dart';
import 'product.dart';

class ProductIngredient {
  final int Id;
  final int Quantity;
  final String UnitOfMeasure;
  final Stock? stock;
  final Product? product;
  final String Notes;
  final int stockId;
  final int ProductId;

  ProductIngredient({
    required this.Id,
    required this.Quantity,
    required this.UnitOfMeasure,
    required this.stock,
    required this.product,
    required this.Notes,
    required this.stockId,
    required this.ProductId,
  });

  Map<String, dynamic> toJson() {
    return {
      'Id': Id ?? 0,
      'Quantity': Quantity ?? 0,
      'UnitOfMeasure': UnitOfMeasure ?? '',
      'stock': stock,
      'product': product,
      'Notes': Notes ?? '',
      'stockId': stockId ?? 0,
      'ProductId': ProductId ?? 0,
    };
  }

  factory ProductIngredient.fromJson(Map<String, dynamic> json) {
    return ProductIngredient(
      Id: json['Id'] ?? 0,
      Quantity: json['Quantity'] ?? 0,
      UnitOfMeasure: json['UnitOfMeasure'] ?? '',
      Notes: json['Notes'] ?? '',
      stockId: json['stockId'] ?? 0,
      ProductId: json['ProductId'] ?? 0,
      stock: Stock.fromJson(json['stock']),
      product: Product.fromJson(json['product']),
    );
  }
}
