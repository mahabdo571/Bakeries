class ApiConfig {
  static const String baseUrl = 'http://localhost:5145/api';
  //Stocks
  static const String stock = '$baseUrl/Stock';
  static const String stockAll = '$stock/All';
  static const String StockById = '$stock/';

  //Purchases
  static const String purchases = '$baseUrl/Purchases';
  static const String purchasesAll = '$purchases/All';
  static const String purchasesById = '$purchases/';

  //Product
  static const String Products = '$baseUrl/Product';
  static const String ProductAll = '$Products/All';
  static const String ProductById = '$Products/';

  //ProductIngredient
  static const String ProductIngredient = '$baseUrl/ProductIngredient';
  static const String ProductIngredientAll = '$ProductIngredient/All';
  static const String ProductIngredientById = '$ProductIngredient/';
  static const String GetAllProductIngredientByProductId =
      '$ProductIngredient/GetAllByProductId/';
}
