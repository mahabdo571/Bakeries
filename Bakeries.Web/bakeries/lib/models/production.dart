class Production {
  final String id;
  final String productId;
  final int quantity;
  final DateTime date;
  final List<String> components;

  Production({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.date,
    required this.components,
  });

  factory Production.fromJson(Map<String, dynamic> json) {
    return Production(
      id: json['id'],
      productId: json['productId'],
      quantity: json['quantity'],
      date: DateTime.parse(json['date']),
      components: List<String>.from(json['components']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'date': date.toIso8601String(),
      'components': components,
    };
  }
}

