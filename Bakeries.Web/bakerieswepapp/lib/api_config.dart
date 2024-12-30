class ApiConfig {
  static const String baseUrl = 'http://localhost:5145/api';
  //Stocks
  static const String stock = '$baseUrl/Stock';
  static const String stockAll = '$baseUrl/Stock/All';
  static const String StockById = '$stock/';

  //Purchases
  static const String purchases = '$baseUrl/Purchases';
  static const String purchasesAll = '$baseUrl/Purchases/All';
  static const String purchasesById = '$purchases/';

  //Product
  static const String Products = '$baseUrl/Product';
  static const String ProductAll = '$baseUrl/Product/All';
  static const String ProductById = '$Products/';
}
