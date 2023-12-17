
import 'package:shop/domain/domain.dart';

class ProductsRepositoryImpl extends ProductsRepository {

  final ProductsDataSource dataSource;

  ProductsRepositoryImpl({
    required this.dataSource
  });

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productMap) {
    return dataSource.createUpdateProduct(productMap);
  }

  @override
  Future<Product> getProductById(String id) {
    return dataSource.getProductById(id);
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0}) {
    return getProductsByPage(limit: limit, offset: offset);
  }

  @override
  Future<Product> searchProductByTerm(String term) {
    return dataSource.searchProductByTerm(term);
  }

}
