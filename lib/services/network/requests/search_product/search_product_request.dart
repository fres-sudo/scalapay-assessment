import 'package:pine/pine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_product_request.g.dart';

part 'search_product_request.freezed.dart';

@freezed
sealed class SearchProductRequest extends DTO with _$SearchProductRequest {
  const SearchProductRequest._() : super();

  const factory SearchProductRequest({
    @Default("all") String query,
    @Default(30) int perPage,
    @Default(1) int page,
    @Default('_text_match') String sortType,
    @Default('desc') String sortDirection,
    double? minPrice,
    double? maxPrice,
  }) = _SearchProductRequest;

  factory SearchProductRequest.empty() =>
      const SearchProductRequest(query: 'all');

  factory SearchProductRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchProductRequestFromJson(json);
}
