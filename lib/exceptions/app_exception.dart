sealed class AppException extends Error {
  final String message;

  AppException({required this.message});
}

class BadRequestException extends AppException {
  BadRequestException({required super.message});
}

class NetworkException extends AppException {
  NetworkException({required super.message});
}

class ServerException extends AppException {
  ServerException({required super.message});
}

class AuthorizationException extends AppException {
  AuthorizationException({required super.message});
}

class NotFoundException extends AppException {
  NotFoundException({required super.message});
}

class UnknownException extends AppException {
  UnknownException({
    super.message =
        'Si è verificato un errore inaspettato, per favore riprovare.',
  });
}
