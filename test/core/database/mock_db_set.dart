import 'package:mocktail/mocktail.dart';
import 'package:sqflite_entity_mapper_orm/sqflite_entity_mapper_orm.dart';

class MockDbSet<T> extends Mock implements DbSet<T> {
  MockDbSet() {
    when(() => findAll()).thenAnswer((_) async => <T>[]);
    // when(() => insert(any<T>())).thenAnswer(
    //     (invocation) async => invocation.positionalArguments[0] as T);
  }
}
