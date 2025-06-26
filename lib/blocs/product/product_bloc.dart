import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scalapay_assessment/models/product/product.dart';
import 'package:scalapay_assessment/repositories/product_repository.dart';
import 'package:scalapay_assessment/services/network/requests/search_product/search_product_request.dart';

part 'product_event.dart';

part 'product_state.dart';

part 'product_bloc.freezed.dart';

/// The ProductBloc
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  /// Create a new instance of [ProductBloc].
  ProductBloc({required this.productRepository})
    : super(const ProductState.initial()) {
    on<SearchProductEvent>(_onSearch);
  }

  /// Method used to add the [SearchProductEvent] event
  void search({required SearchProductRequest request}) =>
      add(ProductEvent.search(request));

  FutureOr<void> _onSearch(
    SearchProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductState.loading());

    try {
      final products = await productRepository.search(request: event.request);
      if (products.isEmpty) {
        emit(const ProductState.empty());
      } else {
        emit(ProductState.success(products: products));
      }
    } catch (e) {
      emit(ProductState.error());
    }
  }
}

extension ProductBlocExtension on BuildContext {
  /// Extension method used to get the [ProductBloc] instance
  ProductBloc get productBloc => read<ProductBloc>();

  /// Extension method used to watch the [ProductBloc] instance
  ProductBloc get watchProductBloc => watch<ProductBloc>();
}
