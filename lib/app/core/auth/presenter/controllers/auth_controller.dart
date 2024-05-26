import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mechanic_app/app/core/auth/domain/models/user_model.dart';
import 'package:mechanic_app/app/core/auth/domain/service/credential/i_user_fetch_saved_credential_service.dart';
import 'package:mechanic_app/app/core/auth/domain/service/credential/i_user_save_credential_service.dart';
import 'package:mechanic_app/app/core/auth/domain/service/login/i_user_login_service.dart';
import 'package:mechanic_app/app/core/constants/local_storage_constants.dart';
import 'package:mechanic_app/app/core/exceptions/service_exception.dart';

class AuthController extends ChangeNotifier {
  AuthController({
    required IUserLoginService loginService,
    required IUserFetchSavedCredentialService credentialService,
    required IUserSaveCredentialService credentialSaveService,
  })  : _loginService = loginService,
        _credentialService = credentialService,
        _credentialSaveService = credentialSaveService;

  var user = UserModel();
  // final message = Rxn<MessageModel>();
  var isLoading = false;
  final IUserLoginService _loginService;
  final IUserFetchSavedCredentialService _credentialService;
  final IUserSaveCredentialService _credentialSaveService;

  Future<void> getSavedUserCredentials() async {
    try {
      final savedUser =
          await _credentialService.call(LocalStorageConstants.userCredentials);

      // if (savedUser != null) {
      //   user.update((value) {
      //     value?.usuario = savedUser.usuario;
      //     value?.senha = savedUser.senha;
      //     value?.salvaLogin = savedUser.salvaLogin;
      //     value?.token = savedUser.token;
      //   });
      // }
    } on ServiceException catch (e, s) {
      log('Erro ao buscar usuário no Local Storage.', error: e, stackTrace: s);
    } on Exception catch (e, s) {
      log('Erro desconhecido', error: e, stackTrace: s);
    }
  }

  Future<void> login({
    required String userLogin,
    required String password,
    required bool saveLogin,
  }) async {
    try {
      final newToken = await _loginService.call(userLogin, password, saveLogin);

      final usuario = user;

      usuario.usuario = userLogin;
      usuario.senha = password;
      usuario.salvaLogin = saveLogin;
      usuario.token = newToken;

      _saveUserCredentialsLocalStorage();
    } catch (e, s) {
      log('Erro ao buscar usuário no Local Storage.', error: e, stackTrace: s);
    }
  }

  bool checkAuthRoles({required String? token, required String roleCheck}) {
    if (token == null) {
      return false;
    }

    Map<String, dynamic> payload = Jwt.parseJwt(token);
    List roles =
        payload['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];

    return roles.contains(roleCheck);
  }

  bool authenticated({required String roleCheck}) {
    final userToken = user.token;

    if (userToken != null) {
      if (!Jwt.isExpired(userToken) &&
          checkAuthRoles(token: userToken, roleCheck: roleCheck)) {
        return true;
      }
    }
    return false;
  }

  Future<void> _saveUserCredentialsLocalStorage() async {
    try {
      final credentials = user;

      final Map<String, dynamic> value = {
        'user': credentials.usuario,
        'password': credentials.senha,
        'saveLogin': credentials.salvaLogin ?? false,
        // 'token': credentials.salvaLogin ? credentials.token : null,
      };

      await _credentialSaveService.call(
          LocalStorageConstants.userCredentials, value);
    } catch (e, s) {
      log('Erro ao salvar usuário no Local Storage.', error: e, stackTrace: s);
    }
  }
}
