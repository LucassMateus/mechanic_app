import 'package:mechanic_app/app/core/modules/user/domain/models/user_model.dart';

abstract interface class IUserLoginService {
  Future<UserModel> call(String user, String password);
}
