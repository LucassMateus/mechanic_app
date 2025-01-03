import 'package:mechanic_app/app/core/modules/user/domain/models/user_model.dart';

import '../dtos/user_login_dto.dart';

abstract interface class IUserRepository {
  Future<void> register(UserModel user);
  Future<UserModel> login(UserLoginDto dto);
}
