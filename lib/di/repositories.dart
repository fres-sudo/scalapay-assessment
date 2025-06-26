part of 'dependency_injector.dart';

final List<RepositoryProvider> _repositories = [
  RepositoryProvider<ProductRepository>(
    create:
        (context) => ProductRepositoryImpl(
          logger: context.read(),
          productService: context.read(),
          productMapper: context.read(),
        ),
  ),
];
