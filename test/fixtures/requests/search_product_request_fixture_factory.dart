import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:scalapay_assessment/services/network/requests/search_product/search_product_request.dart';

extension SearchProductRequestFixture on SearchProductRequest {
  static SearchProductRequestFixtureFactory factory() => SearchProductRequestFixtureFactory();
}

class SearchProductRequestFixtureFactory extends JsonFixtureFactory<SearchProductRequest> {
  @override
  FixtureDefinition<SearchProductRequest> definition() => define(
        (faker) => const SearchProductRequest(),
  );

  @override
  JsonFixtureDefinition<SearchProductRequest> jsonDefinition() => defineJson(
      (object) => {},
  );
}
