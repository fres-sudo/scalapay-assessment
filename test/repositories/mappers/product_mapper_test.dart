import 'package:flutter_test/flutter_test.dart';
import 'package:scalapay_assessment/models/product/product.dart';
import 'package:scalapay_assessment/repositories/mappers/product_mapper.dart';
import 'package:scalapay_assessment/services/network/jto/product/product_jto.dart';
import '../../fixtures/jto/product_jto_fixture_factory.dart';

void main() {
  late ProductMapper mapper;
  late ProductJTO dto;
  late Product model;

  setUp(() {
    dto = ProductJTOFixture.factory().makeSingle();
    mapper = const ProductMapper();

    model = mapper.fromDTO(dto);
  });

  test('mapping Product object from ProductJTO', () {
    final result = mapper.fromDTO(dto);
    expect(result, equals(model));
  });
}
