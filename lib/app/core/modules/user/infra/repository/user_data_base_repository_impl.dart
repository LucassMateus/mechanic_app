import 'package:mechanic_app/app/core/exceptions/auth_exception.dart';
import 'package:mechanic_app/app/core/modules/user/domain/models/user_model.dart';
import '../../../../database/sqlite_connection_factory.dart';
import '../../../../exceptions/repository_exception.dart';
import './i_user_repository.dart';

class UserDataBaseRepositoryImpl implements IUserRepository {
  UserDataBaseRepositoryImpl({required SqliteConnectionFactory dbFactory})
      : _dbFactory = dbFactory;

  final SqliteConnectionFactory _dbFactory;

  @override
  Future<void> register(
      String name, String email, String user, String password) async {
    try {
      final connection = await _dbFactory.openConnection();
      await connection.insert('user', {
        'name': name,
        'userName': user,
        'email': email,
        'password': password,
        'admin': 0
      });
    } catch (e) {
      throw RepositoryException(message: 'Erro ao efetuar cadastro');
    }
  }

  @override
  Future<UserModel> login(String user, String password) async {
    await Future.delayed(const Duration(seconds: 3));
    final connection = await _dbFactory.openConnection();
    final result = await connection.rawQuery(
      '''select * 
          from user 
          where userName = ? 
            and password = ?''',
      [user, password],
    );
    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    } else {
      throw AuthUnauthorizedException();
    }
  }
}
