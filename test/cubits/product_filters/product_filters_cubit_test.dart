import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scalapay_assessment/cubits/product_filters/product_filters_cubit.dart';
import 'package:scalapay_assessment/services/network/requests/search_product/search_product_request.dart';

import '../../fixtures/requests/search_product_request_fixture_factory.dart';

void main() {
  late ProductFiltersCubit cubit;

  setUp(() {
    cubit = ProductFiltersCubit();
  });

  /// Testing the method [filter]
  group('when the method filter is called', () {
    final request = SearchProductRequestFixture.factory().makeSingle();

    blocTest<ProductFiltersCubit, SearchProductRequest>(
      'test that ProductFiltersCubit emits the correct SearchProductRequest when filter is called',
      build: () => cubit,
      act: (cubit) => cubit.filter(request: request),
      expect: () => <SearchProductRequest>[request],
      verify: (cubit) {
        expect(cubit.state.query, request.query);
        expect(cubit.state, request);
      },
    );
  });
}
