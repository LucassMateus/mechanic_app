sealed class AuthException implements Exception {
  final String message;

  AuthException({required this.message});

@override
String toString() {
    return 'AuthException{message=$message}';
  }
}

final class AuthError extends AuthException {
  AuthError({required super.message});

}

final class AuthUnauthorizedException extends AuthException {
  AuthUnauthorizedException() : super(message: 'Usuário não autorizado');


}