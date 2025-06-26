import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scalapay_assessment/services/network/responses/search_product/search_product_response.dart';

part 'product_service.g.dart';

/// Abstract class of ProductService
@RestApi()
abstract class ProductService {
  factory ProductService(Dio dio, {String baseUrl}) = _ProductService;

  @GET("/v1/products/search")
  Future<SearchProductResponse> searchProducts(
    @Query("q") String searchQuery,
    @Query("per_page") int perPage,
    @Query("page") int page,
    @Query("sort_by") String sortBy,
    @Query("partnerId") String partnerId,
    @Query("source") String source,
    @Query("language") String language,
    @Query("country") String country, {
    @Query("minPrice") double? minPrice,
    @Query("maxPrice") double? maxPrice,
  });
}

extension ProductServiceExtension on BuildContext {
  /// Extension method used to get the [ProductService] instance
  ProductService get productService => read<ProductService>();
}
