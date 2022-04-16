import 'package:organize_more/core/services/packages/contracts/sqlite_connection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'sqlite_expense_implementation.dart';
import 'dart:io';

class SqliteConnectionImplementation implements SqliteConnection {
  static const String _databaseName = 'organize.db';
  static const int _databaseVersion = 1;

  SqliteConnectionImplementation._privateConstructor();

  static final SqliteConnectionImplementation instance =
      SqliteConnectionImplementation._privateConstructor();

  static Database? _database;

  // Criando o banco de dados.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  // Inicializando o banco de dadaos.
  @override
  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + _databaseName;
    var database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );
    return database;
  }

  @override
  Future<void> onCreate(Database database, int version) async {
    await database.execute(SqliteExpenseImplementation.createTableExpense);
  }

  //  Atualização de versão do banco.
  @override
  Future<void> onUpgrade(
      Database database, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      database.execute('INSERIR A QUERY AQUI');
    } else {
      throw Exception('Falha na atualização de versão do banco!');
    }
  }
}
