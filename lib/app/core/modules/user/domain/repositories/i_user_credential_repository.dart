
import 'package:mechanic_app/app/core/modules/user/domain/models/user_model.dart';

abstract interface class IUserCredentialRepository {
  Future<UserModel?> get(String key);
  Future<void> save(String key, value);
}
