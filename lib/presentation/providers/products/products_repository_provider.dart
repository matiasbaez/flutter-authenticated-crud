
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shop/domain/domain.dart';
import 'package:shop/infraestructure/infraestructure.dart';
import 'package:shop/presentation/providers/providers.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {

  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final productsRepository = ProductsRepositoryImpl(
    dataSource: ProductsDataSourceImpl(accessToken: accessToken)
  );

  return productsRepository;
});
