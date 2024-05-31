import 'package:sqflite/sqflite.dart';

abstract interface class IMigration {
  void create(Batch batch);
  void update(Batch update);
}