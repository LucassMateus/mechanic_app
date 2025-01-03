import 'package:mechanic_app/app/core/database/app_db_context.dart';
import 'package:mechanic_app/app/core/exceptions/auth_exception.dart';
import 'package:mechanic_app/app/core/modules/user/domain/models/user_model.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

import '../../domain/dtos/user_login_dto.dart';

class UserDataBaseDao extends SqliteGenericRepository<UserModel> {
  UserDataBaseDao({required AppDbContext dbContext})
      : super(dbSet: dbContext.users);

  // Future<void> register(UserModel user) async => await super.save(user);

  Future<UserModel> login(UserLoginDto dto) async {
    final result = await super.dbSet.findFirstOrNull(
      'user = ? and password = ?',
      [dto.userName, dto.password],
    );

    if (result == null) {
      throw AuthUnauthorizedException();
    }

    return result;
  }
}
