import 'package:mechanic_app/app/core/auth/domain/models/user_model.dart';

abstract interface class IUserFetchSavedCredentialService {
  Future<UserModel?> call(String key);
}
