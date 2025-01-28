class Purchase {
  final int id;
  final String itemName;
  final String itemDescription;
  final String notes;
  final String supplierName;
  final int itemId;
  final String supplierInvoiceNumber;
  final int quantity;
  final String unitOfMeasure;
  final double unitPrice;
  final double totalPrice;
  final String paymentMethod;
  final String status;

  Purchase({
    required this.id,
    required this.itemName,
    required this.itemDescription,
    required this.notes,
    required this.supplierName,
    required this.itemId,
    required this.supplierInvoiceNumber,
    required this.quantity,
    required this.unitOfMeasure,
    required this.unitPrice,
    required this.totalPrice,
    required this.paymentMethod,
    required this.status,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['Id'],
      itemName: json['ItemName'],
      itemDescription: json['ItemDescription'],
      notes: json['Notes'],
      supplierName: json['SupplierName'],
      itemId: json['ItemId'],
      supplierInvoiceNumber: json['SupplierInvoiceNumber'],
      quantity: json['Quantity'],
      unitOfMeasure: json['UnitOfMeasure'],
      unitPrice: json['UnitPrice'].toDouble(),
      totalPrice: json['TotalPrice'].toDouble(),
      paymentMethod: json['PaymentMethod'],
      status: json['Status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'ItemName': itemName,
      'ItemDescription': itemDescription,
      'Notes': notes,
      'SupplierName': supplierName,
      'ItemId': itemId,
      'SupplierInvoiceNumber': supplierInvoiceNumber,
      'Quantity': quantity,
      'UnitOfMeasure': unitOfMeasure,
      'UnitPrice': unitPrice,
      'TotalPrice': totalPrice,
      'PaymentMethod': paymentMethod,
      'Status': status,
    };
  }
}
