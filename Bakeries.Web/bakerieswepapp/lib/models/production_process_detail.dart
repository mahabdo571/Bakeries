class ProductionProcessDetail {
  final int Id;
  final double Quantity;
  final String ItemName;
  final String UnitOfMeasure;

  ProductionProcessDetail({
    required this.Id,
    required this.Quantity,
    required this.ItemName,
    required this.UnitOfMeasure,
  });

  Map<String, dynamic> toJson() {
    return {
      'Id': Id ?? 0,
      'ItemName': ItemName ?? '',
      'UnitOfMeasure': UnitOfMeasure ?? '',
      'Quantity': Quantity ?? 0,
    }..removeWhere((key, value) => value == null);
  }

  factory ProductionProcessDetail.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> cleanedJson = Map.from(json)
      ..removeWhere((key, value) => value == null);
    return ProductionProcessDetail(
      Id: cleanedJson['Id'] ?? 0,
      ItemName: cleanedJson['ItemName'] ?? '',
      UnitOfMeasure: cleanedJson['UnitOfMeasure'] ?? '',
      Quantity: cleanedJson['Quantity'] ?? 0,
    );
  }
}
