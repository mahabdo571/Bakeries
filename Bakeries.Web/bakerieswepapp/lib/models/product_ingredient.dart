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
    }..removeWhere((key, value) => value == null);
  }

  factory ProductIngredient.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> cleanedJson = Map.from(json)
      ..removeWhere((key, value) => value == null);
    print('jjjgtg $cleanedJson');
    return ProductIngredient(
      Id: cleanedJson['Id'] ?? 0,
      Quantity: cleanedJson['Quantity'] ?? 0,
      UnitOfMeasure: cleanedJson['UnitOfMeasure'] ?? '',
      Notes: cleanedJson['Notes'] ?? '',
      stockId: cleanedJson['stockId'] ?? 0,
      ProductId: cleanedJson['ProductId'] ?? 0,
      stock: Stock.fromJson(cleanedJson['stock']),
      product: Product.fromJson(cleanedJson['product']),
    );
  }
}
