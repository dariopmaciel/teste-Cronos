class AppException implements Exception {
  final String? message;
  final String? prefix;

  AppException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
    : super(message, "Erro de Comunicação: ");
}

class BadRequestException extends AppException {
  BadRequestException([String? message])
    : super(message, "Requisição Inválida: ");
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message]) : super(message, "Não Autorizado: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message])
    : super(message, "Entrada Inválida: ");
}

class NoInternetException extends AppException {
  NoInternetException([String? message])
    : super(message, "Sem Conexão com a Internet: ");
}
