import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:scalapay_assessment/services/network/product/product_service.dart';

/// Test case for the class ProductService
void main() {
  late Dio dio;
  late DioAdapter dioAdapter;

  late ProductService service;

  setUp(() {
    dio = Dio(BaseOptions());
    dioAdapter = DioAdapter(dio: dio);

    service = ProductService(dio);
  });

  //TODO: Test your methods
}