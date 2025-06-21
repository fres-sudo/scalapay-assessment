import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Abstract class of ProductRepository
abstract interface class ProductRepository {
  void search();
  
}

/// Implementation of the base interface ProductRepository
class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl();

  @override
  void search() {

  }

  
}

extension ProductRepositoryExtension on BuildContext {
  /// Extension method used to get the [ProductRepository] instance
  ProductRepository get productRepository => read<ProductRepository>();
}