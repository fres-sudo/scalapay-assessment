import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pine/pine.dart';
import 'package:provider/provider.dart';
import 'package:scalapay_assessment/models/product/product.dart';
import 'package:scalapay_assessment/services/network/jto/product/product_jto.dart';
import 'package:scalapay_assessment/services/network/product/product_service.dart';
import 'package:scalapay_assessment/services/network/requests/search_product/search_product_request.dart';
import 'package:talker/talker.dart';

/// Abstract class of ProductRepository
abstract interface class ProductRepository {
  Future<List<Product>> search({required SearchProductRequest request});
}

/// Implementation of the base interface ProductRepository
class ProductRepositoryImpl implements ProductRepository {
  final ProductService productService;
  final DTOMapper<ProductJTO, Product> productMapper;
  final Talker logger;

  const ProductRepositoryImpl({
    required this.logger,
    required this.productService,
    required this.productMapper,
  });

  @override
  Future<List<Product>> search({required SearchProductRequest request}) async {
    try {
      logger.info(
        '[ProductRepository] Searching products with request: $request',
      );
      final response = await productService.searchProducts(
        request.query,
        request.perPage,
        request.page,
        '${request.sortType}:${request.sortDirection}',
        'scalapayappit',
        'trovaprezzi',
        'it',
        'IT',
        minPrice: request.minPrice,
        maxPrice: request.maxPrice,
        filterBy: request.filterBy,
      );
      logger.info('[ProductRepository] Found ${response.found} products');
      return response.groupedHits
          .map(
            (g) =>
                g.hits.map((h) => productMapper.fromDTO(h.document)).toList(),
          )
          .expand((x) => x)
          .toList();
    } on DioException catch (error, stackTrace) {
      logger.error(
        '[ProductRepository] Error while searching products',
        error,
        stackTrace,
      );
      rethrow;
    } catch (error, stackTrace) {
      logger.error(
        '[ProductRepository] Error while searching products',
        error,
        stackTrace,
      );
      rethrow;
    }
  }
}

extension ProductRepositoryExtension on BuildContext {
  /// Extension method used to get the [ProductRepository] instance
  ProductRepository get productRepository => read<ProductRepository>();
}
