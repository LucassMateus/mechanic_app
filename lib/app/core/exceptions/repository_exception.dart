class RepositoryException implements Exception {
  String message;
  RepositoryException({required this.message});

  @override
  String toString() => 'RepositoryException(message: $message)';
}
