import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scalapay_assessment/exceptions/app_exception.dart';
import 'package:scalapay_assessment/models/product/product.dart';
import 'package:scalapay_assessment/repositories/mappers/product_mapper.dart';
import 'package:scalapay_assessment/repositories/product_repository.dart';
import 'package:scalapay_assessment/services/network/product/product_service.dart';
import 'package:scalapay_assessment/services/network/responses/search_product/search_product_response.dart';
import 'package:talker/talker.dart';

import '../../fixtures/requests/search_product_request_fixture_factory.dart';
import '../../fixtures/responses/search_product_response_fixture_factory.dart';

class MockProductService extends Mock implements ProductService {}

void main() {
  late ProductRepository repository;
  late MockProductService mockService;
  late ProductMapper mapper;

  // Constants for API parameters
  const String partnerId = 'scalapayappit';
  const String appId = 'trovaprezzi';
  const String countryCode = 'it';
  const String locale = 'IT';

  setUp(() {
    mockService = MockProductService();
    mapper = const ProductMapper();
    repository = ProductRepositoryImpl(
      logger: Talker(settings: TalkerSettings(enabled: false)),
      productService: mockService,
      productMapper: mapper,
    );
  });

  group('ProductRepostory.search', () {
    final request = SearchProductRequestFixture.factory().makeSingle();
    final response = SearchProductResponseFixture.factory().makeSingle();

    test('should return a list of products on a successful search', () async {
      when(
        () => mockService.searchProducts(
          request.query,
          request.perPage,
          request.page,
          '${request.sortType}:${request.sortDirection}',
          partnerId,
          appId,
          countryCode,
          locale,
          minPrice: request.minPrice,
          maxPrice: request.maxPrice,
        ),
      ).thenAnswer((_) async => response);

      final products = await repository.search(request: request);

      expect(products, isA<List>());
      expect(products.length, response.products.length);
      expect(products.first.id, response.products.firstOrNull?.id);

      verify(
        () => mockService.searchProducts(
          request.query,
          request.perPage,
          request.page,
          '${request.sortType}:${request.sortDirection}',
          partnerId,
          appId,
          countryCode,
          locale,
          minPrice: request.minPrice,
          maxPrice: request.maxPrice,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockService);
    });

    test(
      'should throw the correct exception when the service call fails',
      () async {
        when(
          () => mockService.searchProducts(
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            minPrice: any(named: 'minPrice'),
            maxPrice: any(named: 'maxPrice'),
          ),
        ).thenThrow(Exception());

        expect(
          () => repository.search(request: request),
          throwsA(isA<AppException>()),
        );
      },
    );
  });
}
