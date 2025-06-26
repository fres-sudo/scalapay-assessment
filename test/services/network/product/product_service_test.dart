import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:scalapay_assessment/services/network/product/product_service.dart';
import 'package:scalapay_assessment/services/network/jto/product/product_jto.dart';
import 'package:scalapay_assessment/services/network/responses/search_product/search_product_response.dart';
import 'package:scalapay_assessment/utils/constants.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late ProductService service;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: K.apiBaseUrl));
    dioAdapter = DioAdapter(dio: dio);
    service = ProductService(dio);
  });

  group('ProductService.searchProducts', () {
    const String path = '/v1/products/search';

    List<ProductJTO> sampleProducts = [
      ProductJTO(
        id: '1',
        title: 'Nike Air Max',
        description: 'Great Nike sneakers',
        brand: 'Nike',
        brandId: 'nike123',
        category: 'shoes',
        category1: 'shoes',
        category2: 'sneakers',
        discountPercentage: 10,
        hasImage: 1,
        image: 'image1.jpg',
        imageMerchant: 'image1m.jpg',
        merchant: 'Merchant1',
        merchantId: 'm1',
        affiliateUrl: 'http://nike.com/airmax',
        newOffer: true,
        listPrice: 200.0,
        selling_price: 150.0,
        tags: ['sport'],
        url: 'http://nike.com/product1',
      ),
      ProductJTO(
        id: '2',
        title: 'Nike Revolution',
        description: 'Affordable Nike sneakers',
        brand: 'Nike',
        brandId: 'nike123',
        category: 'shoes',
        category1: 'shoes',
        category2: 'sneakers',
        discountPercentage: 20,
        hasImage: 1,
        image: 'image2.jpg',
        imageMerchant: 'image2m.jpg',
        merchant: 'Merchant2',
        merchantId: 'm2',
        affiliateUrl: 'http://nike.com/revolution',
        newOffer: true,
        listPrice: 100.0,
        selling_price: 90.0,
        tags: ['running'],
        url: 'http://nike.com/product2',
      ),
    ];

    SearchProductResponse buildResponse(List<ProductJTO> products) {
      return SearchProductResponse(
        page: 1,
        found: products.length,
        groupedHits: [
          GroupedHit(hits: products.map((p) => Hit(document: p)).toList()),
        ],
      );
    }

    test('should filter products within price range', () async {
      final response = buildResponse(
        sampleProducts
            .where((p) => p.selling_price >= 80 && p.selling_price <= 160)
            .toList(),
      );
      dioAdapter.onGet(
        path,
        queryParameters: {
          'q': 'nike',
          'per_page': 30,
          'page': 1,
          'sort_by': 'selling_price:asc',
          'partnerId': 'test',
          'source': 'test',
          'language': 'en',
          'country': 'US',
          'minPrice': 80.0,
          'maxPrice': 160.0,
        },
        (server) => server.reply(200, response.toJson()),
      );

      final result = await service.searchProducts(
        'nike',
        30,
        1,
        'selling_price:asc',
        'test',
        'test',
        'en',
        'US',
        minPrice: 80.0,
        maxPrice: 160.0,
      );

      expect(
        result.groupedHits.first.hits.every(
          (hit) =>
              hit.document.selling_price >= 80 &&
              hit.document.selling_price <= 160,
        ),
        true,
      );
    });

    test('should sort products by text match desc (title)', () async {
      final sorted = [...sampleProducts]
        ..sort((a, b) => b.title.compareTo(a.title));
      final response = buildResponse(sorted);
      dioAdapter.onGet(
        path,
        queryParameters: {
          'q': 'nike',
          'per_page': 30,
          'page': 1,
          'sort_by': '_text_match:desc',
          'partnerId': 'test',
          'source': 'test',
          'language': 'en',
          'country': 'US',
        },
        (server) => server.reply(200, response.toJson()),
      );

      final result = await service.searchProducts(
        'nike',
        30,
        1,
        '_text_match:desc',
        'test',
        'test',
        'en',
        'US',
      );

      final hits = result.groupedHits.first.hits;
      expect(
        hits.first.document.title.compareTo(hits[1].document.title) >= 0,
        true,
      );
    });

    test('should sort products by selling_price asc', () async {
      final sorted = [...sampleProducts]
        ..sort((a, b) => a.selling_price.compareTo(b.selling_price));
      final response = buildResponse(sorted);
      dioAdapter.onGet(
        path,
        queryParameters: {
          'q': 'nike',
          'per_page': 30,
          'page': 1,
          'sort_by': 'selling_price:asc',
          'partnerId': 'test',
          'source': 'test',
          'language': 'en',
          'country': 'US',
        },
        (server) => server.reply(200, response.toJson()),
      );

      final result = await service.searchProducts(
        'nike',
        30,
        1,
        'selling_price:asc',
        'test',
        'test',
        'en',
        'US',
      );

      final hits = result.groupedHits.first.hits;
      expect(
        hits.first.document.selling_price <= hits[1].document.selling_price,
        true,
      );
    });

    test(
      'should return products that contain query in title or description',
      () async {
        final response = buildResponse(sampleProducts);
        dioAdapter.onGet(
          path,
          queryParameters: {
            'q': 'nike',
            'per_page': 30,
            'page': 1,
            'sort_by': '_text_match:desc',
            'partnerId': 'test',
            'source': 'test',
            'language': 'en',
            'country': 'US',
          },
          (server) => server.reply(200, response.toJson()),
        );

        final result = await service.searchProducts(
          'nike',
          30,
          1,
          '_text_match:desc',
          'test',
          'test',
          'en',
          'US',
        );

        final containsQuery = result.groupedHits.first.hits.every((hit) {
          final title = hit.document.title.toLowerCase();
          final description = hit.document.description.toLowerCase();
          return title.contains('nike') || description.contains('nike');
        });

        expect(containsQuery, true);
      },
    );
  });
}
