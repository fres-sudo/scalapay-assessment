import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pine/pine.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:scalapay_assessment/blocs/product/product_bloc.dart';
import 'package:scalapay_assessment/cubits/product_filters/product_filters_cubit.dart';
import 'package:scalapay_assessment/models/product/product.dart';
import 'package:scalapay_assessment/repositories/mappers/product_mapper.dart';
import 'package:scalapay_assessment/repositories/product_repository.dart';
import 'package:scalapay_assessment/services/network/jto/product/product_jto.dart';
import 'package:scalapay_assessment/services/network/product/product_service.dart';
import 'package:scalapay_assessment/services/network/requests/search_product/search_product_request.dart';
import 'package:scalapay_assessment/utils/constants.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

part 'blocs.dart';

part 'mappers.dart';

part 'providers.dart';

part 'repositories.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({super.key, required this.child});

  @override
  Widget build(BuildContext context) => DependencyInjectorHelper(
    blocs: _blocs,
    mappers: _mappers,
    providers: _providers,
    repositories: _repositories,
    child: child,
  );
}
