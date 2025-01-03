// ignore_for_file: unused_field

import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/core/exceptions/auth_exception.dart';
import 'package:mechanic_app/app/core/modules/user/domain/models/user_model.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';

import '../../../user/domain/dtos/user_login_dto.dart';
import '../../../user/domain/service/login/i_user_login_service.dart';

class AuthController extends BaseController {
  AuthController({
    required IUserLoginService loginService,
  })  : _loginService = loginService,
        super(InitialState());

  late final UserModel userModel;
  var isLoading = false;
  final IUserLoginService _loginService;

  Future<void> login(UserLoginDto dto) async {
    try {
      update(LoadingState());
      final result = await _loginService.call(dto);
      userModel = result;

      update(const SuccessState(data: null));
    } on AuthException catch (e) {
      update(ErrorState<AuthException>(exception: e, message: e.message));
    } on Exception catch (e) {
      update(ErrorState<Exception>(exception: e));
    }
  }
}
