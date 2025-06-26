import 'package:dio/dio.dart';
import 'package:scalapay_assessment/exceptions/app_exception.dart';
import 'package:scalapay_assessment/services/network/errors/api_error.dart';

extension DioExceptionExtension on DioException {
  AppException toAppException() {
    if (response != null && response!.data != null) {
      try {
        final apiError = ApiError.fromJson(response!.data);
        if (apiError.errors.isNotEmpty) {
          final firstError = apiError.errors.first;
          return switch (apiError.httpStatusCode) {
            400 => BadRequestException(message: firstError.message),
            401 => AuthorizationException(message: firstError.message),
            404 => NotFoundException(message: firstError.message),
            _ => ServerException(message: firstError.message),
          };
        }
      } catch (e) {
        // If parsing fails, return a generic server exception
        return ServerException(
          message:
              'Si è verificato un errore durante l\'elaborazione della richiesta.',
        );
      }
    }

    if (type == DioExceptionType.connectionError ||
        type == DioExceptionType.connectionTimeout) {
      return NetworkException(
        message:
            'Nessuna connessione internet o il server non è raggiungibile. Controlla la tua rete.',
      );
    } else if (type == DioExceptionType.receiveTimeout ||
        type == DioExceptionType.sendTimeout) {
      return NetworkException(
        message: 'Connessione scaduta. Riprova più tardi.',
      );
    } else if (type == DioExceptionType.cancel) {
      return ServerException(message: 'La richiesta è stata annullata.');
    }

    return UnknownException();
  }
}
