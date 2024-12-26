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
      'Id': Id,
      'ItemName': ItemName,
      'Notes': Notes,
      'AvailableQuantity': AvailableQuantity,
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
      AvailableQuantity: json['AvailableQuantity'],
      Location: json['Location'],
      UnitOfMeasure: json['UnitOfMeasure'],
      ReorderLevel: json['ReorderLevel'],
    );
  }
}
