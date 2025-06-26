part of 'product_bloc.dart';

@freezed
sealed class ProductState with _$ProductState {
  const factory ProductState.initial() = InitialProductState;

  const factory ProductState.loading() = LoadingProductState;

  const factory ProductState.success({required List<Product> products}) =
      SuccessProductState;

  const factory ProductState.empty() = EmptyProductState;

  const factory ProductState.error() = ErrorProductState;
}
