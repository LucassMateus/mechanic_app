class ServiceException implements Exception {
  String message;
  ServiceException({required this.message});

  @override
  String toString() => 'RestException(message: $message)';
}
