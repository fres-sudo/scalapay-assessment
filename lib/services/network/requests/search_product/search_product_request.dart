import 'package:pine/pine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_product_request.g.dart';

part 'search_product_request.freezed.dart';

@freezed
sealed class SearchProductRequest extends DTO with _$SearchProductRequest {
  const SearchProductRequest._() : super();

  const factory SearchProductRequest() = _SearchProductRequest;

  factory SearchProductRequest.fromJson(Map<String, dynamic> json) =>
    _$SearchProductRequestFromJson(json);
}
