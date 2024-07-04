// ignore_for_file: unused_field

import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/core/exceptions/auth_exception.dart';
import 'package:mechanic_app/app/core/modules/user/domain/models/user_model.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';

import '../../../user/domain/service/login/i_user_login_service.dart';

class AuthController extends BaseController {
  AuthController({
    required IUserLoginService loginService,
    // required IUserFetchSavedCredentialService credentialService,
    // required IUserSaveCredentialService credentialSaveService,
  })  : _loginService = loginService,
        super(InitialState());

  // _credentialService = credentialService;
  // _credentialSaveService = credentialSaveService;

  var userModel = UserModel();
  var isLoading = false;
  final IUserLoginService _loginService;

  // final IUserFetchSavedCredentialService _credentialService;
  // final IUserSaveCredentialService _credentialSaveService;

  Future<void> login(String user, String password) async {
    try {
      update(LoadingState());
      final result = await _loginService.call(user, password);
      userModel = result;
      // throw RepositoryException(message: 'Erro ao realizar login');
      update(const SuccessState(data: null));
    } on AuthException catch (e) {
      update(ErrorState<AuthException>(exception: e));
    } on Exception catch (e) {
      update(ErrorState<Exception>(exception: e));
    }
  }
}
