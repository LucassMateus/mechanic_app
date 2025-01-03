// ignore_for_file: unused_field
import 'package:mechanic_app/app/core/local_storage/i_local_storage.dart';
import 'package:mechanic_app/app/core/modules/user/domain/models/user_model.dart';

import '../../dtos/user_login_dto.dart';
import '../../repositories/i_user_repository.dart';
import 'i_user_login_service.dart';

class UserLoginServiceImpl implements IUserLoginService {
  UserLoginServiceImpl(
      {required IUserRepository userRepository,
      required ILocalStorage localStorage})
      : _userRepository = userRepository,
        _localStorage = localStorage;

  final IUserRepository _userRepository;
  final ILocalStorage _localStorage;

  @override
  Future<UserModel> call(UserLoginDto dto) async {
    final result = await _userRepository.login(dto);
    return result;
  }
}
