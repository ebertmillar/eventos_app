class EventNotFound extends CustomError {
  EventNotFound([super.message = 'El evento solicitado no se ha existe']);
}

class ServerError extends CustomError {
  ServerError([super.message = 'Ocurrió un error en el servidor']);
}

class UnauthorizedAccess extends CustomError {
  UnauthorizedAccess([super.message = 'No tienes autorización para realizar esta acción']);
}

class ConnectionTimeout extends CustomError {
  ConnectionTimeout([super.message = 'Tiempo de espera agotado al conectarse al servidor']);
}

class UnknownError extends CustomError {
  UnknownError([super.message = 'Ocurrió un error desconocido']);
}

class BadRequest extends CustomError {
  BadRequest([super.message = 'No se pudo procesar la solicitud']);
}

class CustomError implements Exception {
  final String message;

  CustomError(this.message);

  @override
  String toString() => message;
}