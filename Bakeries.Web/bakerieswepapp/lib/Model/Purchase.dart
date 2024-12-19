class Purchase {
  final int Id;
  final String Notes;
  final int Quantity;
  final double TotalCost;
  final double TotalPrice;
  final double UnitPrice;
  final String SupplierName;
  final String SupplierInvoiceNumber;
  final String ItemName;
  final String ItemDescription;
  final String UnitOfMeasure;
  final String PaymentMethod;
  final String Status;

  Purchase(
      {required this.Id,
      required this.Notes,
      required this.Quantity,
      required this.TotalCost,
      required this.TotalPrice,
      required this.UnitPrice,
      required this.SupplierName,
      required this.SupplierInvoiceNumber,
      required this.ItemName,
      required this.ItemDescription,
      required this.UnitOfMeasure,
      required this.PaymentMethod,
      required this.Status});

  // تحويل JSON إلى كائن Purchase
  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      Id: json['Id'],
      Notes: json['Notes'],
      Quantity: json['Quantity'],
      TotalCost: json['TotalCost'].toDouble(),
      TotalPrice: json['TotalPrice'].toDouble(),
      UnitPrice: json['UnitPrice'].toDouble(),
      SupplierName: json['SupplierName'],
      SupplierInvoiceNumber: json['SupplierInvoiceNumber'],
      ItemName: json['ItemName'],
      ItemDescription: json['ItemDescription'],
      UnitOfMeasure: json['UnitOfMeasure'],
      PaymentMethod: json['PaymentMethod'],
      Status: json['Status'],
    );
  }

  // تحويل كائن Purchase إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'Notes': Notes,
      'Quantity': Quantity,
      'TotalCost': TotalCost,
      'TotalPrice': TotalPrice,
      'UnitPrice': UnitPrice,
      'SupplierName': SupplierName,
      'SupplierInvoiceNumber': SupplierInvoiceNumber,
      'ItemName': ItemName,
      'ItemDescription': ItemDescription,
      'UnitOfMeasure': UnitOfMeasure,
      'PaymentMethod': PaymentMethod,
      'Status': Status,
    };
  }
}
