import 'package:pine/pine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scalapay_assessment/services/network/jto/product/product_jto.dart';

part 'search_product_response.g.dart';

part 'search_product_response.freezed.dart';

@freezed
abstract class SearchProductResponse extends DTO with _$SearchProductResponse {
  const SearchProductResponse._() : super();

  const factory SearchProductResponse({
    required int page,
    required int found,
    @JsonKey(name: 'grouped_hits') required List<GroupedHit> groupedHits,
  }) = _SearchProductResponse;

  factory SearchProductResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchProductResponseFromJson(json);
}

@freezed
sealed class GroupedHit with _$GroupedHit {
  const factory GroupedHit({required List<Hit> hits}) = _GroupedHit;

  factory GroupedHit.fromJson(Map<String, dynamic> json) =>
      _$GroupedHitFromJson(json);
}

@freezed
sealed class Hit with _$Hit {
  const factory Hit({
    required ProductJTO document,
    bool? isMerchantCard,
    String? merchantToken,
  }) = _Hit;

  factory Hit.fromJson(Map<String, dynamic> json) => _$HitFromJson(json);
}
