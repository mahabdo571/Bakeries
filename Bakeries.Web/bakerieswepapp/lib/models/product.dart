class Product {
  final int Id;
  final double Price;
  final String Name;
  final String Description;
  final String Unit;
  final String Notes;

  Product({
    required this.Id,
    required this.Price,
    required this.Name,
    required this.Description,
    required this.Unit,
    required this.Notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'Id': Id ?? 0,
      'Name': Name ?? '',
      'Description': Description ?? '',
      'Price': Price ?? 0.00,
      'Unit': Unit ?? '',
      'Notes': Notes ?? '',
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> cleanedJson = Map.from(json)
      ..removeWhere((key, value) => value == null);
    return Product(
      Id: cleanedJson['Id'] ?? 0,
      Description: cleanedJson['Description'] ?? '',
      Name: cleanedJson['Name'] ?? '',
      Price: cleanedJson['Price'] ?? 0.00,
      Unit: cleanedJson['Unit'] ?? '',
      Notes: cleanedJson['Notes'] ?? '',
    );
  }
}
