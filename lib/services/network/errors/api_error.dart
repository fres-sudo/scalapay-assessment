import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scalapay_assessment/exceptions/app_exception.dart';

part 'api_error.freezed.dart';
part 'api_error.g.dart';

@freezed
sealed class ApiError with _$ApiError {
  const factory ApiError({
    required int httpStatusCode,
    required String? traceId,
    required String? path,
    required List<ApiErrorMessage> errors,
  }) = _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
}

@freezed
sealed class ApiErrorMessage with _$ApiErrorMessage {
  const factory ApiErrorMessage({
    required String message,
    required String code,
  }) = _ApiErrorMessage;

  factory ApiErrorMessage.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorMessageFromJson(json);
}
