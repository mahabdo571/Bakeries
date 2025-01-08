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
      'Notes': Notes ?? '',
      'stockId': stockId ?? 0,
      'ProductId': ProductId ?? 0,
    }..removeWhere((key, value) => value == null);
  }

  factory ProductIngredient.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> cleanedJson = Map.from(json)
      ..removeWhere((key, value) => value == null);
    return ProductIngredient(
      Id: cleanedJson['Id'] ?? 0,
      Quantity: cleanedJson['Quantity'] ?? 0,
      UnitOfMeasure: cleanedJson['UnitOfMeasure'] ?? '',
      Notes: cleanedJson['Notes'] ?? '',
      stockId: cleanedJson['stock']?['Id'] ?? 0,
      ProductId: cleanedJson['product']?['Id'] ?? 0,
      stock: cleanedJson.containsKey('stock')
          ? Stock.fromJson(cleanedJson['stock'])
          : null,
      product: cleanedJson.containsKey('product')
          ? Product.fromJson(cleanedJson['product'])
          : null,
    );
  }
}
