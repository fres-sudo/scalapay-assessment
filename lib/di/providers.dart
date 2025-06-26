part of 'dependency_injector.dart';

final List<SingleChildWidget> _providers = [
  Provider<Talker>(create: (_) => Talker()),
  if (kDebugMode)
    Provider<TalkerDioLogger>(
      create:
          (context) => TalkerDioLogger(
            talker: context.read<Talker>(),
            settings: TalkerDioLoggerSettings(printResponseData: false),
          ),
    ),
  Provider<Dio>(
    create:
        (context) => Dio(
            BaseOptions(contentType: 'application/json', baseUrl: K.apiBaseUrl),
          )
          ..interceptors.addAll([
            if (kDebugMode) context.read<TalkerDioLogger>(),
          ]),
  ),
  Provider<ProductService>(create: (context) => ProductService(context.read())),
];
