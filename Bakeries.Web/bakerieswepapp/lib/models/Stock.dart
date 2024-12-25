class Stock {
  final int Id;
  final int QuantityInStock;
  final String ItemName;
  final String Notes;
  final String Location;
  final String UnitOfMeasure;
  final int ReorderLevel;

  Stock({
    required this.Id,
    required this.QuantityInStock,
    required this.ItemName,
    required this.Notes,
    required this.Location,
    required this.UnitOfMeasure,
    required this.ReorderLevel,
  });

  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'ItemName': ItemName,
      'Notes': Notes,
      'QuantityInStock': QuantityInStock,
      'Location': Location,
      'UnitOfMeasure': UnitOfMeasure,
      'ReorderLevel': ReorderLevel,
    };
  }

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      Id: json['Id'],
      Notes: json['Notes'],
      ItemName: json['ItemName'],
      QuantityInStock: json['QuantityInStock'],
      Location: json['Location'],
      UnitOfMeasure: json['UnitOfMeasure'],
      ReorderLevel: json['ReorderLevel'],
    );
  }
}
