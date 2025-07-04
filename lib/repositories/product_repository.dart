import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pine/pine.dart';
import 'package:provider/provider.dart';
import 'package:scalapay_assessment/exceptions/app_exception.dart';
import 'package:scalapay_assessment/exceptions/extension.dart';
import 'package:scalapay_assessment/models/product/product.dart';
import 'package:scalapay_assessment/services/network/jto/product/product_jto.dart';
import 'package:scalapay_assessment/services/network/product/product_service.dart';
import 'package:scalapay_assessment/services/network/requests/search_product/search_product_request.dart';
import 'package:scalapay_assessment/services/network/responses/search_product/search_product_response.dart';
import 'package:scalapay_assessment/utils/constants.dart';
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
        K.partnerId,
        K.source,
        K.language,
        K.country,
        minPrice: request.minPrice,
        maxPrice: request.maxPrice,
      );
      logger.info('[ProductRepository] Found ${response.found} products');
      return productMapper
          .fromDTOMany(response.products)
          .toList(growable: false);
    } on DioException catch (error, stackTrace) {
      logger.error(
        '[ProductRepository] Error while searching products',
        error,
        stackTrace,
      );
      throw error.toAppException();
    } catch (error, stackTrace) {
      logger.error(
        '[ProductRepository] Error while searching products',
        error,
        stackTrace,
      );
      throw UnknownException();
    }
  }
}

extension ProductRepositoryExtension on BuildContext {
  /// Extension method used to get the [ProductRepository] instance
  ProductRepository get productRepository => read<ProductRepository>();
}
