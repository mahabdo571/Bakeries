import 'product.dart';

class Production {
  final int Id;
  final String Notes;
  final String ProductName;
  final double QuantityProduced;
  final double QuantityDamaged;
  final int ProductId;

  Production({
    required this.Id,
    required this.QuantityProduced,
    required this.QuantityDamaged,
    required this.ProductId,
    required this.Notes,
    required this.ProductName,
  });

  Map<String, dynamic> toJson() {
    return {
      'Id': Id ?? 0,
      'QuantityProduced': QuantityProduced ?? 0.0,
      'QuantityDamaged': QuantityDamaged ?? 0.0,
      'ProductId': ProductId ?? 0,
      'Notes': Notes ?? '',
    }..removeWhere((key, value) => value == null);
  }

  factory Production.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> cleanedJson = Map.from(json)
      ..removeWhere((key, value) => value == null);
    return Production(
      Id: cleanedJson['Id'] ?? 0,
      Notes: cleanedJson['Notes'] ?? '',
      QuantityProduced: cleanedJson['QuantityProduced'] ?? 0.0,
      QuantityDamaged: cleanedJson['QuantityDamaged'] ?? 0.0,
      ProductId: cleanedJson['ProductId'] ?? 0,
      ProductName: cleanedJson['ProductName'] ?? '',
    );
  }
}
