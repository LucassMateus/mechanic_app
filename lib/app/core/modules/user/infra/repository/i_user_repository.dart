import 'package:mechanic_app/app/core/modules/user/domain/models/user_model.dart';

abstract interface class IUserRepository {
  Future<void> register(
      String name, String email, String user, String password);
  Future<UserModel> login(String login, String password);
}
