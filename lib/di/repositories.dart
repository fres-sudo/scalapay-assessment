part of 'dependency_injector.dart';

final List<RepositoryProvider> _repositories = [
  RepositoryProvider<ProductRepository>(
    create:
        (context) => ProductRepositoryImpl(
          productService: context.read(),
          productMapper: context.read(),
        ),
  ),
];
