
import 'package:dio/dio.dart';
import 'package:shop/config/config.dart';
import 'package:shop/domain/domain.dart';
import 'package:shop/infraestructure/infraestructure.dart';

class ProductsDataSourceImpl extends ProductsDataSource {

  late final Dio dio;
  final String accessToken;

  ProductsDataSourceImpl({
    required this.accessToken
  }) : dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      headers: {
        'Authorization': 'Bearer $accessToken'
      }
    )
  );

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productMap) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById(String id) async {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0}) async {
    try {

      final response = await dio.get('/products', queryParameters: {
        'limit': limit,
        'offset': offset
      });

      final List<Product> products = [];
      for (final product in response.data ?? []) {
        products.add(ProductMapper.productJsonToEntity(product));
      }

      return products;

    } catch (err) {
      return [];
    }
  }

  @override
  Future<Product> searchProductByTerm(String term) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }

}
