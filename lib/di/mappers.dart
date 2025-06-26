part of 'dependency_injector.dart';

final List<SingleChildWidget> _mappers = [
  Provider<DTOMapper<ProductJTO, Product>>(
    create: (_) => const ProductMapper(),
  ),
];
