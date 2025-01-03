import '../../models/user_model.dart';
import '../../repositories/i_user_credential_repository.dart';
import 'i_user_fetch_saved_credential_service.dart';

class UserFetchSavedCredentialServiceImpl
    implements IUserFetchSavedCredentialService {
  UserFetchSavedCredentialServiceImpl(
      {required IUserCredentialRepository repository})
      : _repository = repository;

  final IUserCredentialRepository _repository;

  @override
  Future<UserModel?> call(String key) async {
    final response = await _repository.get(key);
    return response;
  }
}
