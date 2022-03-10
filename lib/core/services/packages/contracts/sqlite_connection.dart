import 'package:sqflite/sqflite.dart';

abstract class SqliteConnection {
  Future<void> onCreate(Database database, int version);
  Future<Database> initDatabase();
}
