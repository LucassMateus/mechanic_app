import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/core/modules/user/domain/service/register/i_user_register_service.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';

class RegisterController extends BaseController {
  RegisterController({required IUserRegisterService registerService})
      : _registerService = registerService,
        super(InitialState());

  final IUserRegisterService _registerService;

  Future<void> registerUser(
      String name, String email, String user, String password) async {
    try {
      update(LoadingState());
      await _registerService.call(name, email, user, password);

      update(const SuccessState(data: null));
    } on Exception catch (e) {
      update(ErrorState(exception: e));
    }
  }
}
