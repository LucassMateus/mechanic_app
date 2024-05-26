
import 'package:dio/dio.dart';

class RestException implements Exception {
  String message;
  int statusCode;
  final Response? response;
  RestException({
    required this.message,
    required this.statusCode,
    this.response,
  });

  @override
  String toString() =>
      'RestException(message: $message, statusCode: $statusCode, response: $response)';
}
