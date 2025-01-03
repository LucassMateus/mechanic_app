import 'package:mocktail/mocktail.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class MockDatabase extends Mock implements Database {
  MockDatabase() {
    when(() => query(any())).thenAnswer((_) async => []);
    when(() => insert(any(), any())).thenAnswer((_) async => 1);
    when(() => update(any(), any())).thenAnswer((_) async => 1);
    when(() => delete(any())).thenAnswer((_) async => 1);
    when(() => close()).thenAnswer((_) async => _);
  }
}
