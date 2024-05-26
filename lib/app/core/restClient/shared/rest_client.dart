import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:mechanic_app/app/core/constants/rest_client_constants.dart';
import 'package:mechanic_app/app/core/restClient/interceptors/auth_interceptor.dart';

final class RestClient extends DioForNative {
  RestClient() 
      : super (
          BaseOptions(
            baseUrl: RestClientConstants.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 30)
          )
        ){
          interceptors.addAll([
            LogInterceptor(requestBody: true, responseBody: true),
            AuthInterceptor(),
          ]);
        }

  RestClient get auth{
    options.extra['DIO_AUTH_KEY'] = true;
    return this;
  }
  RestClient get unauth{
    options.extra['DIO_AUTH_KEY'] = true;
    return this;
  }
}