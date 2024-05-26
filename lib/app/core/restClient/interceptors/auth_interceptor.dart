import 'package:dio/dio.dart';
import 'package:mechanic_app/app/core/constants/local_storage_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class AuthInterceptor extends Interceptor{
  
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

    final RequestOptions(:headers, :extra) = options;

    const authHeaderKey = 'Authorization';
    headers.remove(authHeaderKey);

    if(extra case{'DIO_AUTH_KEY' : true}){
      final sp = await SharedPreferences.getInstance();
      headers.addAll({
        authHeaderKey: 'Bearer ${sp.getString(LocalStorageConstants.accessToken)}'
      });
    }
    handler.next(options);
    // onRequest(options, handler);
    
  }
}