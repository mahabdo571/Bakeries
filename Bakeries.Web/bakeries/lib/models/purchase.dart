class Purchase {
  final String id;
  final String productId;
  final int quantity;
  final double totalPrice;
  final DateTime date;

  Purchase({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.totalPrice,
    required this.date,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['id'],
      productId: json['productId'],
      quantity: json['quantity'],
      totalPrice: json['totalPrice'].toDouble(),
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'date': date.toIso8601String(),
    };
  }
}

