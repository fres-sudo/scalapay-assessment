import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:scalapay_assessment/services/network/requests/search_product/search_product_request.dart';

extension SearchProductRequestFixture on SearchProductRequest {
  static SearchProductRequestFixtureFactory factory() =>
      SearchProductRequestFixtureFactory();
}

class SearchProductRequestFixtureFactory
    extends JsonFixtureFactory<SearchProductRequest> {
  @override
  FixtureDefinition<SearchProductRequest> definition() => define(
    (faker, [int index = 0]) => SearchProductRequest(
      query: faker.lorem.word(),
      perPage: faker.randomGenerator.integer(50, min: 10),
      page: faker.randomGenerator.integer(10, min: 1),
      sortType: 'sellingPrice',
      sortDirection: 'asc',
      minPrice: faker.randomGenerator.decimal(min: 10),
      maxPrice: faker.randomGenerator.decimal(min: 101),
    ),
  );

  @override
  JsonFixtureDefinition<SearchProductRequest> jsonDefinition() =>
      defineJson((object, [int index = 0]) => object.toJson());
}
