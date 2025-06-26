// ignore_for_file: invalid_annotation_target

import 'package:pine/pine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_jto.g.dart';

part 'product_jto.freezed.dart';

@freezed
abstract class ProductJTO extends DTO with _$ProductJTO {
  const ProductJTO._() : super();

  const factory ProductJTO({
    @JsonKey(name: 'affiliate_url') required String affiliateUrl,
    required String brand,
    @JsonKey(name: 'brandId') required String brandId,
    required String category,
    @JsonKey(name: 'category_1') required String category1,
    @JsonKey(name: 'category_2') required String category2,
    required String description,
    @JsonKey(name: 'discount_percentage') required int discountPercentage,
    @JsonKey(name: 'has_image') required int hasImage,
    required String id,
    required String image,
    @JsonKey(name: 'image_merchant') required String imageMerchant,
    @JsonKey(name: 'list_price') required double listPrice,
    required String merchant,
    @JsonKey(name: 'merchantId') required String merchantId,
    @JsonKey(name: 'new_offer') required bool newOffer,
    @JsonKey(name: 'selling_price') required double sellingPrice,
    required List<String> tags,
    required String title,
    required String url,
  }) = _ProductJTO;

  factory ProductJTO.fromJson(Map<String, dynamic> json) =>
      _$ProductJTOFromJson(json);
}
