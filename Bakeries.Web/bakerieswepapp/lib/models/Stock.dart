class Stock {
  final int Id;
  final double AvailableQuantity;
  final String ItemName;
  final String Notes;
  final String Location;
  final String UnitOfMeasure;
  final int ReorderLevel;
  final DateTime CreatedAt;
  final DateTime UpdatedAt;

  Stock({
    required this.CreatedAt,
    required this.UpdatedAt,
    required this.Id,
    required this.AvailableQuantity,
    required this.ItemName,
    required this.Notes,
    required this.Location,
    required this.UnitOfMeasure,
    required this.ReorderLevel,
  });

  Map<String, dynamic> toJson() {
 
    return {
      'Id': Id ?? 0,
      'ItemName': ItemName ?? '',
      'Notes': Notes ?? '',
      'AvailableQuantity': AvailableQuantity ?? 0,
      'Location': Location ?? '',
      'UnitOfMeasure': UnitOfMeasure ?? '',
      'ReorderLevel': ReorderLevel ?? 0,
      'CreatedAt': CreatedAt.toIso8601String(),
      'UpdatedAt':  UpdatedAt.toIso8601String()
    }..removeWhere((key, value) => value == null);
  }

  factory Stock.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> cleanedJson = Map.from(json)
      ..removeWhere((key, value) => value == null);
    return Stock(
      Id: cleanedJson['Id'] ?? 0,
      Notes: cleanedJson['Notes'] ?? '',
      ItemName: cleanedJson['ItemName'] ?? '',
      AvailableQuantity: cleanedJson['AvailableQuantity'] ?? 0,
      Location: cleanedJson['Location'] ?? '',
      UnitOfMeasure: cleanedJson['UnitOfMeasure'] ?? '',
      ReorderLevel: cleanedJson['ReorderLevel'] ?? 0,
      CreatedAt: DateTime.tryParse(cleanedJson['CreatedAt'])??DateTime.now(),
      UpdatedAt: DateTime.tryParse(cleanedJson['UpdatedAt'])??DateTime.now()
    );
  }
}
