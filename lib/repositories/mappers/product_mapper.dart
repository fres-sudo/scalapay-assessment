import 'package:pine/pine.dart';
import 'package:scalapay_assessment/models/product/product.dart';
import 'package:scalapay_assessment/services/network/jto/product/product_jto.dart';

class ProductMapper extends DTOMapper<ProductJTO, Product> {
  const ProductMapper();

  @override
  Product fromDTO(ProductJTO dto) => Product(
    id: dto.id,
    title: dto.title,
    description: dto.description,
    price: dto.listPrice.toStringAsFixed(2),
    merchantBrand: dto.merchant,
    installmentPrice: (dto.sellingPrice / 3).toStringAsFixed(2),
    hasImage: dto.hasImage == 1,
    image: dto.image,
    url: dto.url,
  );

  @override
  ProductJTO toDTO(Product model) => throw UnimplementedError();
}
