
class WrongCredentials extends CustomError {
  WrongCredentials([super.message = 'Credenciales incorrectas']);
}

class InvalidToken extends CustomError {
  InvalidToken([super.message = 'Token inválido o expirado']);
}

class ConnectionTimeout extends CustomError {
  ConnectionTimeout([super.message = 'Tiempo de espera de conexión agotado']);
}

class EmailAlreadyExists extends CustomError {
  EmailAlreadyExists([super.message = 'El email ya está registrado']);
}

class BadRequest extends CustomError {
  BadRequest([super.message = 'No pudimos completar tu registro. Inténtalo de nuevo más tarde.']);
}

class CustomError implements Exception {
  final String message;

  CustomError(this.message);

  @override
  String toString() => message;
}