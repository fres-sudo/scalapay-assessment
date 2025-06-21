import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'product_service.g.dart';

/// Abstract class of ProductService
@RestApi()
abstract class ProductService {
  factory ProductService(Dio dio, {String baseUrl}) = _ProductService;

  //TODO: Add your methods
}

extension ProductServiceExtension on BuildContext {
  /// Extension method used to get the [ProductService] instance
  ProductService get productService => read<ProductService>();
}
