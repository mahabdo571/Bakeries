class ProductionProcessDetail {
  final int Id;
  final double Quantity;
  final String ItemName;
  final String UnitOfMeasure;
  final DateTime? CreatedAt;
  final DateTime? UpdatedAt;

  ProductionProcessDetail(
      {required this.Id,
      required this.Quantity,
      required this.ItemName,
      required this.UnitOfMeasure,
      required this.CreatedAt,
      required this.UpdatedAt
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
        CreatedAt:
            DateTime.tryParse(json['CreatedAt'] ?? '1-1-1') ?? DateTime.now(),
        UpdatedAt:
            DateTime.tryParse(json['UpdatedAt'] ?? '1-1-1') ?? DateTime.now());
  }
}
