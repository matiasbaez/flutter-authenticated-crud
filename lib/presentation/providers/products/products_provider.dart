

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shop/domain/domain.dart';
import 'package:shop/presentation/providers/providers.dart';

final productsProvider = StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {

  final productsRepository = ref.watch(productsRepositoryProvider);

  return ProductsNotifier(
    productsRepository: productsRepository
  );
});


class ProductsNotifier extends StateNotifier<ProductsState> {

  final ProductsRepository productsRepository;

  ProductsNotifier({
    required this.productsRepository
  }) : super( ProductsState() ) {
    loadNextPage();
  }

  Future loadNextPage() async {

    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith( isLoading: true );

    final products = await productsRepository.getProductsByPage(limit: state.limit, offset: state.offset);

    if (products.isEmpty) {
      return state = state.copyWith(
        isLastPage: true,
        isLoading: false
      );
    }

    return state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      products: [ ...state.products, ...products ],
      offset: state.offset + 10,
    );

  }

}

class ProductsState {

  final bool isLastPage;
  final int offset;
  final int limit;
  final bool isLoading;
  final List<Product> products;

  ProductsState({
    this.isLastPage = false,
    this.offset = 0,
    this.limit = 10,
    this.isLoading = false,
    this.products = const []
  });

  copyWith({
    bool? isLastPage,
    int? offset,
    int? limit,
    bool? isLoading,
    List<Product>? products,
  }) => ProductsState(
    isLastPage: isLastPage ?? this.isLastPage,
    offset: offset ?? this.offset,
    limit: limit ?? this.limit,
    isLoading: isLoading ?? this.isLoading,
    products: products ?? this.products,
  );

}