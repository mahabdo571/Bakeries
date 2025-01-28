import '/data/datasources/inventory_data_source.dart';
import '/domain/repositories/i_inventory_repository.dart';
import '/models/product.dart';

class InventoryRepositoryImpl implements IInventoryRepository {
  final InventoryDataSource dataSource;

  InventoryRepositoryImpl({required this.dataSource});

  @override
  Future<List<Product>> getProducts() async {
    return await dataSource.getProducts();
  }

  @override
  Future<void> addProduct(Product product) async {
    await dataSource.addProduct(product);
  }

  @override
  Future<void> updateProduct(Product product) async {
    await dataSource.updateProduct(product);
  }

  @override
  Future<void> deleteProduct(int productId) async {
    await dataSource.deleteProduct(productId);
  }
}
