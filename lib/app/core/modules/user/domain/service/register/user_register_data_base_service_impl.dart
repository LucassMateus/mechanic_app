import 'package:mechanic_app/app/core/modules/user/domain/dtos/user_register_dto.dart';
import 'package:mechanic_app/app/core/modules/user/domain/models/user_model.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

import '../../repositories/i_user_repository.dart';
import './i_user_register_service.dart';

class UserRegisterDataBaseServiceImpl implements IUserRegisterService {
  UserRegisterDataBaseServiceImpl({required IUserRepository userRepository})
      : _userRepository = userRepository;

  final IUserRepository _userRepository;

  @override
  Future<void> call(UserRegisterDto dto) async {
    final userModel = MapperService().toEntity<UserModel, UserRegisterDto>(dto);

    await _userRepository.register(userModel);
  }
}
