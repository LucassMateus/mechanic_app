import 'package:mechanic_app/app/core/exceptions/service_exception.dart';
import 'package:mechanic_app/app/core/modules/user/infra/repository/i_user_repository.dart';
import './i_user_register_service.dart';

class UserRegisterDataBaseServiceImpl implements IUserRegisterService {
  UserRegisterDataBaseServiceImpl(
      {required IUserRepository userRepository})
      : _userRepository = userRepository;

  final IUserRepository _userRepository;

  @override
  Future<void> call(
      String name, String email, String user, String password) async {
    try {
      await _userRepository.register(name, email, user, password);
    } catch (e) {
      throw ServiceException(message: e.toString());
    }
  }
}
