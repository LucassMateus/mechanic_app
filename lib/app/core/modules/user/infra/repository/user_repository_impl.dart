import 'package:mechanic_app/app/core/modules/user/domain/models/user_model.dart';
import 'package:mechanic_app/app/core/modules/user/infra/data_source/user_data_base_dao.dart';
import '../../domain/dtos/user_login_dto.dart';
import '../../domain/repositories/i_user_repository.dart';

class UserRepositoryImpl implements IUserRepository {
  UserRepositoryImpl({required UserDataBaseDao localDAO})
      : _localDAO = localDAO;

  final UserDataBaseDao _localDAO;

  @override
  Future<void> register(UserModel user) async {
    await _localDAO.save(user);
  }

  @override
  Future<UserModel> login(UserLoginDto dto) async {
    await Future.delayed(const Duration(seconds: 2));
    return await _localDAO.login(dto);
  }
}
