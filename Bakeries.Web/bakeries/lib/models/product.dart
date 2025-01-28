class Product {
  final int id;
  final String itemName;
  final double availableQuantity;
  final String unitOfMeasure;
  final int reorderLevel;
  final String location;
  final String notes;

  Product({
    required this.id,
    required this.itemName,
    required this.availableQuantity,
    required this.unitOfMeasure,
    required this.reorderLevel,
    required this.location,
    required this.notes,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['Id'],
      itemName: json['ItemName'],
      availableQuantity: json['AvailableQuantity'].toDouble(),
      unitOfMeasure: json['UnitOfMeasure'],
      reorderLevel: json['ReorderLevel'],
      location: json['Location'],
      notes: json['Notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'ItemName': itemName,
      'AvailableQuantity': availableQuantity,
      'UnitOfMeasure': unitOfMeasure,
      'ReorderLevel': reorderLevel,
      'Location': location,
      'Notes': notes,
    };
  }
}

