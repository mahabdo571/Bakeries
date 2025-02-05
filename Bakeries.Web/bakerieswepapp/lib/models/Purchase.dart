class Purchase {
  final int Id;
  final String Notes;
  final double Quantity;
  final double TotalPrice;
  final double UnitPrice;
  final String SupplierName;
  final String SupplierInvoiceNumber;
  final String ItemName;
  final String ItemDescription;
  final String UnitOfMeasure;
  final String PaymentMethod;
  final String Status;
  final int ItemId;
  final DateTime? CreatedAt;
  final DateTime? UpdatedAt;

  Purchase({
    required this.Id,
    required this.Notes,
    required this.Quantity,
    required this.TotalPrice,
    required this.UnitPrice,
    required this.SupplierName,
    required this.SupplierInvoiceNumber,
    required this.ItemName,
    required this.ItemDescription,
    required this.UnitOfMeasure,
    required this.PaymentMethod,
    required this.Status,
    required this.ItemId,
    required this.CreatedAt,
    required this.UpdatedAt,
  });

  // تحويل JSON إلى كائن Purchase
  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
        Id: json['Id'] ?? 0,
        Notes: json['Notes'] ?? '',
        Quantity: json['Quantity'] ?? 0,
        // TotalCost: json['TotalCost'].toDouble(),
        TotalPrice: json['TotalPrice'] ?? 0.00,
        UnitPrice: json['UnitPrice'] ?? 0.00,
        SupplierName: json['SupplierName'] ?? '',
        SupplierInvoiceNumber: json['SupplierInvoiceNumber'] ?? '',
        ItemName: json['ItemName'] ?? '',
        ItemDescription: json['ItemDescription'] ?? '',
        UnitOfMeasure: json['UnitOfMeasure'] ?? '',
        PaymentMethod: json['PaymentMethod'] ?? '',
        Status: json['Status'] ?? '',
        ItemId: json['ItemId'] ?? 0,
        CreatedAt:
            DateTime.tryParse(json['CreatedAt'] ?? '1-1-1') ?? DateTime.now(),
        UpdatedAt:
            DateTime.tryParse(json['UpdatedAt'] ?? '1-1-1') ?? DateTime.now());
  }

  // تحويل كائن Purchase إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': Id ?? 0,
      'Notes': Notes ?? '',
      'Quantity': Quantity ?? 0,
      // 'TotalCost': TotalCost,
      'TotalPrice': TotalPrice ?? 0.00,
      'UnitPrice': UnitPrice ?? 0.00,
      'SupplierName': SupplierName ?? '',
      'SupplierInvoiceNumber': SupplierInvoiceNumber ?? '',
      'ItemName': ItemName ?? '',
      'ItemDescription': ItemDescription ?? '',
      'UnitOfMeasure': UnitOfMeasure ?? 'لتر',
      'PaymentMethod': PaymentMethod ?? '',
      'Status': Status ?? '',
      'ItemId': ItemId ?? 0,
    };
  }
}
