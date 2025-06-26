import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scalapay_assessment/services/network/requests/search_product/search_product_request.dart';

/// The ProductFiltersCubit
class ProductFiltersCubit extends Cubit<SearchProductRequest> {
  /// Create a new instance of [ProductFiltersCubit].
  ProductFiltersCubit() : super(const SearchProductRequest(query: 'all'));

  /// Method used to perform the [filter] action
  FutureOr<void> filter({required SearchProductRequest request}) {
    emit(request);
  }
}

extension ProductFiltersCubitExtension on BuildContext {
  /// Extension method used to get the [ProductFiltersCubit] instance
  ProductFiltersCubit get productFiltersCubit => read<ProductFiltersCubit>();

  /// Extension method used to watch the [] instance
  ProductFiltersCubit get watchProductFiltersCubit =>
      watch<ProductFiltersCubit>();
}
