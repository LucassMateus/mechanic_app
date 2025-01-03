import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/core/modules/user/domain/service/register/i_user_register_service.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';

import '../../../user/domain/dtos/user_register_dto.dart';

class RegisterController extends BaseController {
  RegisterController({required IUserRegisterService registerService})
      : _registerService = registerService,
        super(InitialState());

  final IUserRegisterService _registerService;

  Future<void> registerUser(UserRegisterDto dto) async {
    try {
      update(LoadingState());
      await Future.delayed(const Duration(seconds: 2));
      await _registerService.call(dto);

      update(const SuccessState(data: null));
    } on Exception catch (e) {
      update(ErrorState(
        exception: e,
        message:
            'Erro ao registrar usuário. Por favor tente novamente! ${e.toString()}',
      ));
    }
  }
}
