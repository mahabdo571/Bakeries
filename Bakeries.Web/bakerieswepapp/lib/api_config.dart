class ApiConfig {
 // static const String baseUrl = 'https://rahaftec.runasp.net/api'; //devlopmint
  //static const String baseUrl =    'https://altawfiqbakery-production.runasp.net/api'; //production
  static const String baseUrl = 'http://localhost:5000/api';

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
  static const String GetProductsWithComponents =
      '$Products/GetProductsWithComponents';

  //ProductIngredient
  static const String ProductIngredient = '$baseUrl/ProductIngredient';
  static const String ProductIngredientAll = '$ProductIngredient/All';
  static const String ProductIngredientById = '$ProductIngredient/';
  static const String GetAllProductIngredientByProductId =
      '$ProductIngredient/GetAllByProductId/';

  //Production
  static const String Production = '$baseUrl/Production';
  static const String ProductionAll = '$Production/All';
  static const String ProductionById = '$Production/';
  static const String ProductionProcessWithAssociatedProduct =
      '$Production/ProductionProcessWithAssociatedProduct';

//ProductionProcessDetail
  static const String ProductionProcessDetailByPruductionId =
      '$baseUrl/ProductionProcessDetail';


      //FinishedProductInventory
  static const String FinishedProductInventory = '$baseUrl/FinishedProductInventory';
  static const String FinishedProductInventoryAll = '$FinishedProductInventory/All';
  static const String FinishedProductInventoryById = '$FinishedProductInventory/';


}
