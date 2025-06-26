import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:scalapay_assessment/services/network/responses/search_product/search_product_response.dart';

import '../jto/product_jto_fixture_factory.dart';

extension SearchProductResponseFixture on SearchProductResponse {
  static SearchProductResponseFixtureFactory factory() =>
      SearchProductResponseFixtureFactory();
}

class SearchProductResponseFixtureFactory
    extends JsonFixtureFactory<SearchProductResponse> {
  @override
  FixtureDefinition<SearchProductResponse> definition() =>
      define((faker, [int index = 0]) {
        const productsLength = 30;
        final products = ProductJTOFixture.factory().makeMany(productsLength);

        return SearchProductResponse(
          page: 1,
          found: productsLength,
          groupedHits: [
            GroupedHit(
              hits: List.generate(
                productsLength,
                (index) => Hit(document: products[index]),
              ),
            ),
          ],
        );
      });

  @override
  JsonFixtureDefinition<SearchProductResponse> jsonDefinition() =>
      defineJson((object, [int index = 0]) => object.toJson());
}
