class FinishedProductInventory {
  final int Id;
  final double CostPrice;
  final double UnitPriceForPeople;
  final double UniPtriceForDealers;
  final double UnitPriceForResellers;
  final double Discount;
  final double Tax;
  final int AvailableQuantity;
  final int ReorderLevel;
  final String Code;
  final String ItemName;
  final String Location;
  final String Unit;
  final String Notes;
  final DateTime? CreatedAt;
  final DateTime? UpdatedAt;

  FinishedProductInventory(
      {required this.Id,
      required this.CostPrice,
      required this.UnitPriceForPeople,
      required this.UniPtriceForDealers,
      required this.UnitPriceForResellers,
      required this.Discount,
     required this.Tax,
     required this.AvailableQuantity,
     required this.ReorderLevel,
     required this.Code,
    required  this.ItemName,
    required  this.Location,
    required  this.Unit,
    required  this.Notes,
      this.CreatedAt,
      this.UpdatedAt,});

  Map<String, dynamic> toJson() {
    return {
      'Id': Id ?? 0,
      'CostPrice': CostPrice ?? 0.00,
      'UnitPriceForPeople': UnitPriceForPeople ?? 0.00,
      'UniPtriceForDealers': UniPtriceForDealers ?? 0.00,
      'UnitPriceForResellers': UnitPriceForResellers ?? 0.00,
      'Discount': Discount ?? 0.00,
      'Tax': Tax ?? 0.00,
      'AvailableQuantity': AvailableQuantity ?? 0,
      'ReorderLevel': ReorderLevel ?? 0,
      'Code': Code ?? '',
      'ItemName': ItemName ?? '',
      'Location': Location ?? '',
      'Unit': Unit ?? '',
      'Notes': Notes ?? '',
     
    };
  }

  factory FinishedProductInventory.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> cleanedJson = Map.from(json)
      ..removeWhere((key, value) => value == null);
    return FinishedProductInventory(
        Id: cleanedJson['Id'] ?? 0,
        CostPrice: cleanedJson['CostPrice'] ?? 0.0,
        UnitPriceForPeople: cleanedJson['UnitPriceForPeople'] ?? 0.0,
        UniPtriceForDealers: cleanedJson['UniPtriceForDealers'] ?? 0.0,
        UnitPriceForResellers: cleanedJson['UnitPriceForResellers'] ?? 0.0,
        Discount: cleanedJson['Discount'] ?? 0.0,
        Tax: cleanedJson['Tax'] ?? 0.0,
        AvailableQuantity: cleanedJson['AvailableQuantity'] ?? 0,
        ReorderLevel: cleanedJson['ReorderLevel'] ?? 0,
        Code: cleanedJson['Code'] ?? '',
        ItemName: cleanedJson['ItemName'] ?? '',
        Location: cleanedJson['Location'] ?? '',
        Unit: cleanedJson['Unit'] ?? '',
        Notes: cleanedJson['Notes'] ?? '',
    
        CreatedAt:
            DateTime.tryParse(json['CreatedAt'] ?? '1-1-1') ?? DateTime.now(),
        UpdatedAt:
            DateTime.tryParse(json['UpdatedAt'] ?? '1-1-1') ?? DateTime.now());
  }
}
