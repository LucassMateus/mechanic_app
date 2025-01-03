import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqflite.dart';

import 'mock_database.dart';

class MockDatabaseFactory extends Mock implements DatabaseFactory {
  final database = MockDatabase();

  MockDatabaseFactory() {
    when(() => openDatabase(any())).thenAnswer((_) async => database);
  }
}
