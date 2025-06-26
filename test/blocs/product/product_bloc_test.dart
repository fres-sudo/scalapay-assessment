import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scalapay_assessment/blocs/product/product_bloc.dart';
import 'package:scalapay_assessment/repositories/product_repository.dart';

import '../../fixtures/models/product_fixture_factory.dart';
import '../../fixtures/requests/search_product_request_fixture_factory.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late ProductBloc bloc;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    bloc = ProductBloc(productRepository: mockRepository);
  });

  /// Testing the event [SearchProductEvent]
  group('when the event SearchProductEvent is added to the BLoC', () {
    final products = ProductFixture.factory().makeMany(30);
    final request = SearchProductRequestFixture.factory().makeSingle();

    blocTest<ProductBloc, ProductState>(
      'handle ProductState.success when search is called',
      build: () => bloc,
      setUp:
          () => when(
            () => mockRepository.search(request: request),
          ).thenAnswer((_) async => products),
      act: (bloc) => bloc.search(request: request),
      skip: 1,
      expect: () => <ProductState>[ProductState.success(products: products)],
    );

    blocTest<ProductBloc, ProductState>(
      'handle ProductState.empy when there is no search result',
      build: () => bloc,
      setUp:
          () => when(
            () => mockRepository.search(request: request),
          ).thenAnswer((_) async => []),
      act: (bloc) => bloc.search(request: request),
      skip: 1,
      expect: () => <ProductState>[ProductState.empty()],
    );

    blocTest<ProductBloc, ProductState>(
      'handle ProductState.error when there is an error during search',
      build: () => bloc,
      setUp:
          () => when(
            () => mockRepository.search(request: request),
          ).thenThrow(Error()),
      act: (bloc) => bloc.search(request: request),
      skip: 1,
      expect: () => <ProductState>[ProductState.error()],
    );
  });
}
