import 'package:mechanic_app/app/core/modules/user/domain/dtos/user_login_dto.dart';
import 'package:mechanic_app/app/core/modules/user/domain/models/user_model.dart';

abstract interface class IUserLoginService {
  Future<UserModel> call(UserLoginDto dto);
}
