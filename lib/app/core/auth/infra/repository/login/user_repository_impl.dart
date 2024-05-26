import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mechanic_app/app/core/auth/infra/repository/login/user_repository.dart';
import 'package:mechanic_app/app/core/exceptions/auth_exception.dart';
import 'package:mechanic_app/app/core/restClient/shared/rest_client.dart';

class UserLoginRepositoryImpl implements IUserLoginRepository {
  final RestClient restClient;
  UserLoginRepositoryImpl({required this.restClient});

  @override
  Future<String?> login(String login, String password) async {
    try {
      final Response(data: {'access_token': accessToken}) =
          await restClient.unauth.post('/auth', data: {
        "email": login,
        "password": password,
      });

      return accessToken;
    } on DioException catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      if (e.response?.statusCode == HttpStatus.forbidden) {
        throw AuthUnauthorizedException();
      } else {
        throw AuthError(message: 'Erro ao realizar login');
      }
    }
  }
}
