import 'package:mechanic_app/app/core/auth/infra/repository/login/user_repository.dart';
import 'package:mechanic_app/app/core/auth/domain/service/login/i_user_login_service.dart';
import 'package:mechanic_app/app/core/constants/local_storage_constants.dart';
import 'package:mechanic_app/app/core/local_storage/i_local_storage.dart';

class UserLoginServiceImpl implements IUserLoginService {
  UserLoginServiceImpl(
      {required IUserLoginRepository userRepository,
      required ILocalStorage localStorage})
      : _userRepository = userRepository,
        _localStorage = localStorage;

  final IUserLoginRepository _userRepository;
  final ILocalStorage _localStorage;

  @override
  Future<String?> call(String user, String password, bool saveLogin) async {
    final acessToken = await _userRepository.login(user, password);

    if (acessToken != null && saveLogin) {
      await _localStorage.save(LocalStorageConstants.accessToken, {
        'user': user,
        'password': password,
        'saveLogin': true,
        'token': acessToken,
      });
    }
    return acessToken;
  }
}
