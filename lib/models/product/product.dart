import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

@freezed
abstract class Product with _$Product {
  const Product._();

  const factory Product({
    required String id,
    required String title,
    required String description,
    required String price,
    required String merchantBrand,
    required String installmentPrice,
    required String image,
    required bool hasImage,
    required String url,
  }) = _Product;

  factory Product.fake() => Product(
    id: "<fake_id>",
    title: "<fake_title>",
    description: "<fake_description>",
    price: "<fake_price>",
    merchantBrand: "<fake_merchantBrand>",
    installmentPrice: "<fake_installmentPrice>",
    image: "<fake_image>",
    hasImage: false,
    url: "<fake_url>",
  );
}
