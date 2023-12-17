

import 'package:shop/domain/domain.dart';

abstract class ProductsRepository {

  Future<List<Product>> getProductsByPage({ int limit = 10, int offset = 0 });
  Future<Product> getProductById(String id);
  Future<Product> searchProductByTerm(String term);
  Future<Product> createUpdateProduct(Map<String, dynamic> productMap);

}
