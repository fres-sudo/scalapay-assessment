part of 'dependency_injector.dart';

final List<BlocProvider> _blocs = [
  BlocProvider<ProductBloc>(
    create:
        (context) =>
            ProductBloc(productRepository: context.read())
              ..search(request: SearchProductRequest.empty()),
  ),
  BlocProvider<ProductFiltersCubit>(create: (_) => ProductFiltersCubit()),
];
