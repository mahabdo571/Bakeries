class Stock {
  final int Id;
  final int AvailableQuantity;
  final String ItemName;
  final String Notes;
  final String Location;
  final String UnitOfMeasure;
  final int ReorderLevel;

  Stock({
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
    };
  }

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      Id: json['Id'] ?? 0,
      Notes: json['Notes'] ?? '',
      ItemName: json['ItemName']??'',
      AvailableQuantity: json['AvailableQuantity'] ?? 0,
      Location: json['Location'] ?? '',
      UnitOfMeasure: json['UnitOfMeasure'] ?? '',
      ReorderLevel: json['ReorderLevel'] ?? 0,
    );
  }
}
